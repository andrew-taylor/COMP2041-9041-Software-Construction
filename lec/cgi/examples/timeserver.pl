#!/usr/bin/perl -w
# simple Perl server accessed by TCP

# from http://www.perl.com/lpt/a/674, modified by andrewt@cse.unsw.edu.au
# access by telnet localhost 4242

use IO::Socket;
$server = IO::Socket::INET->new(LocalPort => 4242, Listen => SOMAXCONN) or die;
 
while ($c = $server->accept()) {
	printf STDERR "[Connection from %s]\n", $c->peerhost;
	print $c scalar localtime,"\n";
	close $c;
}
