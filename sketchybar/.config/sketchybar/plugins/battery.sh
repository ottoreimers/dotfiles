#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ $PERCENTAGE -gt 75 ]]; then
    ICON="󰁹"
elif [[ $PERCENTAGE -gt 50 ]]; then
    ICON="󰂀"
elif [[ $PERCENTAGE -gt 25 ]]; then
    ICON="󰁻"
else
    ICON="󰁺"
fi

if [[ $CHARGING != "" ]]; then
    ICON="󰂄"
fi

sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%"
