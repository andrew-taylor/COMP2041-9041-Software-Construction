#!/usr/bin/perl -w

# return files in response to incoming http requests to port 4280
# also handle GET & POST requests for files in cgi-bin
# assumes application/x-www-form-urlencoded data so CGI.pm won't work
# andrewt@cse.unsw.edu.au
# access by http://localhost:4280/

# See http://search.cpan.org/dist/HTTP-Server-Simple/ for a much
# more genral solution

use IO::Socket;
$server = IO::Socket::INET->new(LocalPort => 4280, ReuseAddr => 1, Listen => SOMAXCONN) or die;
while ($c = $server->accept()) {
    my $request = <$c>;
    if ($request =~ /^GET (.+) HTTP\/1.[01]\s*$/) {
    	my $method = $1;
    	my $url = $2;
   		$url =~ s/(^|\/)..(\/|$)//g;
   		if ($url =~ /^(\/*cgi-bin\/\w+\.cgi)(\?(.*))?/) {
   			my $cgi_script = "/home/cs2041/public_html/$1";
    		my $parameters = $3 || '';
   			print $c "HTTP/1.0 200 OK\n";
      	 	print $c `echo '$parameters'|$cgi_script`;
        	close F;
        } else {
 			my $file = "/home/cs2041/public_html/$url";
   			$file .= "/index.html" if -d $file;
  			if (!-e $file) {
 				print $c "HTTP/1.0 404 FILE NOT FOUND\nContent-Type: text/plain\n\nFile $file not found\n";
    		} else {
   				print $c "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
        		open(F, '<', $file) or die;
        		print $c <F>;
        		close F;
        	}
        }
    } else {
        print $c "HTTP/1.0 400 BAD REQUEST\nContent-Type: text/plain\n\nBAD REQUEST\n";
    }
    close $c;
}
