#Put files max_volume information at the end of the file name
orgFileName=$1
echo $orgFileName
oldBaseName="$(basename -- $orgFileName)"
echo "basename is $oldBaseName"
#get the volume with ffmpeg and grep only the line with the max_volume information and convert its look and Put output in a variable by means>
volVar=$(ffmpeg -i $orgFileName -filter volumedetect -f null - 2>&1 | grep max_volume | sed 's/^.*: //' | sed 's/ //g')
echo "It's $volVar loud"
#create name with "maxVol" and the db-value added
newName="mvol${volVar}-${oldBaseName}"
echo $newName
#rename file
mv $orgFileName $newName
# JUCHUU!!
