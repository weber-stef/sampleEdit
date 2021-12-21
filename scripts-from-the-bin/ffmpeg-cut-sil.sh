#!/bin/bash
# cut silence after file sound
silCutName=$(ffmpeg -i $1 -af "silenceremove=start_periods=1:stop_periods=-1:start_threshold=-50dB:stop_threshold=-50dB:start_silence=0:stop_silence=0" -f ny
ull - 2>&1)
#echo $silCutName    
echo mv  $1 $silCutName
