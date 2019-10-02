#!/usr/bin/env perl
use strict;
use warnings;
use v5.28.1;

use IPC::Open2;
use File::Slurp;
use File::Temp qw/ tempfile /;

our $source = $ARGV[0] // "clipboard";
our $text = `xsel --output --$source`;
$text = '' if !$text; #fixes some bugs where text is undef and stuff
chomp $text;
my ($text_file_fh, $text_file) = tempfile();
print $text_file_fh $text;

my $short_text = $text;
if (length $text > 80) {
	$short_text = substr $text, 0, 76;
	$short_text = "$short_text...";
}
my ($short_text_file_fh, $short_text_file) = tempfile();
print $short_text_file_fh $short_text;

my $distopia_pwd = $ENV{"DISTOPIA_PWD"} or die "Distopia must be ran with the provided shell script!";

my @pipes = glob "$distopia_pwd/pipes/*.pl";
push @pipes, glob "$distopia_pwd/pipes/*/*.pl";

my %applications;
my %priorities;

for my $pipe (@pipes) {
	our $result = 0; # 0 if this pipe doesn't apply to the text, 1 if it does
	our $fun; # the function ran if the user selects this pipe
	our $name; # the name displayed to the user
	our $priority; # how "relevant" this pipe tends to be. how high up the pipe should be in the list
	$_ = $text;
	eval read_file($pipe);

	if ($result) {
		$applications{$name} = $fun;
		$priorities{$name} = $priority;
	}
}

my @names = sort { $priorities{$a} <=> $priorities{$b} } keys(%priorities);

my ($dmenureader, $dmenuwriter);
my $pid = open2($dmenureader, $dmenuwriter, "dmenu -l 20 -p \"\$(cat $short_text_file)\"");

for (@names) {
	say $dmenuwriter $_;
}

close($dmenuwriter) or die "couldn't close dmenu's stdin: $!";

my $execname = <$dmenureader>;

exit 0 if !$execname;
chomp $execname;

$_ = $text;
$applications{$execname}->();
