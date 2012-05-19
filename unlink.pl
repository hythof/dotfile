#!perl

my $home = $ENV{'HOME'};
foreach(glob('.*')) {
	next if $_ eq ".";
	next if $_ eq "..";
	my $cmd = "rm -i $home/$_";
    system($cmd);
}

