#!/bin/sh
tr -c a-zA-Z ' '|
tr ' ' '\n'|
tr A-Z a-z|
grep -v '^$'|
sort|
uniq -c

