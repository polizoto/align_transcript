#!/bin/bash
# Joseph Polizzotto
# Script used in captioning workflow
# This script has been tested to work on MacOS; please contact me for any questions about use on other platforms
# This script should be run after each sentence has been placed on its own line (use sentenceboundary.pl script)
# 408-996-6044

# check dependencies 
command -v aeneas_execute_task >/dev/null 2>&1 || { echo >&2 "aeneas_execute_task not found please install from https://github.com/readbeyond/aeneas/blob/master/wiki/INSTALL.md)"; exit 1; }

command -v rename >/dev/null 2>&1 || { echo >&2 "rename dependency not found. Please install using 'brew install rename'"; exit 1; }
 
###### SCRIPT #######
for f in "$@"
do
# Get the full file PATH without the extension
filepathWithoutExtension="${f%.*}"

# segment transcript into sentences
perl sentence-boundary.pl -d HONORIFICS -i "$f" -o test.txt

# Add blank line after every new line

sed -e 'G' test.txt > test2.txt

# Clean up
rm test.txt
rm "$f"

 # Break each line at 35 characters

fold -w 35 -s test2.txt > test3.txt

# Clean up further
rm test2.txt

 # Insert new line for every two lines, preserving paragraphs

perl -00 -ple 's/.*\n.*\n/$&\n/mg' test3.txt > "$f"

# Clean up further
rm test3.txt

# Convert audio file (mp4, mkv et al.) to Constant Bit Rate MP3
ffmpeg -i *.mp4 -ab 128k -f mp3 - >"$f".mp3
# ffmpeg -i *.mkv -ab 128k -f mp3 - >"$f".mp3

# Rename Non CBR files (so they can be deleted in next step)
rename 's/.mp4/.txt.mp4/g' *.mp4
# rename 's/.mkv/.txt.mkv/g' *.mkv
# rename 's/.mp3/.txt.mp3/g' *.mp3

# Remove non CBR files
rm "$f".mp4
# rm "$f".mkv

# Run Aeneas on pairs of Audio + Text

# aeneas_execute_task "$f".mp4 "$f" "task_language=eng|os_task_file_format=srt|is_text_type=subtitles|is_audio_file_head_length=12.000|is_audio_file_tail_length=6.000|task_adjust_boundary_nonspeech_min=1.000|task_adjust_boundary_nonspeech_string=REMOVE|task_adjust_boundary_algorithm=percent|task_adjust_boundary_percent_value=75|is_text_file_ignore_regex=[*]" "$f".srt --output-html
aeneas_execute_task "$f".mp3 "$f" "task_language=fr|os_task_file_format=srt|is_text_type=subtitles|task_adjust_boundary_nonspeech_min=1.000|task_adjust_boundary_nonspeech_string=REMOVE|task_adjust_boundary_algorithm=percent|task_adjust_boundary_percent_value=75|is_text_file_ignore_regex=[*]" "$f".srt --output-html

# Rename path to audio/video file in HTML directory

# sed -ri 's/.txt.mp4/.mp4/' "$f".srt.html
 sed -ri 's/.txt.mp3/.mp3/' "$f".srt.html


# Rename Files
rename 's/.txt.srt/.srt/g' *.srt
rename 's/.txt.srt.html/.html/g' *.html
# rename 's/.txt.mp4/.mp4/g' *.mp4
rename 's/.txt.mp3/.mp3/g' *.mp3

# Playback video
# mpv *.mp3

# Open Finetuneas Page
open *.html
done