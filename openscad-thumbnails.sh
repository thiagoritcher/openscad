#!/bin/env sh

# creates thumbnails on save in cache directory
inotifywait -m -r . -e moved_to | while read -r dir action file; do
        td=$(realpath ~/.cache/thumbnails/openscad/$dir); echo "Dir: $td";  mkdir -p "$td";  scad2png $dir$file "$td/$file.png" 256;
done
