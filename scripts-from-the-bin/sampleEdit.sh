#Put files max_volume information at the end of the file name
orgFileName=$1
echo $orgFileName
orgfileDir="$(dirname -- $orgFileName)"
oldBaseName="$(basename -- $orgFileName)"
echo "basename is $oldBaseName"
echo "directory is $orgfileDir"
#get the volume with ffmpeg and grep only the line with the max_volume information and convert its look and Put output in a variable by means>
volVar=$(ffmpeg -i $orgFileName -filter volumedetect -f null - 2>&1 | grep max_volume | sed 's/^.*: //' | sed 's/ //g')
echo "It's $volVar loud"
#create name with "maxVol" and the db-value added
newName="mvol${volVar}-${oldBaseName}"
#echo $newName
#rename file
mv $orgFileName $orgfileDir/$newName
echo "jetzt ist $newName in $orgfileDir"
# # cut silence after file sound and add "sc" to filename
# ffmpeg -i $newName -af "silenceremove=start_periods=1:stop_periods=-1:start_threshold=-50dB:stop_threshold=-50dB:start_silence=0:stop_silence=0" $silCutName
# echo mv  $silCutName $orgfileDir/$newName
#JUCHUU!!
