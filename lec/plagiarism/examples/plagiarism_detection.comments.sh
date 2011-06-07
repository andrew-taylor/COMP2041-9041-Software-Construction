#!/bin/sh

# written by andrewt@cse.unsw.edu.au as a COMP2041 example
# Report of any the assignment submissions
# given as arguments are copies of each other,e.g.:
# plagiarism_detection assignments/*
# The use of diff -iw means changes in white-space and case
# won't affect comparisons
# The substitution s/\/\/.*//  removes // style C comments
# which means changes in such comments won't affect comparisons

TMP_FILE1=/tmp/plagiairism_tmp1$$
TMP_FILE2=/tmp/plagiairism_tmp2$$


for file1 in "$@"
do
	for file2 in "$@"
	do
		if test "$file1" = "$file2"
		then
			continue
		fi
		sed 's/\/\/.*//' "$file1" >$TMP_FILE1
		sed 's/\/\/.*//' "$file2" >$TMP_FILE2
		if diff -i -w $TMP_FILE1 $TMP_FILE2 >/dev/null
		then
			echo "$file1 is a copy of $file2"
		fi
	done
done
rm -f $TMP_FILE1 $TMP_FILE2
