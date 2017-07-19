# segment_transcript
This script segments a plain text file into "caption-ready" chunks. It then aligns the text file with audio, using Aeneas.

## Dependencies
Sed

Perl Script from University of Illinois:
https://cogcomp.cs.illinois.edu/page/tools_view/2

Aeneas (https://github.com/readbeyond/aeneas)
- system-wise installation (add path to aeneas in ~bash.profile)

## Usage
1. Every sentence must be on the same line in the TXT file (1 single line of text)
2. Include speaker IDs and non-speech sounds in brackets (they will be ignored for alignment)
3. the TXT file and the AUDIO file must have the same name and be located in the same directory.
4. HONORIFICS is a file containing abbreviations with periods that should not be treated as the end of a sentence (for segmenting)
5. Adjust the Aeneas command so that the correct audio file type is list. In addition, adjust Aeneas parameters as you see fit (e.g., head/tail audio length)

<Segment_Transcript.sh path_to_text_file>

