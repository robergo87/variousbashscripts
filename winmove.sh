#!/bin/bash


curr_window=`xdotool getactivewindow getwindowgeometry --shell`
eval $curr_window

x1=$(($X-0))
x2=$(($X+$WIDTH+0))
y1=$(($Y-0))
y2=$(($Y+$HEIGHT+0))
CURRSCREEN=$SCREEN
CURRWINDOW=`xdotool getactivewindow`

echo "$1 $x1,$x2,$y1,$y2\n"

IFS=$'\n'

minval=0
bestwin=0    
lineno=0

for line in `wmctrl -lG`
do
    IFS=$' \t'
    wrdno=0
    for wrd in $line
    do
        if [ $wrdno -eq 0 ]; then wid=$wrd; fi
        if [ $wrdno -eq 1 ]; then screen=$wrd; fi
        if [ $wrdno -eq 2 ]; then cx1=$wrd; fi
        if [ $wrdno -eq 3 ]; then cy1=$wrd; fi
        if [ $wrdno -eq 4 ]; then cx2=$(($cx1+$wrd)); fi
        if [ $wrdno -eq 5 ]; then cy2=$(($cy1+$wrd)); fi            
        wrdno=$(($wrdno+1))
    done
    if [ $screen -ne $CURRSCREEN ]; then continue; fi
    
    if [ $1 -eq "lt" ]; then
        if [ $cx2 -gt $x1 ]; then continue; fi
        dist=$(( ($cx2-$x1)*($cx2-$x1) + ($cy1-$y1)*($cy1-$y1) ))
    fi
    if [ $1 -eq "rt" ]; then
        if [ $cx1 -lt $x2 ]; then continue; fi
        dist=$(( ($cx1-$x2)*($cx1-$x2) + ($cy1-$y1)*($cy1-$y1) ))
    fi
    if [ $1 -eq "up" ]; then
        if [ $cy2 -gt $y1 ]; then continue; fi
        dist=$(( ($cx1-$x1)*($cx1-$x1) + ($cy2-$y1)*($cy2-$y1) ))
    fi
    if [ $1 -eq "dn" ]; then
        if [ $cy1 -gt $y2 ]; then continue; fi
        dist=$(( ($cx1-$x1)*($cx1-$x1) + ($cy1-$y2)*($cy1-$y2) ))
    fi
    
    if [ $minval -le $dist ]; then continue; fi
    
    minval=$dist
    bestwin=$wid
    lineno=$(($lineno+1))
done

xdotool windowactivate $bestwin

