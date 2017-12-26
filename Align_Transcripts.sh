#!/bin/bash
# Joseph Polizzotto
# Script used in captioning workflow
# This script has been tested to work on MacOS; please contact me for any questions about use on other platforms
# This script should be run after each sentence has been placed on its own line (use sentenceboundary.pl script)
# 408-996-6044

# check dependencies 

set -e

command -v aeneas_execute_task >/dev/null 2>&1 || { echo >&2 "aeneas_execute_task not found please install from https://github.com/readbeyond/aeneas/blob/master/wiki/INSTALL.md)"; exit 1; }

command -v rename >/dev/null 2>&1 || { echo >&2 "rename dependency not found. Please install using 'brew install rename'"; exit 1; }
 
###### SCRIPT #######
exec > >(tee -a ./log.txt) 2>&1

for f in ./

do 

if [ -f ./Transcripts/*.txt ]; then

	echo -e "\nFound these TXT files in" 'Transcripts' "folder for segmenting/aligning:\n"
	ls ./Transcripts/*.txt
	
else
	
	echo -e "\033[31m\nA 'Transcripts' folder doesn't exist or there are no TXT files located in the 'Transcripts' folder.\033[0m\n" >> ./log.txt
	
	echo -ne $(cat ./log.txt | sed  's/$/\\n/' | sed 's/ /\\a /g')
	
	# Clean Up Color Codes in Report
	sed -i 's/\x1b\[[0-9;]*[a-zA-Z]//g' log.txt
	sed -i 's/\\033//g' log.txt
	sed -i 's/\[32m//g' log.txt
	sed -i 's/\[33m//g' log.txt
	sed -i 's/\[0m//g' log.txt
	
	mv ./log.txt align_log_$(date +%H%M:%m:%d:%Y).txt
    
    exit 1
fi

# Add Completed directory if missing
if [ ! -d ./Completed ]; then

mkdir Completed

fi

mv log.txt ./Completed

./create_directory.sh

cd ./Transcripts && ./Segment_Directory.sh

cd ..

# Move all the subdirectories to Completed folder
mv ./Transcripts/*/ ./Completed

# Check for transcripts that were segmented only

if [ -f "./Transcripts/segment_only.txt" ]; then
mv ./Transcripts/segment_only.txt ./Completed
fi

rm ./Transcripts/Segment+Align.sh
rm ./Transcripts/Segment_Only.sh
rm ./Transcripts/Segment_Directory.sh
rm ./Transcripts/sentence-boundary.pl
rm ./Transcripts/HONORIFICS

# Move to Completed directory and run reports

cd ./Completed

touch report.txt

if grep -q ".srt.html" ./log.txt; then

   echo -e "\nAn SRT file was created for the following transcripts:\n" >> report.txt
   
   grep ".srt.html" ./log.txt >> report.txt
   
   sed -i "s/\[INFO\] Created file //" report.txt
   
   sed -i "s/'//" report.txt
   
   sed -i "s/.srt.html'//" report.txt
   
   sed -i "s/.\///" report.txt

  echo -e "\033[0m" >> report.txt
  
  echo -e "Open the HTML file to check the timestamps and adjust if necessary." >> report.txt
  
  else 
  
  echo -e "\nAn SRT file was created for the following transcripts:\n" >> report.txt
  
  echo -e "\033[39mNo SRT files were created.\033[0m" >> report.txt

fi

if [ "$(ls -A ../Transcripts/*.mp4)" ]; then

echo -e "\nThese mp4 files did not have transcripts for alignment:" >> report.txt

echo -e "\033[31m" >> report.txt

ls ../Transcripts/*.mp4 >> report.txt

sed -i "s/..\/Transcripts\///" report.txt

echo -e "\033[0m" >> report.txt

else 

echo -e "\nThese mp4 files did not have transcripts for alignment:" >> report.txt

echo -e "\033[32m\nNo mp4 files were missing transcripts for alignment. \033[0m\n" >> report.txt

fi

if [ -f "./segment_only.txt" ]; then

echo -e "These transcripts did not have audio files for alignment and were segmented only:" >> report.txt

cat ./segment_only.txt >> report.txt

rm -r ./segment_only.txt

else 

echo -e "These transcripts did not have audio files for alignment and were segmented only:" >> report.txt

echo -e "\033[32m\nNo transcripts were missing audio files.\033[0m\n" >> report.txt

fi

rm -r ./log.txt

echo -e "\nalign_log for captions files created at "$(date +%H:%M/%m/%d/%Y) | cat - report.txt > temp && mv temp report.txt

# Add New line to end of the report
echo "" >> report.txt

# Display Report
echo -ne $(cat ./report.txt | sed  's/$/\\n/' | sed 's/ /\\a /g')

# Clean Up Color Codes in Report
sed -i 's/\x1b\[[0-9;]*[a-zA-Z]//g' report.txt
sed -i 's/\\033//g' report.txt
sed -i 's/\[32m//g' report.txt
sed -i 's/\[33m//g' report.txt
sed -i 's/\[0m//g' report.txt

# delete empty white space at top of document
sed -i '/./,$!d' report.txt

# Move report to home directory
mv ./report.txt ../

cd ..

# Rename Log with date
mv ./report.txt align_log_$(date +%H%M:%m:%d:%Y).txt

done