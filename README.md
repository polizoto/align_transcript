# align_transcript
These scripts segment edited plain text files into "caption-ready" chunks and align them with audio files, using Aeneas. The result is an SRT file.

NOTE: If you are just starting a captioning workflow for YouTube videos, we recommend using the YouTube.sh script to download the auto-Captions from YouTube https://github.com/polizoto/auto_captions_dl . That script will download the auto-captions (a "raw" transcript) which you can then edit before running Align_Transcripts.sh.

## Dependencies

Python 2.7 + (should be already installed on macOS)

Perl, fold (should be already installed on macOS)

Aeneas: https://github.com/readbeyond/aeneas
1. To install Aeneas and all its dependencies on macOS X, we recommend the all-in-one installer provided by Daniel Bair: https://github.com/sillsdev/aeneas-installer/releases. The all-in-one installer will install Homebrew, a package manager for macOS, which will be used to install other dependences for these scripts.

2. If the first method does not work, we recommend using the steps Daniel Bair has provided at this github repo: https://github.com/danielbair/aeneas-installer_. These steps will also install Homebrew. Follow these steps (from the ReadMe document):
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
* Include speaker IDs and non-speech sounds in brackets (they will be ignored for alignment)- not necessary when you have PROFESSOR or STUDENT in all caps as speakers ids.
* The TXT file and the AUDIO file must have the same name. They must also be located in a directory entitled 'Transcripts' that is in the same directory as the scripts. (If a "Transcripts" folder doesn't exist or if there are no TXT files in it, the Align_Transcripts.sh script will abort.)
* HONORIFICS is a file containing abbreviations with periods that should not be treated as the end of a sentence (for segmenting). 
* sentence-boundary.pl is a perl script that places all the sentences in a TXT file on their own lines.

1. Download or clone segment_transcript repository
2. Open the terminal (Mac)
3. CD to the directory with the scripts (Align_Transcripts.sh, Segment_Only.sh, Segment+Align.sh, HONORIFICS, sentence-boundary.pl, create_directory.sh, and segment_directory.sh must all be in the same directory)
4. Make the scripts executable (one-time-only step)

`chmod +x path/to/Align_Transcripts.sh`

`chmod +x path/to/Segment_Only.sh`

`chmod +x path/to/Segment+Align.sh` etc.

5. Place transcripts + audio files (optional) in a folder named "Transcripts".

6. Enter the path to `Align_Transcript.sh` script and press Enter. (a TXT file must at least be present in 'Transcripts' directory)

`./Align_Transcripts`

## Notes
- In Segment+Align.sh script, adjust, if necessary, the Aeneas parameters (e.g., head/tail audio length)
- These scripts have been designed for use on a Mac. For scripts that will work on a PC, see this repo: https://github.com/polizoto/segment_transcript_pc
- For more information, please contact jpolizzotto@htctu.net
