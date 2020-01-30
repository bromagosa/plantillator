#!/bin/bash
cd "$(dirname "$0")"

originpath=$1
template=$2

if [ -z $1 ]; then
	echo "utilització: ./plantilla.command carpeta-origen nom-plantilla.png"
	exit 0
fi

# origin és l'últim arxiu modificat dins la carpeta especificada per originpath
origin=`ls -t $originpath | grep -v plantilla | head -n1`

convert $originpath/$origin -resize 3240x2160^ -gravity center -extent 3240x2160 photo_tmp.png
convert $template -resize 3240x2160 template_tmp.png

# Aplica plantilla.png sobre foto.jpg i guarda com a final.png
convert photo_tmp.png -gravity center -extent 3240x2160! template_tmp.png -composite final.png
rm photo_tmp.png template_tmp.png

# Envia a imprimir

lp -d MITSUBISHI-CPD90D -o media=ME_10x15 final.png
