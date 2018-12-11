#!/bin/sh

HEIGHT=""

usage()
{
    echo "generate stl files"
    echo ""
    echo "./generate.sh"
    echo "\t-h --help"
    echo "\t--height=$HEIGHT"
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | sed 's/^[^=]*=//g'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --height)
            HEIGHT=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done


if [ $HEIGHT != "" ] ; then PARAMS="-D height=$HEIGHT " ; fi

colors=(white black red gold); for color in "${colors[@]}"
do
 /Applications/OpenSCAD\ 2.app/Contents/MacOS/OpenSCAD --enable=customizer -o output/$color.stl -p znak.json -P $color $PARAMS znak.scad
done
