#!/usr/bin/perl -w
# Simple cp implementation reading entire file into array
# Written by andrewt@cse.unsw.edu.au for COMP2041

die "Usage: cp <infile> <outfile>\n" if @ARGV != 2;
$infile = shift @ARGV;
$outfile = shift @ARGV;
open IN, '<', $infile or die "Cannot open $infile: $!\n";
open OUT, '>', $outfile or die "Cannot open $outfile: $!\n";
print OUT <IN>;
