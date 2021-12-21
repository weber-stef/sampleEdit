#!/bin/bash

for file in $1 ; do ffmpeg -i "$file" -af "silenceremove=start_periods=1:stop_periods=-1:start_threshold=-$2dB:stop_threshold=-$2dB:start_silence=0:stop_silence=0" "${file%.*}"-c.wav; mv "${file%.*}"-c.wav "${file%.*}".wav; done >> notes.txt