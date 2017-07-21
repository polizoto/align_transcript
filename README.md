# segment_transcript
This script segments an edited plain text file into "caption-ready" chunks. It then aligns the text file with audio, using Aeneas.

NOTE: If you are just starting a captioning workflow for YouTube videos, we recommend using the YouTube.sh script to download the auto-Captions from YouTube https://github.com/polizoto/auto_captions_dl . That script will download the auto-captions (a "raw" transcript) which you can then edit before running segment/transcript.

## Dependencies

* `brew install gnu-sed --with-default-names`

Aeneas (https://github.com/readbeyond/aeneas/blob/master/wiki/INSTALL.md)

## Usage
1. Every sentence must be on the same line in the TXT file (1 single line of text)
2. Include speaker IDs and non-speech sounds in brackets (they will be ignored for alignment)
3. the TXT file and the AUDIO file must have the same name and be located in the same directory.
4. HONORIFICS is a file containing abbreviations with periods that should not be treated as the end of a sentence (for segmenting)
5. Adjust the Aeneas command so that the correct audio file type is listed (Adjust other 'clean-up' commands with different file types as well). In addition, adjust Aeneas parameters as necessary (e.g., head/tail audio length)

`./Segment_Transcript.sh path_to_text_file`

