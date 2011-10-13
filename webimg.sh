#!/bin/bash
####
# converting all jpg and png images to a given size
#
# usage ./webimage.sh [widthxheight] [/path/to/images]
# width and heigth in px
#
# creates a thumb folder within given path and puts the resized images in it
#
####

imgsize=$1
path=$2

cd $path
rm -R  thumbs
mkdir thumbs


dialog --title "IMAGE RESIZE" --gauge "Please wait" 7 70 0 < <(
DIRS=(${path}* )
n=${#DIRS[*]}
echo $n
i=0

for image in *.JPG *.jpg *.png
do
# scale with ImageMagick
convert $image -resize "${imgsize}" thumbs/"${image}" &>/dev/null

PCT=$(( 100*(++i)/$n ))

cat <<EOF
XXX
$PCT
converting image
"$path$image"
XXX
EOF

done
)
clear
echo "all images resized"
