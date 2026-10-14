#!/usr/bin/env bash
# wb.sh — Workbench-Farben fuers Terminal
#
# Palette und Begruendung: 40 Resources/Farbpalette Workbench.md
# Fassung fuer Linux und fuer Git Bash unter Windows.
# Toene sind 24-Bit-Werte, KEINE Palettenfarben — funktioniert unabhaengig
# vom Farbschema des Terminals, solange es Truecolor kann.
#
#   wb.sh mark [--dezent] <ton> <text>   Textmarker mitten im Satz
#   wb.sh band <ton> <text>              Hinweisband ueber die volle Breite
#   wb.sh swatch                         Paletten-Uebersicht zum Gegenchecken
#
# Toene: amber sage gold rose steel

set -uo pipefail

# PFLICHT in Git Bash unter Windows: LANG und LC_ALL sind hier leer, dadurch zaehlt
# bash ${#t} in BYTES statt Zeichen — ein "—" waere 3 statt 1, und jedes Band
# mit Sonderzeichen kaeme 2 Spalten zu kurz heraus. Dieselbe Falle wie bei
# printf '%-*s', nur ueber die Locale. Unter Linux faellt das
# meist nicht auf, weil dort eine UTF-8-Locale gesetzt ist.
export LC_ALL=C.UTF-8

e=$'\033'; R="${e}[0m"; B="${e}[1m"

hexfg(){ printf '%s[38;2;%d;%d;%dm' "$e" $((16#${1:0:2})) $((16#${1:2:2})) $((16#${1:4:2})); }
hexbg(){ printf '%s[48;2;%d;%d;%dm' "$e" $((16#${1:0:2})) $((16#${1:2:2})) $((16#${1:4:2})); }

# --- Grundwerte ---------------------------------------------------------
GRUND=1a1918; PANEL=232120; LINIE=3a3634
INK=e9e3d8; BOLD=f5f1eb; MUTED=6f6961; DIM=a49c90

# --- Akzente ------------------------------------------------------------
A_AMBER=cc9166; A_SAGE=93a373; A_GOLD=c7a854; A_ROSE=c07f73; A_STEEL=7d97ab

# --- Marker kraeftig 25 % ----------------------------------------------
M_AMBER=47372c; M_SAGE=383c2f; M_GOLD=453d27; M_ROSE=44322f; M_STEEL=33383d

# --- Marker dezent 20 % -------------------------------------------------
S_AMBER=3e3128; S_SAGE=32352a; S_GOLD=3d3624; S_ROSE=3b2d2a; S_STEEL=2e3235

# --- Band 33 % (leuchtender, bestaetigt 03.08.2026) ---------------------
BAND_AMBER=554132; BAND_SAGE=424736; BAND_GOLD=53482c; BAND_ROSE=513b36; BAND_STEEL=3b4349

W=74

# Fallstrick 1: `local t=$1 n=$(( ... ))` expandiert zu frueh — n waere immer 0.
# Fallstrick 2: printf '%-*s' fuellt nach BYTES, ${#var} zaehlt ZEICHEN.
#               Deshalb diese pad-Funktion statt '%-*s'.
pad(){ local t=$1 w=$2 n; n=$(( w - ${#t} )); ((n<0)) && n=0; printf '%s%*s' "$t" "$n" ""; }

up(){ printf '%s' "$1" | tr '[:lower:]' '[:upper:]'; }

resolve(){
    local pfx=$1 name=$2 var
    var="${pfx}_$(up "$name")"
    if [[ -z "${!var:-}" ]]; then
        printf 'wb.sh: unbekannter Ton "%s" (erlaubt: amber sage gold rose steel)\n' "$name" >&2
        exit 2
    fi
    printf '%s' "${!var}"
}

mark(){
    local dezent=0
    if [[ "${1:-}" == "--dezent" ]]; then dezent=1; shift; fi
    local ton=${1:?Ton fehlt} text=${2:?Text fehlt} bg fg
    if (( dezent )); then bg=$(resolve S "$ton"); fg=$INK
    else                  bg=$(resolve M "$ton"); fg=$BOLD; fi
    if (( dezent )); then printf '%s%s %s %s' "$(hexbg "$bg")" "$(hexfg "$fg")" "$text" "$R"
    else                  printf '%s%s%s %s %s' "$(hexbg "$bg")" "$(hexfg "$fg")" "$B" "$text" "$R"; fi
}

band(){
    local ton=${1:?Ton fehlt} text=${2:?Text fehlt} akzent bg
    akzent=$(resolve A "$ton"); bg=$(resolve BAND "$ton")
    printf '%s▌%s%s %s %s\n' "$(hexfg "$akzent")" "$(hexbg "$bg")" "$(hexfg "$INK")" "$(pad "$text" $((W-4)))" "$R"
}

swatch(){
    local n
    printf '\n%s%s  WORKBENCH — die Hausfarben%s\n\n' "$(hexfg "$A_AMBER")" "$B" "$R"

    printf '  %sGRUNDWERTE%s\n' "$(hexfg "$MUTED")" "$R"
    for n in "Grund $GRUND" "Panel $PANEL" "Linie $LINIE" "Schrift $INK" "gedaempft $DIM" "schwach $MUTED" "fett $BOLD"; do
        set -- $n
        printf '    %s      %s %s#%s%s  %s\n' "$(hexbg "$2")" "$R" "$(hexfg "$MUTED")" "$2" "$R" "$1"
    done

    printf '\n  %sAKZENTE%s\n' "$(hexfg "$MUTED")" "$R"
    for n in "Bernstein $A_AMBER" "Salbei $A_SAGE" "Gold $A_GOLD" "Rose $A_ROSE" "Stahl $A_STEEL"; do
        set -- $n
        printf '    %s      %s %s#%s%s  %s\n' "$(hexbg "$2")" "$R" "$(hexfg "$2")" "$2" "$R" "$1"
    done

    printf '\n  %sMARKER — kraeftig 25 %%  /  dezent 20 %%%s\n' "$(hexfg "$MUTED")" "$R"
    printf '    %s   %s   %s\n' "$(mark amber 'Bernstein')" "$(mark --dezent amber 'Bernstein')" ""
    printf '    %s      %s\n'   "$(mark sage 'Salbei')"     "$(mark --dezent sage 'Salbei')"
    printf '    %s        %s\n' "$(mark gold 'Gold')"       "$(mark --dezent gold 'Gold')"
    printf '    %s        %s\n' "$(mark rose 'Rose')"       "$(mark --dezent rose 'Rose')"
    printf '    %s       %s\n'  "$(mark steel 'Stahl')"     "$(mark --dezent steel 'Stahl')"

    printf '\n  %sHINWEISBAENDER — 33 %%%s\n\n' "$(hexfg "$MUTED")" "$R"
    band sage  'Salbei — gut, erledigt, gesichert'
    band steel 'Stahl — neutral, Daten, Verweise'
    band gold  'Gold — Achtung, offener Punkt'
    band rose  'Rose — kritisch, Fehler, Gefahr'
    band amber 'Bernstein — das Wichtigste, der einzige laute Akzent'
    printf '\n'
}

case "${1:-}" in
    mark)   shift; mark "$@"; printf '\n' ;;
    band)   shift; band "$@" ;;
    swatch) swatch ;;
    *)      sed -n '3,14p' "$0" | sed 's/^# \?//' ;;
esac
