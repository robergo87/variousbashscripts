#!/bin/bash

TEST=`whereis -b xdotool | sed "s/ *//"`
if [ "$TEST" == "xdotool:" ]; then
    echo "ERROR: missing xdotool"
    exit
fi

TEST=`whereis -b wmctrl | sed "s/ *//"`
if [ "$TEST" == "wmctrl:" ]; then
    echo "ERROR: missing wmctrl"
    exit
fi


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
INSTALL_DIR='/usr/share/robergo_scripts'
if [ $DIR == $INSTALL_DIR ]; then
    echo "you can't run install script from /usr/share/robergo_scripts"
    exit
fi

if [ -f $INSTALL_DIR ]; then
    mkdir $INSTALL_DIR
fi 

TMP=`cp -avr $DIR/* "$INSTALL_DIR/"` 
chmod -R 755 $INSTALL_DIR
echo "done, bind following scripts"

echo "$INSTALL_DIR/winmove2.sh up"
echo "$INSTALL_DIR/winmove2.sh dn"
echo "$INSTALL_DIR/winmove2.sh lt"
echo "$INSTALL_DIR/winmove2.sh rt"

if [ 0 -eq 1 ]; then
    currbindings=`gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings`
    currbindings=`echo $currbindings | sed "s/@as //"`

    isbinded=`echo $currbindings | sed "s/custom-window-focus//"`
    bindpath="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-window-focus-up/"

    if [ $isbinded == $currbindings ]; then
        echo "added keybinding entry"
        currbindings=`echo $currbindings | sed "s/]//"`
        if [ $currbindings == "[" ]; then
            currbindings="['$bindpath']"
        else
            currbindings="$currbindings,'$bindpath']"
        fi
        
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings $currbindings
    fi

    fullbindpath="org.gnome.settings-daemon.plugins.media-keys.custom-keybindings:$bindpath"

    gesettings set $fullbindpath name windowup
    gesettings set $fullbindpath command 


    # gsettings set ...media-keys.custom-keybinding:.../media-keys/custom-keybindings/custom3/ name "<name>"

    echo $currbindings

fi
