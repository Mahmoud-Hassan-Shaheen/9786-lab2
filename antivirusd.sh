#!/bin/bash

if [ $# -lt 3 ]
then
	echo "$0 needs 3 argument please (dir,malicious_dir,interval)"
	exit 1
fi



dir=$1
malicious_dir=$2
interval=$3



if [ ! -d "$malicious_dir" ]
then
	mkdir -p "$malicious_dir"
fi




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







if [ ! -f directory-info.last ]
then
	scan_files
	ls -l "$dir" > directory-info.last
fi





while true
do
	sleep $interval
	ls -l "$dir" > directory-info.new
	
	diff directory-info.last directory-info.new > /dev/null
	if [ $? -eq 0 ]
	then
		continue
	else
		scan_files
		cp directory-info.new directory-info.last
	fi
done





