#!/bin/bash

NAME=""
GREETING="Good Morning"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USAGE(){
    echo "USAGE:: $(basename $0) -n <name> -w <greeting>"
    echo "Options::"
    echo "-n, Specify the name (Mandatory)"
    echo "-w, Specify the wishes (optional). Default in Good Morning"
    echo "-h, Display help and exit" 

}

while getopts ":n:w:h" opt; do #h for help
    case $opt in
        n) NAME="$OPTARG";;
        w) GREETING="$OPTARG";;
        \?) echo "invalid options: -"$OPTARG"" >&2 USAGE; exit;;
        :) USAGE; exit;; #this is for empty arrguments
        h) USAGE; exit;;
    esac
done

#if [ -z "$NAME" ] && [ -z "$GREETING" ]; then
if [ -z "$NAME" ]; then #now greeting is optional
    #echo -e "$R ERROR:$N both -n and -w are mandatory options"
    echo -e "$R ERROR:$N -n is mandatory"
    USAGE
    exit 1
fi

echo "Hello $NAME. $GREETING. Thanks for reaching us out"