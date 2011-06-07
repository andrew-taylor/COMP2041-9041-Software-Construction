#!/usr/bin/perl -w
use IO::Socket;
foreach (@ARGV) {
	my ($host, $junk, $port, $path) = /http:\/\/([^\/]+)(:(\d+))(.*)/ or die;
	$c = IO::Socket::INET->new(PeerAddr => $host, PeerPort  => $port || 80) or die;
	sleep 3600;
	print $c "GET $path HTTP/1.0\n\n";
	print <$c>;
}
