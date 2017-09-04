#!/bin/bash

while read line
do
sh get_downloads.sh "$line"
done < control_sras_35.txt

