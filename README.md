## What is this all about?

A simple script to compare the performance (using your own machine! as this performance will vary) of various TTS models and vocoders.
Generates an HTML report like this, which you can sort and playback different WAV results to hear the difference yourself.

## Requirements

1. Make sure you have TTS installed. On Linux it's usually done with:

```
pip3 install TTS
```

but on Windows 10 it's a bit more tricky.
You'll need to install Python 3.9, as I tested that with 3.10 - it doesn't work.
You'll also need to install [Visual Studio Installer](xxxx) and make sure to install Windows 10 SDK.

## Usage

Start **runme.sh** script without any parameters. It will loop through all the TTS models (which are hardcoded so far in the script) and
ask **TTS** to generate the same phrase to speech using each of them.

Do a series of measurements, by passing a value of first and only parameter:
```
./runme.sh 1
```
... will run the same thing again, but this time log files will be named like xxxxx.1.log

Then run **collect.sh** script. It does some primitive logs parsing and generates HTML report you can open with your browser.
