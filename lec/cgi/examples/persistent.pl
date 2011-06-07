#!/usr/bin/perl -w
use Storable;
$cache_file = "./.cache";
%h = %{retrieve($cache_file)} if -r $cache_file;
$h{COUNT}++;
print "This script has now been run $h{COUNT} times\n";
store(\%h, $cache_file);
