#!/bin/bash
#Arguments <song name.mp3> <place in list>
SAVEIFS=$IFS #to prevent spaces breaking the foor loop
IFS=$(echo -en "\n\b")
lower=0
if [ -f "$1" ]; then
	filenames=`ls ./*.mp3`
	reName="$(printf %02d $2) - $1"
	mv $1 $reName
	for file in $filenames
	do
		index=$(echo $file | sed 's@^[^0-9]*\([0-9]\+\).*@\1@')
		re='^[0-9]+$'
		if [[ $index =~ $re && $file != "./$1" ]] ; then
			#check if much lower than first item, if so, no need to increment
			if [[ $((${2#0}+1)) -lt ${index#0} ]] && [[ $lower -eq 0 ]]; then
				break
			else
				lower=1
			fi
			if [[ ${index#0} -ge ${2#0} ]]; then
				newName=$(echo $file|cut -d'-' -f 2)
				newName="$(printf %02d $((${index#0}+1))) - $newName"
				mv $file $newName
			fi
		fi
	done

else
	echo "$1 Does not exist"
fi
IFS=$SAVEIFS
