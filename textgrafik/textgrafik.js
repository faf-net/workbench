/* textgrafik.js — Textgrafik im Stil von Third Bloc, ohne Abhängigkeiten (Browser, Leinwand 2D).
   Fünf Regeln, die das Aussehen tragen (Herleitung: SKILL.md):
     1. erst mit Licht malen, dann rastern — die Szene ist eine gewöhnliche Leinwand mit Verläufen und Schatten
     2. wenige Töne je Material, zwischen den zwei nächsten ein geordnetes 4×4-Bayer-Raster
     3. jeder Bildpunkt ein Zeichen mit Fuge, nicht nahtlos
     4. dunkle Töne als helle Punktkörnung, nicht als mattes Grau (nur auf dunklem Grund)
     5. was leuchtet, in eine eigene Lichtebene; weichgezeichnet und additiv darüber
   Schrift gehört scharf über das Ergebnis, nicht in die Szene.

   Gebrauch:
     const tg = Textgrafik.erzeuge({ spalten: 320, zeilen: 200, palette: Textgrafik.PALETTEN.workbench });
     // tg.szene / tg.licht: Leinwände in spalten×zeilen × tg.aufloesung — darauf malen
     tg.zeichne(zielLeinwand, s);   // s = Gerätepixel je Zeichen (ganzzahlig); Leinwand wird spalten*s × zeilen*s
   Für fertige Bilder (Logo, Foto): Textgrafik.ausBild(img, { spalten: 300 }) → { tg, zeichne(ziel, s, t) } */
(function (root) {
  'use strict';
  var BAYER = [0, 8, 2, 10, 12, 4, 14, 6, 3, 11, 1, 9, 15, 7, 13, 5];

  function hex(h) { h = h.replace('#', ''); return [parseInt(h.slice(0, 2), 16), parseInt(h.slice(2, 4), 16), parseInt(h.slice(4, 6), 16)]; }
  function leinwand(w, h) { var c = document.createElement('canvas'); c.width = w; c.height = h; return c; }
  function pack(r, g, b, a) { return ((a == null ? 255 : a) << 24) | (b << 16) | (g << 8) | r; }
  function hell(c) { return (c[0] * .3 + c[1] * .59 + c[2] * .11) / 255; }

  // Tonleitern. workbench: warmer Grund, ein lauter Akzent (Bernstein), übrige Töne gedämpft-erdig (Design System „Workbench“).
  var PALETTEN = {
    workbench: [
      '0d0c0b', '151413', '1a1918', '232120', '2b2827', '3a3634', '4f4a46', '6f6961', 'a49c90', 'e9e3d8', 'f5f1eb',   // Grund → Schrift
      '3e2a1c', '6b4a30', '9a6b45', 'cc9166', 'e3b48e', 'f3d6bb',                                                  // Bernstein
      '2a3020', '4a5638', '6e7d52', '93a373', 'bccaa0',                                                            // Salbei
      '1f2a33', '3a4c5a', '5a7385', '7d97ab', 'a9bfcf',                                                            // Stahl
      '3a3016', '6a5a26', '9a843c', 'c7a854', 'e4cd85',                                                            // Gold
      '3a1f1b', '6a3a33', '9a5b50', 'c07f73', 'deaca2'                                                             // Rosé
    ]
  };

  // Dieselben Tonleitern als Tokens im Design System (`textgrafik-<leiter>-<stufe>`, dunkel → hell). Steht auf der Seite
  // das tokens.css von Workbench, liest paletteAusCss() sie von dort; sonst null, dann gilt PALETTEN.workbench.
  var LEITERN = { grund: 11, bernstein: 6, salbei: 5, stahl: 5, gold: 5, rose: 5 };
  function paletteAusCss(el) {
    if (typeof getComputedStyle === 'undefined') return null;
    var cs = getComputedStyle(el || document.documentElement), p = [];
    for (var n in LEITERN) for (var i = 1; i <= LEITERN[n]; i++) {
      var v = cs.getPropertyValue('--textgrafik-' + n + '-' + i).trim();
      if (!/^#[0-9a-f]{6}$/i.test(v)) return null;
      p.push(v.slice(1).toLowerCase());
    }
    return p;
  }

  // k-Means über die deckenden Bildpunkte einer Leinwand (Verfahren für Logos): n Töne
  function paletteAusLeinwand(c, n) {
    var d = c.getContext('2d').getImageData(0, 0, c.width, c.height).data, px = [];
    for (var i = 0; i < d.length; i += 4) if (d[i + 3] > 200) px.push([d[i], d[i + 1], d[i + 2]]);
    if (!px.length) return ['000000'];
    px.sort(function (a, b) { return hell(a) - hell(b); });                  // Startwerte über die Helligkeit verteilt
    var z = [];
    for (var k = 0; k < n; k++) z.push(px[Math.floor((k + .5) * px.length / n)].slice());
    for (var it = 0; it < 15; it++) {
      var sum = z.map(function () { return [0, 0, 0, 0]; });
      for (var j = 0; j < px.length; j += 2) {
        var q = px[j], bi = 0, bd = Infinity;
        for (var m = 0; m < z.length; m++) { var dd = (q[0] - z[m][0]) * (q[0] - z[m][0]) + (q[1] - z[m][1]) * (q[1] - z[m][1]) + (q[2] - z[m][2]) * (q[2] - z[m][2]); if (dd < bd) { bd = dd; bi = m; } }
        sum[bi][0] += q[0]; sum[bi][1] += q[1]; sum[bi][2] += q[2]; sum[bi][3]++;
      }
      z = z.map(function (zz, m) { return sum[m][3] ? [sum[m][0] / sum[m][3], sum[m][1] / sum[m][3], sum[m][2] / sum[m][3]] : zz; });
    }
    return z.map(function (c) { return c.map(function (v) { return ('0' + Math.round(v).toString(16)).slice(-2); }).join(''); });
  }

  /* o: spalten, zeilen, palette (Hex-Liste), grund ('0d0c0b' oder null = durchsichtig), aufloesung (Szene je Zeichen, 2),
        fuge (Anteil der Zeichenfarbe in der Fuge, .35), fugeArt ('grund': Fuge zum Grund hin gemischt — auf dunklem Grund;
        'dunkel': Fuge eine Stufe dunkler als das Zeichen — auf hellem oder durchsichtigem Grund; Vorgabe nach Grund),
        koernung (true auf dunklem Grund),
        dunkel (Helligkeit 0…255, unter der ein Ton Körnung wird, 80), licht ({ stark: .55, weit: .45 } oder false),
        lichtAuto (Schwelle 0…1: helle Bildpunkte leuchten von selbst, z. B. .85; Vorgabe aus) */
  function erzeuge(o) {
    var CW = o.spalten, CH = o.zeilen, A = o.aufloesung || 2;
    var grund = o.grund === undefined ? '0d0c0b' : o.grund, G = grund ? hex(grund) : null;
    var koernung = o.koernung != null ? o.koernung : (G ? hell(G) < .3 : false);
    var dunkel = o.dunkel || 80, fugeAnteil = o.fuge != null ? o.fuge : .35;
    var fugeArt = o.fugeArt || (G && hell(G) < .5 ? 'grund' : 'dunkel');   // helle Fugen auf hellem Grund machen alles blass
    var licht = o.licht === false ? null : (o.licht || { stark: .55, weit: .45 });
    var PAL, TON, QC = new Map();
    function setzePalette(p) {                                            // der Grund gehört immer dazu, sonst fällt er auf den nächsten Bildton
      PAL = p.map(hex);
      if (G && !PAL.some(function (c) { return Math.abs(c[0] - G[0]) + Math.abs(c[1] - G[1]) + Math.abs(c[2] - G[2]) < 12; })) PAL.push(G.slice());
    }
    setzePalette(o.palette);
    var GP = G ? pack(G[0], G[1], G[2]) : 0;
    function toene() {
      TON = PAL.map(function (c) {
        var v = Math.max(c[0], c[1], c[2]), k = v ? Math.min(2.2, 200 / v) : 1;
        var fuge = fugeArt === 'grund' ? c.map(function (x, i) { return Math.round(x * fugeAnteil + G[i] * (1 - fugeAnteil)); })
                                       : c.map(function (x) { return Math.round(x * (1 - fugeAnteil * (1 - hell(c) * .7))); });   // helle Töne: schwache Fuge, sonst wird Creme grau
        return {
          v: v, voll: pack(c[0], c[1], c[2]), fuge: pack(fuge[0], fuge[1], fuge[2]),
          punkt: pack.apply(null, c.map(function (x) { return Math.min(255, Math.round(x * k)); })),
          grund: G && Math.abs(c[0] - G[0]) + Math.abs(c[1] - G[1]) + Math.abs(c[2] - G[2]) < 12
        };
      });
    }
    toene();
    function quant(r, g, b) {                                             // → [Ton a, Ton b, Anteil b × 16]
      var key = (r >> 2 << 12) | (g >> 2 << 6) | (b >> 2), q = QC.get(key);
      if (q) return q;
      var a = 0, bb = 0, da = Infinity, db = Infinity;
      for (var i = 0; i < PAL.length; i++) {
        var p = PAL[i], d = (p[0] - r) * (p[0] - r) * .3 + (p[1] - g) * (p[1] - g) * .59 + (p[2] - b) * (p[2] - b) * .11;
        if (d < da) { db = da; bb = a; da = d; a = i; } else if (d < db) { db = d; bb = i; }
      }
      var X = PAL[a], Y = PAL[bb], l2 = (Y[0] - X[0]) * (Y[0] - X[0]) + (Y[1] - X[1]) * (Y[1] - X[1]) + (Y[2] - X[2]) * (Y[2] - X[2]) || 1;
      var t = ((r - X[0]) * (Y[0] - X[0]) + (g - X[1]) * (Y[1] - X[1]) + (b - X[2]) * (Y[2] - X[2])) / l2;
      q = [a, bb, Math.max(0, Math.min(1, t)) * 16];
      QC.set(key, q);
      return q;
    }

    var szene = leinwand(CW * A, CH * A), lichtE = leinwand(CW * A, CH * A), klein = leinwand(CW, CH);
    var B1 = leinwand(Math.ceil(CW / 2), Math.ceil(CH / 2)), B2 = leinwand(Math.ceil(CW / 4), Math.ceil(CH / 4)), B0 = leinwand(CW, CH);
    var aus = null, aus32 = null, ausS = 0;

    function zeichne(ziel, s) {
      s = Math.max(2, s | 0);
      if (ziel.width !== CW * s || ziel.height !== CH * s) { ziel.width = CW * s; ziel.height = CH * s; }
      var zc = ziel.getContext('2d');
      if (ausS !== s) { aus = zc.createImageData(CW * s, CH * s); aus32 = new Uint32Array(aus.data.buffer); ausS = s; }
      var kc = klein.getContext('2d');
      kc.clearRect(0, 0, CW, CH); kc.imageSmoothingEnabled = true; kc.imageSmoothingQuality = 'high';
      kc.drawImage(szene, 0, 0, CW, CH);
      var src = kc.getImageData(0, 0, CW, CH).data, W = CW * s, h1 = Math.ceil((s - 1) / 2), h2 = s - 1 - h1;
      aus32.fill(GP);
      for (var cy = 0; cy < CH; cy++) for (var cx = 0; cx < CW; cx++) {
        var p = (cy * CW + cx) * 4;
        if (src[p + 3] < 110) continue;                                   // durchsichtig bleibt durchsichtig
        var q = quant(src[p], src[p + 1], src[p + 2]);
        var T = TON[q[2] > BAYER[(cy & 3) * 4 + (cx & 3)] + .5 ? q[1] : q[0]];
        if (T.grund) continue;
        var x0 = cx * s, y0 = cy * s, xx, yy, row;
        if (koernung && T.v < dunkel) {                                    // dunkel: zwei Punkte auf der Diagonalen, wechselnd
          var flip = (cx + cy) & 1;
          for (yy = 0; yy < h1; yy++) {
            var r1 = (y0 + yy) * W + x0 + (flip ? h1 : 0), r2 = (y0 + h1 + yy) * W + x0 + (flip ? 0 : h1);
            for (xx = 0; xx < h2; xx++) { aus32[r1 + xx] = T.punkt; aus32[r2 + xx] = T.punkt; }
          }
          continue;
        }
        for (yy = 0; yy < s - 1; yy++) { row = (y0 + yy) * W + x0; for (xx = 0; xx < s - 1; xx++) aus32[row + xx] = T.voll; aus32[row + s - 1] = T.fuge; }
        row = (y0 + s - 1) * W + x0; for (xx = 0; xx < s; xx++) aus32[row + xx] = T.fuge;
      }
      zc.putImageData(aus, 0, 0);
      if (o.lichtAuto) {                                                  // nur Bildpunkte über der Schwelle leuchten von selbst
        var b0 = B0.getContext('2d'), li = b0.createImageData(CW, CH), ld = li.data, thr = o.lichtAuto;
        for (var i = 0; i < src.length; i += 4) {
          var l = hell([src[i], src[i + 1], src[i + 2]]), k = src[i + 3] > 110 && l > thr ? (l - thr) / (1 - thr) : 0;
          ld[i] = src[i] * k; ld[i + 1] = src[i + 1] * k; ld[i + 2] = src[i + 2] * k; ld[i + 3] = 255;
        }
        b0.putImageData(li, 0, 0);
        var lc = lichtE.getContext('2d');
        lc.save(); lc.globalCompositeOperation = 'lighter'; lc.imageSmoothingEnabled = true; lc.drawImage(B0, 0, 0, lichtE.width, lichtE.height); lc.restore();
      }
      if (licht) {
        [[B1, 2, licht.stark], [B2, 3, licht.weit]].forEach(function (e) {
          var b = e[0].getContext('2d');
          b.clearRect(0, 0, e[0].width, e[0].height); b.filter = 'blur(' + e[1] + 'px)';
          b.drawImage(lichtE, 0, 0, e[0].width, e[0].height); b.filter = 'none';
          zc.save(); zc.globalCompositeOperation = 'lighter'; zc.imageSmoothingEnabled = true; zc.globalAlpha = e[2];
          zc.drawImage(e[0], 0, 0, ziel.width, ziel.height); zc.restore();
        });
      }
    }
    // Leert Szene und Lichtebene für das nächste Bild; Szene in Grundfarbe, wenn es eine gibt
    function neu() {
      var sc = szene.getContext('2d'), lc = lichtE.getContext('2d');
      sc.setTransform(1, 0, 0, 1, 0, 0); lc.setTransform(1, 0, 0, 1, 0, 0);
      sc.clearRect(0, 0, szene.width, szene.height); lc.clearRect(0, 0, lichtE.width, lichtE.height);
      if (grund) { sc.fillStyle = '#' + grund; sc.fillRect(0, 0, szene.width, szene.height); }
    }
    return {
      spalten: CW, zeilen: CH, aufloesung: A, szene: szene, licht: lichtE, zeichne: zeichne, neu: neu,
      palette: function (p) { setzePalette(p); QC = new Map(); toene(); }
    };
  }

  // Ein schräges Glanzband über alles Deckende einer Leinwand, alle `periode` Sekunden
  function glanz(ziel, t, periode, staerke) {
    periode = periode || 8; staerke = staerke == null ? .45 : staerke;
    var p = (t % periode) / periode * 1.6 - .3, w = ziel.width, h = ziel.height;
    if (p < -.1 || p > 1.1) return;
    var m = leinwand(w, h), g = m.getContext('2d'), x = p * (w + h * .6) - h * .6;
    g.drawImage(ziel, 0, 0); g.globalCompositeOperation = 'source-in';
    var gr = g.createLinearGradient(x, h, x + h * .6, 0), b = .035 * (w + h * .6) / (w || 1);
    gr.addColorStop(0, 'rgba(255,255,255,0)'); gr.addColorStop(.5, 'rgba(255,255,255,' + staerke + ')'); gr.addColorStop(1, 'rgba(255,255,255,0)');
    g.setTransform(1, 0, -.6, 1, 0, 0); g.fillStyle = gr; g.fillRect(x - b * w, 0, b * w * 2 + h * .6, h);
    ziel.getContext('2d').drawImage(m, 0, 0);
  }

  // Bild → Textgrafik: durchsichtigen Rand abschneiden, Palette aus dem Bild (oder vorgegeben), optional Glanz
  function ausBild(img, o) {
    o = o || {};
    var vw = Math.min(1200, img.naturalWidth || img.width), vh = Math.round((img.naturalHeight || img.height) * vw / (img.naturalWidth || img.width));
    var v = leinwand(vw, vh), vx = v.getContext('2d');
    vx.drawImage(img, 0, 0, vw, vh);
    var vd = vx.getImageData(0, 0, vw, vh).data, x0 = vw, y0 = vh, x1 = -1, y1 = -1;
    for (var yy = 0; yy < vh; yy++) for (var xs = 0; xs < vw; xs++) if (vd[(yy * vw + xs) * 4 + 3] > 110) {
      if (xs < x0) x0 = xs; if (xs > x1) x1 = xs; if (yy < y0) y0 = yy; if (yy > y1) y1 = yy;
    }
    if (x1 < 0) return null;
    var bw = x1 - x0 + 1, bh = y1 - y0 + 1, CW = Math.min(o.spalten || 300, bw), CH = Math.round(bh * CW / bw);
    var pal = o.palette;
    if (!pal || pal === 'auto') { var k = leinwand(CW * 2, CH * 2); k.getContext('2d').drawImage(v, x0, y0, bw, bh, 0, 0, CW * 2, CH * 2); pal = paletteAusLeinwand(k, o.toene || 12); }
    var tg = erzeuge({ spalten: CW, zeilen: CH, palette: pal, grund: o.grund === undefined ? null : o.grund,
                       fuge: o.fuge, fugeArt: o.fugeArt, koernung: o.koernung, licht: o.licht === undefined ? false : o.licht, lichtAuto: o.lichtAuto });
    return {
      tg: tg,
      zeichne: function (ziel, s, t) {
        tg.neu();
        var sc = tg.szene.getContext('2d');
        sc.imageSmoothingEnabled = true; sc.imageSmoothingQuality = 'high';
        sc.drawImage(v, x0, y0, bw, bh, 0, 0, tg.szene.width, tg.szene.height);
        if (o.glanz !== false && t != null) glanz(tg.szene, t, o.glanz || 8);
        tg.zeichne(ziel, s);
      }
    };
  }

  // Ganzzahlige Zeichengröße für eine verfügbare Fläche in CSS-Pixeln; nie hochskalieren (macht weich)
  function groesse(tg, breiteCss, hoeheCss, min, max) {
    var dpr = (typeof window !== 'undefined' && window.devicePixelRatio) || 1;
    var s = Math.floor(Math.min(breiteCss * dpr / tg.spalten, (hoeheCss || Infinity) * dpr / tg.zeilen));
    return Math.max(min || 2, Math.min(max || 12, s));
  }

  root.Textgrafik = { erzeuge: erzeuge, ausBild: ausBild, glanz: glanz, groesse: groesse,
                      paletteAusLeinwand: paletteAusLeinwand, paletteAusCss: paletteAusCss, PALETTEN: PALETTEN, LEITERN: LEITERN, BAYER: BAYER };
})(typeof window !== 'undefined' ? window : globalThis);
