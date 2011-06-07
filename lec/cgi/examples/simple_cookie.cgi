#!/usr/bin/perl -w
# Simple CGI script written by andrewt@cse.unsw.edu.au
# retrieved value stored for x in cookie if there is one
# increment and set the cookie to this value
 
$x = 0;
$x = $1 + 1 if defined $ENV{HTTP_COOKIE} && $ENV{HTTP_COOKIE} =~ /\bx=(\d+)/;
print "Content-type: text/html
Set-Cookie: x=$x;

<html><head></head><body>
x=$x
</body></html>";
