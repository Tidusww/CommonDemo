#!/bin/sh
export PATH=/opt/local/bin/:/opt/local/sbin:$PATH:/usr/local/bin:

#
# prepare open
#
convertPath=`which convert`
gsPath=`which gs`

if [[ ! -f ${convertPath} || -z ${convertPath} ]]; then
convertValidation=true;
else
convertValidation=false;
fi

if [[ ! -f ${gsPath} || -z ${gsPath} ]]; then
gsValidation=true;
else
gsValidation=false;
fi

if [[ "$convertValidation" = true || "$gsValidation" = true ]]; then
echo "WARNING: Skipping Icon versioning, you need to install ImageMagick and ghostscript (fonts) first, you can use brew to simplify process:"

if [[ "$convertValidation" = true ]]; then
echo "brew install imagemagick"
fi
if [[ "$gsValidation" = true ]]; then
echo "brew install ghostscript"
fi
exit 0;
fi

version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "${CONFIGURATION_BUILD_DIR}/${INFOPLIST_PATH}"`
build_num=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${CONFIGURATION_BUILD_DIR}/${INFOPLIST_PATH}"`

# Check if we are under a Git or Hg repo
if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
commit=`git rev-parse --short HEAD`
branch=`git rev-parse --abbrev-ref HEAD`
else
commit=`hg identify -i`
branch=`hg identify -b`
fi;

#SRCROOT=..
#CONFIGURATION_BUILD_DIR=.
#UNLOCALIZED_RESOURCES_FOLDER_PATH=.

#commit="3783bab"
#branch="master"
#version="3.4"
#build_num="9999"

shopt -s extglob
build_num="${build_num##*( )}"
shopt -u extglob

product="appstore"
if [[ $PRODUCT_BUNDLE_IDENTIFIER == *.inhouse ]]
then
product="inhouse"
fi
if [[ $PRODUCT_BUNDLE_IDENTIFIER == *.adhoc ]]
then
product="adhoc"
fi


#caption="${version} ($build_num)\n${branch}\n${commit}"
caption="$build_num\n$product\n"
echo $caption
#
# prepare end
#




function abspath() { pushd . > /dev/null; if [ -d "$1" ]; then cd "$1"; dirs -l +0; else cd "`dirname \"$1\"`"; cur_dir=`dirs -l +0`; if [ "$cur_dir" == "/" ]; then echo "$cur_dir`basename \"$1\"`"; else echo "$cur_dir/`basename \"$1\"`"; fi; fi; popd > /dev/null; }

function processIcon() {
    echo "============="
    echo "=============processIcon begin============="

    base_file=$1
    echo "icon to be processed:${base_file}"

    cd "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
    base_path=`find . -name ${base_file}`

    real_path=$( abspath "${base_path}" )
    echo "base path ${real_path}"

    if [[ ! -f ${base_path} || -z ${base_path} ]]; then
        echo "base_path is not a file or is null, return."
        echo "=============processIcon   end============="
        echo "============="
        return;
    fi


    # TODO: if they are the same we need to fix it by introducing temp
    target_file=`basename $base_path`
    target_path="${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${target_file}"
    echo "{} ${target_path}"
    echo "$target_path"


    base_tmp_normalizedFileName="${base_file%.*}-normalized.${base_file##*.}"
    base_tmp_path=`dirname $base_path`
    base_tmp_normalizedFilePath="${base_tmp_path}/${base_tmp_normalizedFileName}"

    stored_original_file="${base_tmp_normalizedFilePath}-tmp"
    if [[ -f ${stored_original_file} ]]; then
        echo "found previous file at path ${stored_original_file}, using it as base"
        mv "${stored_original_file}" "${base_path}"
    fi

    if [[ $CONFIGURATION == "Release" ]] && [[ $PRODUCT_BUNDLE_IDENTIFIER != *.inhouse ]] && [[ $PRODUCT_BUNDLE_IDENTIFIER != *.adhoc ]]
    then
        #只有appstore的Release包才使用正常的icon
        cp "${base_path}" "$target_path"
        echo "CONFIGURATION is Release, not inhouse app, return."
        echo "=============processIcon   end============="
        echo "============="
        return 0;
    else
        echo "CONFIGURATION: $CONFIGURATION"
        echo "PRODUCT_BUNDLE_IDENTIFIER: $PRODUCT_BUNDLE_IDENTIFIER"
    fi

    echo "Reverting optimized PNG to normal"
    # Normalize
    echo "xcrun -sdk iphoneos pngcrush -revert-iphone-optimizations -q ${base_path} ${base_tmp_normalizedFilePath}"
    xcrun -sdk iphoneos pngcrush -revert-iphone-optimizations -q "${base_path}" "${base_tmp_normalizedFilePath}"

    # move original pngcrush png to tmp file
    echo "moving pngcrushed png file at ${base_path} to ${stored_original_file}"
    #rm "$base_path"
    mv "$base_path" "${stored_original_file}"

    # Rename normalized png's filename to original one
    echo "Moving normalized png file to original one ${base_tmp_normalizedFilePath} to ${base_path}"
    mv "${base_tmp_normalizedFilePath}" "${base_path}"

    width=`identify -format %w ${base_path}`
    height=`identify -format %h ${base_path}`
    band_height=$((($height * 47) / 100))
    band_position=$(($height - $band_height))
    text_position=$(($band_position - 3))
    point_size=$(((13 * $width) / 100))

    echo "Image dimensions ($width x $height) - band height $band_height @ $band_position - point size $point_size"

    #
    # blur band and text
    #
#    convert ${base_path} -blur 10x8 /tmp/blurred.png
#    convert /tmp/blurred.png -gamma 0 -fill white -draw "rectangle 0,$band_position,$width,$height" /tmp/mask.png
    #让ImageMagick自行选择模糊半径
    convert ${base_path} -blur 0x8 /tmp/blurred.png
    #用另一种方式创建mask
    convert -size ${width}x${height} -set colorspace RGB xc:none -fill black -draw "rectangle 0,$band_position,$width,$height" -colorspace sRGB /tmp/mask.png
    convert -size ${width}x${band_height} xc:none -fill 'rgba(0,0,0,0.2)' -draw "rectangle 0,0,$width,$band_height" /tmp/labels-base.png
    convert -background none -size ${width}x${band_height} -pointsize $point_size -fill white -gravity center -gravity South caption:"$caption" /tmp/labels.png

    convert ${base_path} /tmp/blurred.png /tmp/mask.png -composite /tmp/temp.png

    rm /tmp/blurred.png
    rm /tmp/mask.png

    #
    # compose final image
    #
    filename=New${base_file}
    convert /tmp/temp.png /tmp/labels-base.png -geometry +0+$band_position -composite /tmp/labels.png -geometry +0+$text_position -geometry +${w}-${h} -composite "${target_path}"

    # clean up
    rm /tmp/temp.png
    rm /tmp/labels-base.png
    rm /tmp/labels.png


    echo "Overlayed ${target_path}"
    echo "=============processIcon end============="
    echo "============="
}




#
# begin
#
icon_count=`/usr/libexec/PlistBuddy -c "Print CFBundleIcons:CFBundlePrimaryIcon:CFBundleIconFiles" "${CONFIGURATION_BUILD_DIR}/${INFOPLIST_PATH}" | wc -l`
last_icon_index=$((${icon_count} - 2))

echo "icon_count: ${icon_count}"
echo "last_icon_index: ${last_icon_index}"

i=0
while [  $i -lt $last_icon_index ]; do
    icon=`/usr/libexec/PlistBuddy -c "Print CFBundleIcons:CFBundlePrimaryIcon:CFBundleIconFiles:$i" "${CONFIGURATION_BUILD_DIR}/${INFOPLIST_PATH}"`
    echo "${i}:${icon}"

    if [[ $icon == *.png ]] || [[ $icon == *.PNG ]]
    then
        processIcon $icon
    else

#        processIcon "${icon}.png"#应该不需要再兼容1倍图了
        processIcon "${icon}@2x.png"
        processIcon "${icon}@3x.png"
#       如果是ipad的话用下面这两句
#        processIcon "${icon}~ipad.png"
#        processIcon "${icon}@2x~ipad.png"
    fi

    let i=i+1
done


# Workaround to fix issue#16 to use wildcard * to actually find the file
# Only 72x72 and 76x76 that we need for ipad app icons
#processIcon "AppIcon72x72~ipad*"
#processIcon "AppIcon72x72@2x~ipad*"
#processIcon "AppIcon76x76~ipad*"
#processIcon "AppIcon76x76@2x~ipad*"
