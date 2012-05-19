#!perl

my @dotfiles = grep { !/^\.+$/ } glob('.*');
my $home = $ENV{'HOME'};
chdir $home;
foreach(@dotfiles) {
	my $cmd = "ln -vs dotfiles/$_ .";
	print $cmd, "\n";
	system($cmd);
}

