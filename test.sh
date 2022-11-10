#!/bin/bash
rm *.mp3
for i in {01..12}
do
	touch $i" - test with many lines()and 'Symbols\' file$i.mp3"
done
touch fileB.mp3
