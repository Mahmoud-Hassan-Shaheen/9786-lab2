#!/bin/bash

if [ $# -lt 2 ]
then
	echo "$0 needs 2 inputs dir malicious_dir"
	exit 1
fi



dir=$1
malicious_dir=$2



check_empty_bad_files()
{
count=0
for file in "$malicious_dir"/*
do
	if [ -f "$file" ]
	then
		count=`expr $count + 1`
	fi
done

if [ $count -eq 0 ]
then
	echo "No malicious files to review."
	exit 0
fi
}












while true
do
	check_empty_bad_files
	
	
	echo "the quarantined files is :"
	i=1
	for file in "$malicious_dir"/*
	do
		if [ -f "$file" ]
		then
			filename=$(basename "$file")
			echo "$i : $filename"
			i=`expr $i + 1`
		fi
	done
	
	
	
	echo "pick a file by the number : "
	
	
	read choice_num
	j=1
	chosenFile=""
	
	for file in "$malicious_dir"/*
	do
		if [ -f "$file" ]
		then
					
			if [ $j -eq $choice_num ]
			then
				chosenFile="$file"
				break
			fi
			j=`expr $j + 1`
		fi		
	done
	
	

	
	
	if [ -z "$chosenFile" ]
	then
		echo "Invalid choice. Please try again."
		continue
	fi
	
	
	
	
	
	filename=$(basename "$chosenFile")
	echo "options:"
	echo "Input 1: Restore this file back into $dir"
	echo "Input 2: permanently delete this file from $malicious_dir"
	echo "Input 3: leave this file as-is and go back to the list"
	read option_num
	
	if [ $option_num = "1" ]
	then
		cp "$chosenFile" "$dir"
		rm "$chosenFile"
		echo "$filename" >> whitelist.txt
		echo "Restored $filename to $dir."
	elif [ $option_num = "2" ]
	then
		rm "$chosenFile"
		echo "$filename permanently deleted."
	elif [ $option_num = "3" ]
	then
		continue
	else
		echo "Invalid option."
	fi
done
		
	

