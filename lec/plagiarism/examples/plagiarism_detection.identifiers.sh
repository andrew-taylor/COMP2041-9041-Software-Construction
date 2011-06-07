#!/bin/sh

# written by andrewt@cse.unsw.edu.au as a COMP2041 example
# Report of any the assignment submissions
# given as arguments are copies of each other,e.g.:
# plagiarism_detection assignments/*

# The use of diff -iw means changes in white-space and case
# won't affect comparisons

# The substitution s/\/\/.*//  removes // style C comments
# which means changes in such comments won't affect comparisons
# The substitution s/"["]*"/s/g changes strings to the letter s
# which means changes to strings won't affect comparison.
# This pattern won't match a few C strings which is fine for our purposes
# The  s/[a-zA-Z_][a-zA-Z0-9_]*/v/g changes
# all variable names to "v"
# which means changes to variable names won't affect comparison.
# Note it also may change function names, keywords etc.
# This is fine for our purposes.

# The use of sort means line reordering won't affect comparisons

TMP_FILE1=/tmp/plagiarism_tmp1$$
TMP_FILE2=/tmp/plagiarism_tmp2$$
substitutions='s/\/\/.*//;s/"[^"]"/s/g;s/[a-zA-Z_][a-zA-Z0-9_]*/v/g'

for file1 in "$@"
do
    for file2 in "$@"
    do
        test "$file1" = "$file2" && continue # don't compare a file to itself
        sed "$substitutions" "$file1" >$TMP_FILE1
        sed "$substitutions" "$file2" >$TMP_FILE2
        if diff -i -w $TMP_FILE1 $TMP_FILE2 >/dev/null
        then
            echo "$file1 is a copy of $file2"
        fi
    done
done
rm -f $TMP_FILE1 $TMP_FILE2
