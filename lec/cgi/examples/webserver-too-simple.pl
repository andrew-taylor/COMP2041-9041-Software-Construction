#!/usr/bin/perl -w

# return files in response to incoming http requests to port 2041
# note does not check the request is well-formed or that the file exists
# also very insecure as pathname may contain ..  > < or |
# andrewt@cse.unsw.edu.au
# access by http://localhost:2041/

use IO::Socket;
$server = IO::Socket::INET->new(LocalPort => 2041, ReuseAddr => 1, Listen => SOMAXCONN) or die;
 
while ($c = $server->accept()) {
    my $request = <$c>;
    printf "Connection from %s, request: $request", $c->peerhost;
    print $c "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
    $request =~ /^GET (.+) HTTP\/1.[01]\s*$/;
    open F, "</home/cs2041/public_html/$1" and print $c <F>;
    close $c;
}
