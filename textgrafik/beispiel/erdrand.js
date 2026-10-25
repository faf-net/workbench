// Beispielszene für textgrafik.js: Erdrand bei Sonnenaufgang mit Kapsel — Kugel mit räumlichem Rauschen,
// Atmosphäre als Verlauf, Sonne mit Strahlen in der Lichtebene, Palette einmal aus der Szene (16 Töne).
//   Erdrand(leinwand, breiteCss) startet die Animation.
window.Erdrand = function (cv, breiteCss) {
  var CW = 300, CH = 160;
  var tg = Textgrafik.erzeuge({ spalten: CW, zeilen: CH, palette: ['000000'], grund: '0d0c0b', licht: { stark: .6, weit: .5 } });
  var W = tg.szene.width, H = tg.szene.height;                          // 600 × 320
  function hash(x, y, s) { var h = (x * 374761393 + y * 668265263 + s * 2246822519) | 0; h = Math.imul(h ^ (h >>> 13), 1274126177); return ((h ^ (h >>> 16)) >>> 0) / 4294967296; }
  function h3(x, y, z, s) { return hash(x * 7919 + z * 104729, y * 15485863 + z * 31, s); }
  function noise3(x, y, z, s) {                                         // Wertrauschen im Raum, trilinear — keine Nähte auf der Kugel
    var xi = Math.floor(x), yi = Math.floor(y), zi = Math.floor(z), fx = x - xi, fy = y - yi, fz = z - zi;
    fx = fx * fx * (3 - 2 * fx); fy = fy * fy * (3 - 2 * fy); fz = fz * fz * (3 - 2 * fz);
    function e(a, b, c) { return h3(xi + a, yi + b, zi + c, s); }
    var x00 = e(0, 0, 0) + (e(1, 0, 0) - e(0, 0, 0)) * fx, x10 = e(0, 1, 0) + (e(1, 1, 0) - e(0, 1, 0)) * fx;
    var x01 = e(0, 0, 1) + (e(1, 0, 1) - e(0, 0, 1)) * fx, x11 = e(0, 1, 1) + (e(1, 1, 1) - e(0, 1, 1)) * fx;
    var y0 = x00 + (x10 - x00) * fy, y1 = x01 + (x11 - x01) * fy;
    return y0 + (y1 - y0) * fz;
  }
  function fbm(x, y, z, s) { var v = 0, a = .5; for (var i = 0; i < 5; i++) { v += a * noise3(x, y, z, s + i); x *= 2.03; y *= 2.03; z *= 2.03; a *= .5; } return v; }
  function mix(a, b, t) { return [a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t, a[2] + (b[2] - a[2]) * t]; }

  // Erde einmal als Bild rechnen: Kugel mit Rand-Verkürzung, Meer, Land, Wüste, Wolken, Dunst am Rand, Atmosphäre darüber
  var R = 900, cx = W / 2, cy = 128 + R, SX = 330, SY = 92;
  var erde = document.createElement('canvas'); erde.width = W; erde.height = H;
  var ec = erde.getContext('2d'), id = ec.createImageData(W, H), d = id.data;
  var MEER = [44, 104, 178], MEER2 = [24, 64, 128], LAND = [104, 128, 78], WUESTE = [200, 150, 86], WOLKE = [236, 240, 244];
  var sd = [0.12, -0.55, 0.83], sl = Math.hypot(sd[0], sd[1], sd[2]); sd = sd.map(function (v) { return v / sl; });
  for (var y = 0; y < H; y++) for (var x = 0; x < W; x++) {
    var dx = x + .5 - cx, dy = y + .5 - cy, r = Math.hypot(dx, dy), i = (y * W + x) * 4, c = null, al = 0;
    if (r <= R) {
      var nx = dx / R, ny = dy / R, nz = Math.sqrt(Math.max(0, 1 - nx * nx - ny * ny));
      var px = nx * 7, py = ny * 7, pz = nz * 7;                       // Punkt auf der Kugel: der Rand verkürzt sich von selbst
      var land = fbm(px + 3, py, pz, 11), wueste = fbm(px * 1.4, py * 1.4 + 5, pz * 1.4, 23), wolke = fbm(px * 2.6, py * 2.6 + 9, pz * 2.6, 37);
      c = land > .53 ? (wueste > .52 && land > .56 ? WUESTE : LAND) : mix(MEER2, MEER, Math.min(1, Math.max(0, (land - .3) * 3)));
      if (wolke > .6) c = mix(c, WOLKE, Math.min(1, (wolke - .6) * 6));
      var lk = .45 + .75 * Math.max(0, nx * sd[0] + ny * sd[1] + nz * sd[2]);
      c = c.map(function (q) { return Math.min(255, q * lk); });
      var rand = (R - r);
      if (rand < 14) c = mix(c, [225, 238, 252], Math.pow(1 - rand / 14, 2) * .85);   // Dunst am Rand
      al = 255;
    } else if (r < R + 34) {                                            // Atmosphäre: weiß → blau → Schwarz, beim Sonnenstand orange
      var t = (r - R) / 34, nah = Math.exp(-Math.pow((x - SX) / 140, 2));
      c = t < .2 ? mix([240, 246, 255], [120, 170, 235], t / .2) : mix([120, 170, 235], [20, 40, 90], (t - .2) / .8);
      if (t < .35) c = mix(c, [255, 176, 92], nah * (1 - t / .35) * .8);
      al = 255 * Math.pow(1 - t, 1.6);
    }
    if (c) { d[i] = c[0]; d[i + 1] = c[1]; d[i + 2] = c[2]; d[i + 3] = al; }
  }
  ec.putImageData(id, 0, 0);
  var sterne = []; for (var k = 0; k < 90; k++) sterne.push([hash(k, 1, 5) * W, hash(k, 2, 5) * (H * .6), .3 + .7 * hash(k, 3, 5)]);

  function szene(t) {
    tg.neu();
    var S = tg.szene.getContext('2d'), L = tg.licht.getContext('2d');
    sterne.forEach(function (st) {                                     // Sterne, leise funkelnd
      var b = st[2] * (.75 + .25 * Math.sin(t * 2 + st[0]));
      S.fillStyle = 'rgba(230,230,220,' + b + ')'; S.fillRect(st[0], st[1], 1.4, 1.4);
    });
    S.drawImage(erde, 0, 0);
    // Sonne knapp über dem Rand: Kern, Strahlen waagerecht, Licht in die Lichtebene
    var p = .9 + .1 * Math.sin(t * 7);
    var g = S.createRadialGradient(SX, SY, 0, SX, SY, 22); g.addColorStop(0, '#ffffff'); g.addColorStop(.25, '#fff4dc'); g.addColorStop(.6, 'rgba(255,190,110,.5)'); g.addColorStop(1, 'rgba(255,160,80,0)');
    S.fillStyle = g; S.fillRect(SX - 24, SY - 24, 48, 48);
    var st = S.createLinearGradient(SX - 90, 0, SX + 90, 0); st.addColorStop(0, 'rgba(255,200,140,0)'); st.addColorStop(.5, 'rgba(255,250,235,.95)'); st.addColorStop(1, 'rgba(255,200,140,0)');
    S.fillStyle = st; S.fillRect(SX - 90, SY - 1.5, 180, 3);
    L.globalAlpha = p; var lg = L.createRadialGradient(SX, SY, 0, SX, SY, 60); lg.addColorStop(0, '#ffffff'); lg.addColorStop(.3, 'rgba(255,200,130,.6)'); lg.addColorStop(1, 'rgba(255,150,60,0)');
    L.fillStyle = lg; L.fillRect(SX - 60, SY - 60, 120, 120); L.globalAlpha = 1;
    L.fillStyle = 'rgba(255,240,210,.8)'; L.fillRect(SX - 70, SY - 1, 140, 2);
    L.fillStyle = 'rgba(200,225,255,.35)'; L.fillRect(0, 118, W, 14);  // Atmosphäre leuchtet schwach
    // Kapsel: Kegel, rote Binde, Schatten unten, langsam treibend
    var kx = 410 + Math.sin(t * .3) * 3, ky = 112 + Math.cos(t * .4) * 2;
    S.save(); S.translate(kx, ky); S.rotate(-.12);
    S.beginPath(); S.moveTo(0, -6); S.lineTo(22, -3); S.lineTo(22, 7); S.lineTo(0, 10); S.closePath();
    var kg = S.createLinearGradient(0, -6, 0, 10); kg.addColorStop(0, '#ffffff'); kg.addColorStop(.6, '#e6e0d4'); kg.addColorStop(1, '#9a948a'); S.fillStyle = kg; S.fill();
    S.fillStyle = '#c03a2a'; S.fillRect(-2, -6, 3, 16);
    S.fillStyle = '#e09030'; S.fillRect(12, -2, 4, 4);
    S.restore();
  }
  var s = Textgrafik.groesse(tg, breiteCss), gesetzt = false;
  (function schleife(jetzt) {
    var t = (jetzt || 0) / 1000;
    szene(t);
    if (!gesetzt) { tg.palette(Textgrafik.paletteAusLeinwand(tg.szene, 16)); gesetzt = true; }   // Töne einmal aus der Szene
    tg.zeichne(cv, s);
    cv.style.width = (cv.width / (devicePixelRatio || 1)) + 'px';
    requestAnimationFrame(schleife);
  })();
};
