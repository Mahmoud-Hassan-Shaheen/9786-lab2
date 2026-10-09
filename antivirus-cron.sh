#!/bin/bash

if [ $# -lt 2 ] || [ $# -gt 2 ]
then 
	echo "inputs are not valid please input the dir and malicious_dir"
	exit 1
fi
dir=$1
malicious_dir=$2
if [ ! -d "$dir" ] 
then
	echo "the directory to check is not there"
	exit 1
fi

if [ ! -d "$malicious_dir" ]
then
	mkdir -p "$malicious_dir"
fi

old=directory-info.last
new=directory-info.new





scan_files(){
for file in "$dir"/*
do 
if [ -f "$file" ]
then
	filename=$(basename "$file")
	is_bad=0
	case "$filename" in *.exe|*.bat|*.vbs|*.scr|*.ps1)
		is_bad=1
		;;
	esac
	
	if [ $is_bad -eq 0 ]
	then
		if grep -i -q -E "virus|trojan|malware|worm|ransomware" "$file" 2>/dev/null
		then
			is_bad=1
		fi
	fi
	
	if [ $is_bad -eq 1 ]
	then
		echo "$filename is malicious and it is DELETED"
		cp "$file" "$malicious_dir"
		rm -f "$file"
	fi
fi
done
}









if [ ! -f "$old" ]
then 
	scan_files
	ls -1 "$dir" > "$old"
else
	ls -1 "$dir" > "$new"
	
	cmp -s "$old" "$new"
	
	if [ $? -eq 0 ]
	then
		exit 0
	else
		scan_files
		ls -l "$dir" > "$old"
	fi
fi



