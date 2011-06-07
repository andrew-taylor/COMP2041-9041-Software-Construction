#!/usr/bin/perl -w
# simple Perl implementation of "make"
# written by andrewt@cse.unsw.edu.au for COMP2041

sub build($);
sub parse_makefile($);

$makefile_name = "Makefile";
if (@ARGV >= 2 && $ARGV[0] eq "-f") {
    shift @ARGV;
    $makefile_name = shift @ARGV;
}

parse_makefile $makefile_name;
push @ARGV, $first_target if !@ARGV;
build $_ foreach @ARGV;
exit 0;

sub parse_makefile($) {
    my ($file) = @_;
    open MAKEFILE, $file or die;
    while (<MAKEFILE>) {
        s/#.*//;
        s/\$\((\w+)\)/$variable{$1}||''/eg;
        if (/^\s*(\w+)\s*=\s*(.*)$/) {
            $variable{$1} = $2;
            next;
        }
        my ($target, $dependencies) = /(\S+)\s*:\s*(.*)/ or next;
        $first_target ||= $target;
        $dependencies{$target} = $dependencies;
        while (<MAKEFILE>) {
            s/#.*//;
            s/\$\((\w+)\)/$variable{$1}||''/eg;
            last if !/^\t/;
            $build_command{$target} .= $_;
        }
    }
}

sub build($) {
    my ($target) = @_;
    my $build_command = $build_command{$target};
    die "*** No rule to make target $target\n" if !$build_command && !-e $target;
    return if !$build_command;
    my $target_build_needed = ! -e $target;
    foreach $dependency (split /\s+/, $dependencies{$target}) {
        build($dependency);
        $target_build_needed ||= -M  $target > -M $dependency;
    }
    return if !$target_build_needed;
    print $build_command;
    system $build_command;
}
