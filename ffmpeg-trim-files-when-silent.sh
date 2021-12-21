#Shorten long files with silence in loop

for file in *.wav; do ffmpeg -i "$file" -af "silenceremove=start_periods=1:stop_periods=-1:start_threshold=-50dB:stop_threshold=-50dB:start_silence=0:stop_silence=0" "cut-${file%.wav}.wav"; done
