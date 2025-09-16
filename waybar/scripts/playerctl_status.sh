#!/bin/bash

# Filtrar por Spotify o Chrome (YouTube, etc.)
PLAYER=$(playerctl -l 2>/dev/null | grep -E 'spotify|chrome' | head -n 1)

if [ -z "$PLAYER" ]; then
    echo '{"text": "", "tooltip": "Sin reproductores activos"}'
    exit 0
fi

STATUS=$(playerctl --player="$PLAYER" status 2>/dev/null)
ARTIST=$(playerctl --player="$PLAYER" metadata artist 2>/dev/null)
TITLE=$(playerctl --player="$PLAYER" metadata title 2>/dev/null)

# Elegir ícono según estado
ICON=""  # Por defecto: detenido
if [[ "$STATUS" == "Playing" ]]; then
    ICON=""  # Pausa (lo que mostrarás si está sonando)
elif [[ "$STATUS" == "Paused" ]]; then
    ICON=""  # Play (está pausado)
else
    ICON=""  # Detenido o desconocido
fi

# Tooltip detallado, escapando saltos de línea para JSON
TOOLTIP="⏵ Estado: $STATUS\n🎵 Título: $TITLE\n👤 Artista: $ARTIST\n🖥 Reproductor: $PLAYER"

# Escapar para JSON (dobles comillas y newlines)
TOOLTIP_ESCAPED=$(echo -e "$TOOLTIP" | jq -Rs .)

# Output JSON completo
echo "{\"text\": \"$ICON\", \"tooltip\": $TOOLTIP_ESCAPED, \"class\": \"$PLAYER\"}"