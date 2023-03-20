## What is this all about?

A simple script to compare the performance (using your own machine! as this performance will vary) of various **Coqui-AI TTS** models and vocoders.
Generates an HTML report like this, which you can sort and playback different WAV results to hear the difference yourself:

![Example report](https://github.com/kha84/tts-comparison/raw/32edd65d6050a8929b9bcd88c0069a1416c89c8f/report.png)

(Example report with generated wav files can be found in "example" directory) 

Read more about what is [Coqui-AI TTS on appropriate repo](https://github.com/coqui-ai/TTS)

## Requirements

1. Make sure you have TTS installed. On Linux it's usually done with:

```
# create a local virtual env to not clutter your system & activate it 
pip3 -m venv ./venv
. ./venv/bin/activate
# install dependencies
pip3 install TTS
```

On Windows 10 it's a bit more tricky:
* You'll need to install Python 3.9, as I tested that with 3.10 - it doesn't work.
* You'll also need to install [Visual Studio Installer](https://visualstudio.microsoft.com/downloads/) and make sure to install Windows 10 SDK.

2. On Linux you'll also need `espeak` or `espeak-ng` packages installed for some of the models 

## Usage

Start **runme.sh** script without any parameters. It will loop through all the TTS models (which are hardcoded so far in the script) and
ask **TTS** to generate the same phrase to speech using each of them.

Do a series of measurements, by passing a value of first and only parameter:
```
./runme.sh 1
```
... will run the same thing again, but this time log files will be named like xxxxx.1.log
It is advised to run multiple iterrations, as TTS generation performance depends on system resources and libraries being loaded to cache, appropriate
model files being cached, etc etc. So running the whole stuff over and over again, we can somehow account-in these factors.

Then run **collect.sh** script without any parameters. It does some primitive logs parsing and generates HTML report you can open with your browser.
Click on a table header will sort the table by values of that column.

## Cleanup notes

Make sure to look into ~/.local/share/tts/ and delete all the model files, if you done with your comparison - they might take some great amount of space.
