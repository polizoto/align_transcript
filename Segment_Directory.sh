#!/bin/bash

# Segment only or Segment + Align files
for dir in */;
do
  
  file="${dir%/}.mp4"
  if [ -e "$file" ]
  then
    mv "$file" "$dir"
     (cd "$dir" && ./Segment+Align.sh);
  else
    echo "$dir" >> segment_only.txt
    (cd "$dir" && ./Segment_Only.sh);
  fi
  
rm "$dir"HONORIFICS
rm "$dir"Segment_Only.sh
rm "$dir"Segment+Align.sh
rm "$dir"sentence-boundary.pl
rm "$dir"Segment_Directory.sh

if [ -f "./segment_only.txt" ]; then

sed -i 's/\///' segment_only.txt

echo '\033[33m' | cat - segment_only.txt > temp && mv temp segment_only.txt

fi

done
    