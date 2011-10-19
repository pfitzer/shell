#!/bin/bash
######################################################################################################
#
# converting all jpg and png images to a given size
#
# usage ./webimage.sh -s widthxheight -p /path/to/images
# width and heigth in px
#
# creates a thumb folder within given path and puts the resized images in it
#
######################################################################################################

#
# function show the usage
#
usage() {
echo "./webimg.sh -s 800x600 -p /path/to/images"
echo ""
echo "-h	show this help"
echo "-s    imagesize widthxheight eg. 800x600"
echo "-p    /path/to/images"

}

#
# function convert the images
#
do_convert() {

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
}

# if no parameters set
# show usage
if [ $# -eq 0 ] ; then
    usage
    exit 1
fi 

while getopts ':hs:p:' OPTION ; do
  case "$OPTION" in
    h)   usage; exit 1;;
    p)	 path="$OPTARG";;
    s)   imgsize="$OPTARG";;
    *)   usage; exit 1
  esac
done

do_convert
