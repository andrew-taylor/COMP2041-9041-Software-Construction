#!/usr/bin/perl -w
# fetch files via http from the webserver at the specified URL
# see HTTP::Request::Common for a more general solution
# written by andrewt@cse.unsw.edu.au as a COMP2041 lecturer example

use IO::Socket;
foreach (@ARGV) {
    my ($host, $junk, $port, $path) = /http:\/\/([^\/]+)(:(\d+))?(.*)/ or die;
    $c = IO::Socket::INET->new(PeerAddr => $host, PeerPort  => $port || 80) or die;
    print $c "GET $path HTTP/1.0\n\n"; # send request for web page to server
    my @webpage = <$c>; # read what the server returns
    print STDOUT @webpage;
}
