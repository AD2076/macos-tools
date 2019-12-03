#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

source $DIR/_plist_utils.sh

tbk=~/Library/ad2076
mojave_tbk=~/Library/the-braveknight
if [[ ! -d $tbk ]]; then mkdir $tbk; fi
if [[ ! -d $mojave_tbk ]]; then mkdir $mojave_tbk; fi
plist=$tbk/org.ad2076.installed.plist
mojave_plist=$mojave_tbk/org.the-braveknight.installed.plist

function printInstalledItems() {
# $1: Array name (key) in root dictionary plist
# $2: mojave flag
    if [[$2]]; then 
        printArrayItems "$1" "$plist";
    else
        printArrayItems "$1" "$mojave_plist";
    fi
}

function addInstalledItem() {
# $1: Array name (key) in root dictionary plist
# $2: Item
    for item in $(printInstalledItems "$1"); do
        if [[ "$item" == "$2" ]]; then return; fi
    done
    addArray "$1" "$plist"
    appendArrayWithString "$1" "$2" "$plist"
}

function removeInstalledItem() {
# $1: Array key
# $2: Item
# $3: mojave flag
    if [[$3]]; then 
        index=$(indexForItemInArray "$1" "$2" "$plist")
        if [[ -n "$index" ]]; then
            removeItem "$1:$index" "$plist"
        fi
    else
        index=$(indexForItemInArray "$1" "$2" "$mojave_plist")
        if [[ -n "$index" ]]; then
            removeItem "$1:$index" "$mojave_plist"
        fi
    fi
}
