#!/bin/bash

# Weather plugin för SketchyBar
# Använder wttr.in API för att hämta väderdata

# Din stad (ändra till din stad)
LOCATION="Stockholm"

# Hämta väderdata från wttr.in (bara temperatur och förhållanden)
WEATHER_DATA=$(curl -s "wttr.in/${LOCATION}?format=%C+%t" 2>/dev/null)

# Fallback om API inte svarar
if [[ -z "$WEATHER_DATA" ]]; then
    WEATHER_ICON="󰼯"
    sketchybar --set $NAME icon="$WEATHER_ICON" label="N/A"
    exit 0
fi

# Extrahera temperatur och väderförhållanden
CONDITION=$(echo "$WEATHER_DATA" | sed 's/[+-][0-9]*°C//')
TEMP=$(echo "$WEATHER_DATA" | grep -o '[+-][0-9]*°C')

# Ta bort eventuella extra mellanslag från condition
CONDITION=$(echo "$CONDITION" | xargs)

# Väderikoner baserat på förhållanden
case "$CONDITION" in
    *"Clear"* | *"Sunny"*)
        WEATHER_ICON="󰖙"
        ;;
    *"Partly cloudy"* | *"Partly Cloudy"*)
        WEATHER_ICON="󰖕"
        ;;
    *"Cloudy"* | *"Overcast"*)
        WEATHER_ICON="󰖐"
        ;;
    *"Rain"* | *"Drizzle"* | *"Light rain"*)
        WEATHER_ICON="󰖗"
        ;;
    *"Heavy rain"* | *"Thunderstorm"*)
        WEATHER_ICON="󰙾"
        ;;
    *"Snow"* | *"Light snow"*)
        WEATHER_ICON="󰖘"
        ;;
    *"Heavy snow"* | *"Blizzard"*)
        WEATHER_ICON="󰙿"
        ;;
    *"Fog"* | *"Mist"*)
        WEATHER_ICON="󰖑"
        ;;
    *)
        WEATHER_ICON="󰼯"
        ;;
esac

# Uppdatera SketchyBar
sketchybar --set $NAME icon="$WEATHER_ICON" label="$TEMP"
