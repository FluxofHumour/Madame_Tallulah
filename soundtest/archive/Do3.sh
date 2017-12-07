#!/bin/bash
doit=""
trackcount=0
maxtrackcount=4
clear
echo "Starting script..."
while [ "$doit" != "q" ]
do
 read -n1 -p "Waiting for user input: " doit
 case $doit in
  p|P) kill $(pidof play)
       clear
       if [ $trackcount -gt 3 ]
       then
         echo "Track: " $trackcount " does not exist"
         echo "Setting  track to: " $maxtrackcount
         trackcount=4
       elif [ $trackcount -lt 1 ]
       then
         echo "Track: " $trackcount " does not exist"
         echo "Setting  track to: 0"
         trackcount=0
       else
         echo "Now playing: " $trackcount ".mp3"
         play -q ./$trackcount.mp3 fade q 00:00:10 &
       fi ;;
  e|E) kill $(pidof play)
       trackcount=$((trackcount+1))
       clear
       if [ $trackcount -gt 3 ]
       then
         echo "No Track!"
         trackcount=4
       elif [ $trackcount -lt 1 ]
       then
         echo "No Track!"
         trackcount=0
       else
         play -q ./$trackcount.mp3 fade q 00:00:10 &
         echo "Now playing: " $trackcount ".mp3"
       fi ;;
  d|D) kill $(pidof play)
       trackcount=$((trackcount-1))
       clear
       if [ $trackcount -lt 1 ]
       then
         echo "No Track!"
         trackcount=0
       else
         play -q ./$trackcount.mp3 fade q 00:00:10 &
         echo "Now playing: " $trackcount ".mp3"
       fi ;;
  l|L) kill $(pidof play)
       clear
       echo "Stopping PLAY" ;;
  w|W) sudo kill $(pidof python stepperC.py)
       sudo kill $(pidof python stepperA.py)
       clear
       sudo python ./stepperC.py &
       echo "Got the Motor running clockwise :)" ;;
  s|S) sudo kill $(pidof python stepperC.py)
       sudo kill $(pidof python stepperA.py)
       clear
       sudo python ./stepperA.py &
       echo "Got the Motor running anti-closkwise:)" ;;
  x|X) sudo kill $(pidof python stepperC.py)
       sudo kill $(pidof python stepperA.py)
       clear
       echo "STOP the Motor running" ;;
  q|Q) kill $(pidof play)
       clear
       echo "Quiting"
       exit ;;
  *)   clear
       echo "Unknown key pressed!" ;;
 esac
done
