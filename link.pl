#!perl

my $home = $ENV{'HOME'};
chdir $home;
print "chdir $home\n";
my @dotfiles = grep { !m!/\.+$! } glob('dotfile/.*');
foreach(@dotfiles) {
	my $cmd = "ln -vs $_ .";
	print $cmd, "\n";
	system($cmd);
}

