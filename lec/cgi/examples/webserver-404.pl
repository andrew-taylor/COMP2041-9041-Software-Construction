#!/usr/bin/perl -w

# print incoming http requests to port 2041
# andrewt@cse.unsw.edu.au
# access by http://localhost:2041/

use IO::Socket;
$server = IO::Socket::INET->new(LocalPort => 2041, ReuseAddr => 1, Listen => SOMAXCONN) or die;
 
while ($c = $server->accept()) {
    printf "Connection from %s\n", $c->peerhost;
    while (<$c>) {
        print;
        last if /^\s*$/;
    }
    close $c;
}
