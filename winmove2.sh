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

if [ "$1" == "lt" ]; then
    IFS=$'\n'

    maxval=0
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
        if [ $cx2 -gt $x1 ]; then continue; fi
        if [ $maxval -ge $cx2 ]; then continue; fi
        
        maxval=$cx2
        bestwin=$wid
        lineno=$(($lineno+1))
    done
    
    xdotool windowactivate $bestwin
fi

if [ "$1" == "rt" ]; then
    IFS=$'\n'

    minval=10000000000
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
        if [ $cx1 -lt $x2 ]; then continue; fi
        if [ $minval -le $cx1 ]; then continue; fi
        
        minval=$cx1
        bestwin=$wid
        lineno=$(($lineno+1))
    done
    
    xdotool windowactivate $bestwin
fi

if [ "$1" == "up" ]; then
    IFS=$'\n'

    maxval=0
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
        if [ $cy2 -gt $y1 ]; then continue; fi
        if [ $maxval -ge $cy2 ]; then continue; fi
        
        maxval=$cy2
        bestwin=$wid
        lineno=$(($lineno+1))
    done
    
    xdotool windowactivate $bestwin
fi

if [ "$1" == "dn" ]; then
    IFS=$'\n'
    echo "dn"
    minval=10000000000
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
        if [ $cy1 -lt $y2 ]; then continue; fi
        if [ $minval -le $cy1 ]; then continue; fi
        
        minval=$cy1
        bestwin=$wid
        lineno=$(($lineno+1))
    done
    
    xdotool windowactivate $bestwin
fi

