#!/bin/bash
# Joseph Polizzotto
# move files to their own directories

TRANSCRIPTS="./Transcripts/*.txt"

for file in $TRANSCRIPTS
do
  dir=${file%.*}
  mkdir "$dir"
 newfile=$dir
  mv "$file" "$newfile"
    find ./Transcripts -type d -exec cp Segment+Align.sh {} \;
  find ./Transcripts -type d -exec cp Segment_Only.sh {} \;
  find ./Transcripts -type d -exec cp Segment_Directory.sh {} \;
 find ./Transcripts -type d -exec cp sentence-boundary.pl {} \;
 find ./Transcripts -type d -exec cp HONORIFICS {} \;

done