#!/usr/bin/perl -w
# fetch files via http from the webserver at the specified URL
# with a simple cookie implementation (no expiry)
# see HTTP::Request::Common for a more general solution
# written by andrewt@cse.unsw.edu.au as a COMP2041 example
use Storable;
$cookies_db = "./.cookies";
%cookies = %{retrieve($cookies_db)} if -r $cookies_db;
use IO::Socket;
foreach (@ARGV) {
    my ($host, $junk, $port, $path) = /http:\/\/([^\/]+)(:(\d+))?(.*)/ or die;
    $c = IO::Socket::INET->new(PeerAddr => $host, PeerPort  => $port || 80) or die;
    print $c "GET $path HTTP/1.0\n";
    foreach $domain (keys %cookies) {
    	next if $host !~ /$domain$/;
    	foreach $cookie_path (keys %{$cookies{$domain}}) {
	    	next if $path !~ /^$cookie_path/;
 		   	foreach $name (keys %{$cookies{$domain}{$path}}) {
	  	  		print $c "Cookie: $name=$cookies{$domain}{$path}{$name}\n";
 			   	print "Sent cookie $name=$cookies{$domain}{$path}{$name}\n";
	  	  	}
    	}
    }
    print $c "\n";
    while (<$c>) {
    	last if /^\s*$/;
    	next if !/^Set-Cookie:/i;
    	my ($name,$value, %v) = /([^=;\s]+)=([^=;\s]+)/g;
    	my $domain = $v{'domain'} || $host;
     	my $path = $v{'path'} || $path;
    	$cookies{$domain}{$path}{$name} = $value;
    	print "Received cookie $domain $path $name=$value\n";
    }
    my @webpage = <$c>;
    print STDOUT @webpage;
}
store(\%cookies, $cookies_db);
