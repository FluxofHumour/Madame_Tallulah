#!/bin/bash
doit=""
trackcount=0
maxtrackcount=3
clear
echo "Starting script..."
while [ "$doit" != "q" ]
do
 read -n1 -p "Waiting for user input: " doit
 case $doit in
  d|D) kill $(pidof play)
       trackcount=$((trackcount+1))
       clear
       if [ $trackcount -gt 3 ]
       then
         echo "No Track!"
         trackcount=$((maxtrackcount))
       else
         play -q ./$trackcount.mp3
         echo "Now playing: " $trackcount ".mp3"
       fi ;;
  g|G) kill $(pidof play)
       trackcount=$((trackcount-1))
       clear
       if [ $trackcount -eq 0 ]
       then
         echo "No Track!"
         trackcount=1
       else
         play -q ./$trackcount.mp3
         echo "Now playing: " $trackcount ".mp3"
       fi ;;
  z|Z) kill $(pidof play)
       play -q ./1.mp3 &
       clear
       echo "Now playing: 1.mp3" ;;
  x|X) kill $(pidof play)
       play -q ./2.mp3 &
       clear
       echo "Now playing: 2.mp3" ;;
  c|C) kill $(pidof play)
       play -q ./3.mp3 &
       clear
       echo "Now playing: 3.mp3" ;;
  m|M) kill $(pidof play)
       clear
       echo "Stopping PLAY" ;;
  q|Q) kill $(pidof play)
       clear
       echo "Quiting"
       exit ;;
  *)   clear
       echo "Unknown key pressed!" ;;
 esac
done
