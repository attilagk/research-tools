#!/bin/bash

# Protects all files and directories that reside in the directory of the
# script and that are owned by the user.

#mydir=$(dirname $(realpath $0)) # realpath is not part of older systems
mydir=$(echo $0 | sed 's/\(.*\)\/[^/]\+/\1/')
tempfile=$(mktemp)
errormsg="usage: ./$(basename $0) on|off"

# refuse to run from the default directory
defaultdir=$HOME/bin 
msg="`basename $0`: I must reside in a directory different from ${defaultdir}; copy or link me to the target directory"
test $mydir = $defaultdir && { echo $msg >&2; exit 1; }

# ensure there is exactly 1 positional argument
if [ $# != 1 ]
then echo $errormsg; exit 1
fi

# switch protection on or off?
if [ $1 = on ]
then optnot=""; modeop="-"; optun=""
elif [ $1 = off ]
then optnot="-not" modeop="+"; optun="un"
else echo $errormsg; exit 1
fi

# find files whose modes are to be changed, if any
find $mydir -mindepth 1 -user $USER $optnot -writable -not -name $(basename $0) > $tempfile
numchanged=$(wc -l $tempfile | cut -f 1 -d ' ')

# change file modes unless no change is needed
if [ $numchanged = 0 ]
then
    echo "All of your files or directories are ${optun}protected."
else
    xargs chmod ug${modeop}w < $tempfile
    echo "$numchanged of your files or directories became ${optun}protected."
fi
