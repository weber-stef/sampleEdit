#!/bin/bash
#Put files max_volume information at the end of the file name
filePath=$1
orgFileName=$2
# 1.define filePath - Variable
# filePath="./drs/BD/"  echo $filePath shows ./drs/BD/
# 1.b define fileName
# orgFileName="BD-Stef-001.wav"
# 1.c combie into one for usage in ffmpeg
pathFile=$filePath$orgFileName

# 2.get the volume with ffmpeg and grep only the line with the max_volume information
ffmpeg -i $filePath$orgFileName -filter:a volumedetect -f null - 2>&1 | grep max_volume 
# echo shows [Parsed_volumedetect_0 @ 0x5592e9a411c0] max_volume: -5.8 dB

#.3 get only what's written after the colon
ffmpeg -i $filePath$orgFileName -filter:a volumedetect -f null - 2>&1 | grep max_volume | sed 's/^.*: //'
# echo shows -5.8 dB

#.4 convert output string like "-5.8 dB" to "-5.8dB" 
ffmpeg -i $filePath$orgFileName -filter:a volumedetect -f null - 2>&1 | grep max_volume | sed 's/^.*: //' | sed 's/ //g'

#4. Put output in a variable by means of command substitution 
volVar=$(ffmpeg -i $filePath$orgFileName -filter:a volumedetect -f null - 2>&1 | grep max_volume | sed 's/^.*: //' | sed 's/ //g')
#echo $volVar shows -5.8dB

#shorten orgFileName to filename without extension and leading path
#nameOnly=$(basename "$orgFileName" .wav)
# since I want to put the db-info in the beginning of the file I do not need to do this

#5. simply concatenate the variables: mystring="$string1$string2"
#create name with "maxVol" and the db-value added
newName="maxVol$volVar-$orgFileName" 

#rename file
mv $filePath$orgFileName $filePath/"NewBD"/$newName
# Aus "BD-Stef-001.wav" in Ordner "./drs/BD/" wurde maxVol-5.8dB-BD-Stef-001.wav

# JUCHUU!!
