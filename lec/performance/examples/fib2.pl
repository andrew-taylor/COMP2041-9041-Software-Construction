#!/usr/bin/perl -w
use Memoize;
sub fib($);
memoize('fib');
printf "fib(%d) = %d\n", $_, fib($_) foreach @ARGV;
sub fib($) {
	my ($n) = @_;
	return 1 if $n < 3;
	return fib($n-1) + fib($n-2);
}
