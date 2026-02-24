#!/bin/bash
# makepvp.sh
# (c) 2023 Tom Hansen <tomh@uwm.edu>
# License: MIT
# The MIT License (MIT) may be found at http://opensource.org/licenses/MIT
# 
# makepvp: make preview images for all nvim colorschemes
# (from ~/.config/nvim/colors/*.vim)
# requires: neovim, google-chrome, imagemagick `convert' command
# usage: ./makepvp.sh
# output: python/*.png, python/*.jpg
mkdir -p output/def

for bn in bathory burzum dark-funeral darkthrone emperor gorgoroth immortal impaled-nazarene khold marduk mayhem nile taake thyrfing venom windir; do 
    echo == $bn ==
    nvim --headless +"colorscheme $bn" +'TOhtml' +"w! output/$bn.html" +'qa!' preview.rb 2> /dev/null
    sed -i -e 's/Iosevka Comfy/Berkeley Mono/g' "output/$bn.html"
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --no-gpu --force-device-scale-factor=2 --screenshot="output/$bn-ss.png" "output/$bn.html"
    magick output/$bn-ss.png -crop 950x1128+0+0 output/def/$bn.png
    rm "output/$bn.html" "output/$bn-ss.png"
done

for bn in bathory burzum dark-funeral darkthrone emperor gorgoroth immortal impaled-nazarene khold marduk mayhem nile taake thyrfing venom windir; do 
    echo == $bn-alt ==
    nvim --headless +"colorscheme $bn-alt" +'TOhtml' +"w! output/$bn-alt.html" +'qa!' preview.rb 2> /dev/null
    sed -i -e 's/Iosevka Comfy/Berkeley Mono/g' "output/$bn-alt.html"
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --no-gpu --force-device-scale-factor=2 --screenshot="output/$bn-alt-ss.png" "output/$bn-alt.html"
    magick output/$bn-alt-ss.png -crop 950x1128+0+0 output/def/$bn-alt.png
    rm "output/$bn-alt.html" "output/$bn-alt-ss.png"
done

for bn in bathory burzum dark-funeral darkthrone emperor gorgoroth immortal impaled-nazarene khold marduk mayhem nile taake thyrfing venom windir; do 
  # First, ensure all images are the same height but maintain aspect ratio
  magick output/def/$bn.png -resize x500 output/def/$bn-resized.png
  magick output/def/$bn-alt.png -resize x500 output/def/$bn-alt-resized.png
  magick covers/$bn.jpg -resize x500 covers/$bn-resized.png

  # Create labeled versions of each image
  magick output/def/$bn-resized.png -background black -gravity center \
    -background black -gravity south \
    -font Arial -pointsize 24 -fill white -annotate +0+10 "Original-version" \
    output/def/$bn-labeled.png

  magick output/def/$bn-alt-resized.png -background black -gravity center \
    -background black -gravity south \
    -font Arial -pointsize 24 -fill white -annotate +0+10 "Alt-version" \
    output/def/$bn-alt-labeled.png

  magick covers/$bn-resized.png -background black -gravity center \
    -background black -gravity south \
    -font Arial -pointsize 24 -fill white -annotate +0+10 "" \
    covers/$bn-labeled.png

  # Combine images side by side with padding
  montage output/def/$bn-labeled.png output/def/$bn-alt-labeled.png covers/$bn-labeled.png \
    -background black -geometry +50+25 -tile 3x1 output/def/$bn-full.png

  # Clean up temporary files
  rm output/def/$bn-resized.png output/def/$bn-alt-resized.png covers/$bn-resized.png
  rm output/def/$bn-labeled.png output/def/$bn-alt-labeled.png covers/$bn-labeled.png
  rm output/def/$bn.png output/def/$bn-alt.png
done






 #  montage output/def/$bn-def.png output/def/$bn-alt-def.png covers/$bn.jpg -auto-orient -thumbnail x500 \
 #    -background black -geometry +20+0 -tile 3x1 \
 #    -font Arial -pointsize 24 -fill white -title 'Normal|Alt version|Cover' \
 #   output/def/$bn-full.png 
 # done



#   convert \
#     \( output/def/$bn-def.png -resize x500 -background black -gravity center -extent x500 \) \
#     \( output/def/$bn-alt-def.png -resize x500 -background black -gravity center -extent x500 \) \
#     \( covers/$bn.jpg -resize x500 -background black -gravity center -extent x500 \) \
#     +append \
#     \( -size 1500x40 xc:black \
#        -font Arial -pointsize 24 -fill white \
#        -draw "text 250,25 'Normal'" \
#        -draw "text 750,25 'Alt version'" \
#        -draw "text 1250,25 'Original cover'" \
#     \) \
#     -append \
#     output/def/$bn-full.png
# done
# TODO: make a user interface for selecting colorschemes and previewing them
#       using a simple web js framework like bootstrap or jquery.
#       ()
#
# TODO: maybe a script to classify colorschemes as light or dark
