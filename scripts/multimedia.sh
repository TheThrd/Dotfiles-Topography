#!/bin/bash

function increase {
	if [[ "$2" = "-v" ]]; then
		wpctl set-volume @DEFAULT_AUDIO_SINK@ $1%+
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
	else
		brightnessctl set $1%+
	fi
}
function decrease {
	if [[ "$2" = "-v" ]]; then
		wpctl set-volume @DEFAULT_AUDIO_SINK@ $1%-
		if [[ "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)" == *"0.00"* ]]; then
			wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
		fi
	else
		brightnessctl -n1 set $1%-
	fi
}
#function 

function sendNotif {
	if [[ "$1" = "-v" ]]; then
		val="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf $2 * 100}')"
		stack="VolumeStack"
		summaryString="VOLUME: $val%"
		if [[ "$val" = "0" || "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)" = *"MUTED"* ]]; then
			summaryString="VOLUME: MUTED"		
		fi
	elif [[ "$1" = "-b" ]]; then
		brightC=$(($(brightnessctl g)*100))
		brightM=$(brightnessctl m)
		val=$((brightC / brightM))
		stack="BrightnessStack"
		summaryString="BRIGHTNESS: $val%"
	fi

	dunstify -h string:x-dunst-stack-tag:"$stack" -h int:value:"$val" -a "PopupScript" -t 1000 "$summaryString"
}

if [[ "$1" = "-h" || -z "$1" ]]; then
	echo -e "volumeChange -h, -i, -d, -q\n0-100\nARGS:\n[-h]: Display this help menu\n[-i]: Increase volume and fire notification\n[-d]: Decrease volume and fire notification\n\n(0-100)% (Optional) increase/decrease amount."
elif [[ "$1" = "-i" ]]; then
	increase "$2" "$3"
	sendNotif "$3"
elif [[ "$1" = "-d" ]]; then
	decrease "$2" "$3"
	sendNotif "$3"
elif [[ "$1" = "-m" ]]; then
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
	sendNotif "-v"
elif [[ "$1" = "-s" ]]; then
	if [[ "$(brightnessctl g)" == "0" ]]; then
		brightnessctl set "$(cat ~/.scripts/saves/previousBrightness)"
	else
		echo "$(brightnessctl g)" > ~/.scripts/saves/previousBrightness
		brightnessctl set 0%
	fi
fi
