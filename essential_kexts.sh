#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

source $DIR/_plist_utils.sh

plist=$DIR/org.the-braveknight.essential.plist

printArrayItems "Kexts" $plist
