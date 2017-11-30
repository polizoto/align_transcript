# segment_transcript
The Segment_Only script segments an edited plain text file into "caption-ready" chunks. 

The Segment+Align script segments the TXT file into chunks and aligns it with audio, using Aeneas. The result is an SRT file.

NOTE: If you are just starting a captioning workflow for YouTube videos, we recommend using the YouTube.sh script to download the auto-Captions from YouTube https://github.com/polizoto/auto_captions_dl . That script will download the auto-captions (a "raw" transcript) which you can then edit before running Segment_Only.sh or Segment+Align.sh.

## Dependencies

Python 2.7 + (should be already installed on macOS)

Perl, fold (should be already installed on macOS)

Aeneas: https://github.com/readbeyond/aeneas
1. To install Aeneas and all its dependencies on macOS X 10.7 and up, we recommend the all-in-one installer provided by Daniel Bair: https://github.com/sillsdev/aeneas-installer/releases. The all in one installer will install Homebrew, a package manager for macOS, which will be used to install other dependences for these scripts.

2. If the first method does not work, we recommend using the steps Daniel Bair has provided at this github repo: https://github.com/danielbair/aeneas-installer_. These steps will also install HomeBrew. Follow these steps (from the ReadMe document):
  - Download the repository and extract the Mac_OSX_Installer folder
  - cd to Mac_OSX_Installer folder
  - run `build_setup.sh`
  - run `build_packages.sh`

N.B. This second method does not install FFMPEG, an Aeneas dependency, so you will be prompted to run `brew install ffmpeg`

Sed

`brew install gnu-sed --with-default-names`

rename

`brew install rename`

## Usage

Preliminary:
* Every sentence must be on the same line in the TXT file (1 single line of text)
* Include speaker IDs and non-speech sounds in brackets (they will be ignored for alignment)
* The TXT file and the AUDIO file must have the same name. They must also be located in the same directory.
* HONORIFICS is a file containing abbreviations with periods that should not be treated as the end of a sentence (for segmenting). This file should be in same directory as scripts. 
* sentence-boundary.pl is a perl script that places all the sentences in a TXT file on their own lines. This file should be in the same directory as the script.

1. Download or clone segment_transcript repository
2. Open the terminal (Mac)
3. CD to the directory with the scripts (Segment_Only.sh, Segment+Align.sh, HONORIFICS, and sentence-boundary.pl must all be in the same directory)
4. Make the scripts executable (one-time-only step)

`chmod +x path/to/Segment_Only.sh`

`chmod +x path/to/Segment+Align.sh`

3. Enter the path to the script and then enter the path to the TXT file:

`path/to/Segment_Only.sh path/to/file`

OR

`path/to/Segment+Align.sh path/to/text_file`

## Notes
- In Segment+Align.sh script, adjust, if necessary, the Aeneas command so that the correct audio file type is listed (Adjust other 'clean-up' commands with different file types as well). In addition, adjust Aeneas parameters as necessary (e.g., head/tail audio length)
- These scripts have been designed for use on a Mac. For scripts that will work on a PC, see this repo: https://github.com/polizoto/segment_transcript_pc
- For more information, please contact jpolizzotto@htctu.net
