#!/bin/bash

clear

### Reminder: 0 = false, 1 = true ###

# get input from output of command
# PW_DIR=$(pwd)
SRN_CAP=$(defaults read com.apple.screencapture disable-shadow)
SRN_TYPE=$(defaults read com.apple.screencapture "type")

#clear errors if settings have not been created
clear

# check for true condition, since default (or never created) setting is false
if [ "$SRN_CAP" = "1" ]
then
    echo "Comm1: Screenshot drop shadows are currently: --Disabled--" 
else
    echo "Comm1: Screenshot drop shadows are currently: --Enabled--"
fi
# same method, in shorthand
# [ "$SRN_CAP" = "0" ] && \
#       echo "Comm1: Screencapture drop shadow: Enabled"
# [ "$SRN_CAP" = "1" ] && \
#       echo "Comm1: Screencapture drop shadow: Disabled"

if [ "$SRN_TYPE" = "jpg" ]
then
    echo "Screenshots saved as: --JPG--"
else
    echo "Screenshots saved as: --PNG--"
fi

# decision menu
echo
echo "Press 1 to ADD drop SHADOW to screenshots"
echo "Press 2 to REMOVE drop SHADOW from screenshots"
echo "To RESET drop SHADOW to default, press S"
echo
echo "Press 3 to set screenshot FILE TYPE to JPG"
echo "Press 4 to set screenshot FILE TYPE to PNG"
echo "To RESET screenshot FILE TYPE, press T"
echo

# process decision
while true; do
    read -p "Press any other key to exit: " 
    case $REPLY in
        1) defaults write com.apple.screencapture disable-shadow -bool false; killall SystemUIServer;
             echo "Screenshot drop shadows are currently: --Enabled--"; break; ;;
        2) defaults write com.apple.screencapture disable-shadow -bool true; killall SystemUIServer;
            echo "Screenshot drop shadows are currently: --Disabled--"; break; ;;
        [Ss]* ) defaults delete com.apple.screencapture disable-shadow; killall SystemUIServer; clear;
            echo "Screenshot drop shadows have been RESET"; break; ;;
        3) defaults write com.apple.screencapture "type" -string "jpg" 
            echo "Screenshots now saved as: --JPG--"; break; ;;
        4) defaults write com.apple.screencapture "type" -string "png"
            echo "Screenshots saved as: --PNG--"; break; ;;
        [Tt]* ) defaults delete com.apple.screencapture "type"; clear;
            echo "Screenshot file type has been RESET"; break; ;;
        *) echo "\nNo changes made."; break; ;;
    esac
done