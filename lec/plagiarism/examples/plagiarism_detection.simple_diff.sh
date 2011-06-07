#!/bin/sh
# written by andrewt@cse.unsw.edu.au as a COMP2041 example
# Report of any the assignment submissions
# given as arguments are copies of each other,e.g.:
# plagiarism_detection assignments/*
# The use of diff -iw means changes in white-space and case
# won't affect comparisons

for file1 in "$@"
do
    for file2 in "$@"
    do
        test "$file1" = "$file2" && continue
        if diff -i -w "$file1" "$file2" >/dev/null
        then
            echo "$file1 is a copy of $file2"
        fi
    done
done
