#!/bin/sh

# written by andrewt@cse.unsw.edu.au as a COMP2041 example
# Report of any the assignment submissions
# given as arguments are copies of each other,e.g.:
# plagiarism_detection assignments/*

# The substitution s/\/\/.*//  removes // style C comments
# which means changes in such comments won't affect comparisons
# The substitution s/"["]*"/s/g changes strings to the letter s
# which means changes to strings won't affect comparison.
# This pattern won't match a few C strings which is fine for our purposes
# The  s/[a-zA-Z_][a-zA-Z0-9_]*/x/g changes
# all variable names to "v"
# which means changes to variable names won't affect comparison.
# Note it also may change function names, keywords etc.
# This is fine for our purposes.

# The use of sort means line reordering won't affect comparisons

# Use md5sum to calculate a Cryptographic hash of the modified file
#  http://en.wikipedia.org/wiki/MD5
# and then use sort && uniq to find files with the same hash

substitutions='s/\/\/.*//;s/"[^"]"/s/g;s/[a-zA-Z_][a-zA-Z0-9_]*/v/g'

for file in "$@"
do
	echo `sed "$substitutions" "$file"|sort|md5sum` $file
done|
sort|
uniq -w32 -d --all-repeated=separate|
cut -c36-
