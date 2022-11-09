#!/bin/bash
#Arguments <song name.mp3> <place in list>
lower=0
filenames=`ls ./*.mp3`
if [ -f "$1" ]; then
	reName="$2_$1"
	mv $1 $reName
	for file in $filenames
	do
		index=$(echo $file | sed 's@^[^0-9]*\([0-9]\+\).*@\1@')
		re='^[0-9]+$'
		if [[ $index =~ $re ]] ; then
			#check if much lower than first item, if so, no need to increment
			if [[ $(($2+1)) -lt $index ]] && [[ $lower -eq 0 ]]; then
				break
			else
				lower=1
			fi
			if [[ $index -ge $2 ]]; then
				newName=$(echo $file|cut -d'-' -f 2)
				newName="$((index+=1))_$newName"
				mv $file $newName
			fi
		fi
	done

else
	echo "$1 Does not exist"
fi
