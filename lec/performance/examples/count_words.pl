#! /usr/bin/perl -w
#!/usr/bin/perl -w

while ($line = <>) {
	$line =~ tr/A-Z/a-z/;
	foreach $word ($line =~ /[a-z]+/g) {
		$count{$word}++;
	}
}
@words = keys %count;
@sorted_words = sort {$count{$a} <=> $count{$b}} @words;
foreach $word (@sorted_words) {
	printf "%8d %s\n", $count{$word}, $word;
}
