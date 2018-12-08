#!/bin/bash

sleep 5

if [ ! -d ~/.scrot ]; then
    mkdir ~/.scrot
fi

if (($# < 1)); then
    times=1
else
    times=$1
fi

for ((i=1; i<=$times; ++i))
do
    echo -n "$i.. "
    scrot -u -e 'mv $f ~/.scrot/'
    sleep 1
done

echo Done.
