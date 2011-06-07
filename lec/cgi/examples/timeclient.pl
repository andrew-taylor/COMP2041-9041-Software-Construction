#!/usr/bin/perl -w

use IO::Socket;
$c = IO::Socket::INET->new(PeerAddr => $ARGV[0] || 'localhost', PeerPort  => 4242) or die;
print <$c>;
close $c;
