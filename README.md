# segment_transcript
The Segment_Only script segments an edited plain text file into "caption-ready" chunks. 

The Segment+Align script segments the TXT file into chunks and aligns it with audio, using Aeneas. The result is an SRT file.

NOTE: If you are just starting a captioning workflow for YouTube videos, we recommend using the YouTube.sh script to download the auto-Captions from YouTube https://github.com/polizoto/auto_captions_dl . That script will download the auto-captions (a "raw" transcript) which you can then edit before running Segment_Only.sh or Segment+Align.sh.

## Dependencies

Python 2.7 + (should be already installed on macOS)

Perl, fold (should be already installed on macOS)

Homebrew: https://brew.sh/
- we recommend installing this package manager for macOS, since it makes installing dependencies easier.
- paste the following code into a mac Terminal and press Return
`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

Sed

`brew install gnu-sed --with-default-names`

rename

`brew install rename`

Aeneas: https://github.com/readbeyond/aeneas
- To install Aeneas and all its dependencies on macOS X 10.7 and up, we recommend the aeneas-installer method provided by Daniel Bair (https://github.com/danielbair/aeneas-installer_)
  - Download the repository and extract the Mac_OSX_Installer folder
  - cd to Mac_OSX_Installer folder
  - run `build_setup.sh`
  - run `build_packages.sh`

N.B. You may also be prompted to run `brew install ffmpeg`

## Usage

Preliminary:
* Every sentence must be on the same line in the TXT file (1 single line of text)
* Include speaker IDs and non-speech sounds in brackets (they will be ignored for alignment)
* The TXT file and the AUDIO file must have the same name. They must also be located in the same directory.
* HONORIFICS is a file containing abbreviations with periods that should not be treated as the end of a sentence (for segmenting). This file should be in same directory as scripts. 
* sentence-boundary.pl is a perl script that places all the sentences in a TXT file on their own lines. This file should be in the same directory as the script.
1. Open the Terminal
2. CD to the directory with the scripts.
3. Enter the path to the script and then enter the path to the TXT file:

`./Segment_Only.sh path_to_text_file`

OR

`./Segment+Align.sh path_to_text_file`

## Notes
- In Segment+Align.sh script, adjust, if necessary, the Aeneas command so that the correct audio file type is listed (Adjust other 'clean-up' commands with different file types as well). In addition, adjust Aeneas parameters as necessary (e.g., head/tail audio length)
- These scripts have been designed for use on a Mac. For scripts that will work on a PC, see this repo: https://github.com/polizoto/segment_transcript_pc
- For more information, please contact jpolizzotto@htctu.net
