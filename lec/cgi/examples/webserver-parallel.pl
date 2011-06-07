#!/usr/bin/perl -w
# return files in response to incoming http requests to port 2041
# andrewt@cse.unsw.edu.au
# access by http://localhost:2041/
# this version handles incoming request in a child process

use IO::Socket;
$server = IO::Socket::INET->new(LocalPort => 2041, ReuseAddr => 1, Listen => SOMAXCONN) or die;
 
while ($c = $server->accept()) {
    if (fork() != 0) {
    	# parent process goes to waiting for next request
    	close($c);
    	next;
    }
	# child process processes request
    my $request = <$c>;
    printf "Connection from %s, request: $request", $c->peerhost;
    if (my ($url) = $request =~ /^GET (.+) HTTP\/1.[01]\s*$/) {
        $url =~ s/(^|\/)..(\/|$)//g;
        my $file = "/home/cs2041/public_html/$url";
        # remove any occurences of .. from pathname to prevent access outside 2041 directory
        $file =~ s/(^|\/)..(\/|$)//g;
        $file .= "/index.html" if -d $file;
        if (open my $f, '<', $file) {
            print $c "HTTP/1.0 200 OK\nContent-Type: text/html\n\n", <$f>;
        } else {
            print $c "HTTP/1.0 404 FILE NOT FOUND\nContent-Type: text/plain\n\nFile $file not found\n";
        }
    } else {
        print $c "HTTP/1.0 400 BAD REQUEST\nContent-Type: text/plain\n\nBAD REQUEST\n";
    }
    close $c;
}
