#!/usr/bin/perl -w

# Simple Version Control System
# written by andrewt@cse.unsw.edu.au
# as a COMP2041 lecture example

# Keeps file versions in a hash, stores hash in file .vcs
# Handles only ordinary files in the current directory.
# Does not preserve file permissions.
# No way to remove files/
# Inefficient - records complete copy of each changed file.

use Storable;
sub read_file($);
sub write_file($$);
$repository_file = "./.vcs";
%repository = %{retrieve($repository_file)} if -r $repository_file;
$action = shift @ARGV or die "Usage $0 (init|add|commit|log|status)";
if ($action eq 'init') {
    $repository{CURRENT_COMMIT} = 0;
    %{$repository{STAGING_AREA}} = ();
    print "Created empty repository\n";
} elsif ($action eq 'add') {
    # copy files to staging area
    foreach $file (@ARGV) {
        $repository{STAGING_AREA}{$file} = read_file($file);
    }
    print "Files staged are: ", join(" ", keys %{$repository{STAGING_AREA}}), "\n";
} elsif ($action eq 'commit') {
    my $commit = ++$repository{CURRENT_COMMIT};
    # commit staged  files to repository
    foreach $file (keys %{$repository{STAGING_AREA}}) {
	    $repository{LATEST}{$file} = $repository{$commit}{$file} = $repository{STAGING_AREA}{$file};
    }
    %{$repository{STAGING_AREA}} = ();
    $repository{LOG_MESSAGE}{$commit} = "@ARGV";
    print "Commited as commit #$commit: ", join(" ", keys %{$repository{$commit}}), "\n";
} elsif ($action eq 'checkout') {
    my $checkout_commit =  shift @ARGV || $repository{CURRENT_COMMIT};
    my %written;
    # go through commits in reverse order extracting last commit of each file
    foreach $file (reverse 1..$checkout_commit) {
        foreach $file (keys %{$repository{$commit}}) {
            next if $written{$file}++;
            print "Checking out from commit #$commit: $file\n";
            write_file($file, $repository{$commit}{$file});
        }
    }
} elsif ($action eq 'log') {
    foreach $commit (1..$repository{CURRENT_COMMIT}) {
        print "Commit #$commit\n";
        print "Log message: $repository{LOG_MESSAGE}{$commit}\n";
        print "Files: ", join(" ", keys %{$repository{$commit}}), "\n";
    }
} elsif ($action eq 'status') {
    my $commit = $repository{CURRENT_COMMIT}; 
    foreach $file (glob "*") {
        my $contents = read_file($file);
        if (defined $repository{STAGING_AREA}{$file}) {
            print "Modified: $file\n" if $contents ne  $repository{STAGING_AREA}{$file};
        } elsif (defined $repository{LATEST}{$file}) {
            print "Unstaged: $file\n" if $contents ne $repository{LATEST}{$file};
        } else {
            print "Untracked: $file\n";
        }
    }
}
store(\%repository, $repository_file);

sub read_file($) {
    my ($file) = @_;
    open(my $f, '<', $file) or die;
    return do {local $/; <$f>}
}

sub write_file($$) {
    my ($file, $contents) = @_;
    open my $f, '>', $file or die "Can not write '$file': $!";
    print $f $contents;
}
