#!/usr/bin/perl -w
# Simple CGI script written by andrewt@cse.unsw.edu.au
# retrieves value stored for x in cookie if there is one
# increment and set the cookie to this value

use CGI qw/:all/;
use CGI::Cookie;
 
%cookies = fetch CGI::Cookie;
$x = 0;
$x = $cookies{'x'}->value if $cookies{'x'};
$x++;
print header(-cookie=>"x=$x"), start_html('Cookie Example'), "x=$x", end_html;

