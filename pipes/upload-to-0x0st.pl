$name = "Upload to 0x0.st";
$priority = 20;
$result = -e $text; # $text is a file that exists

$fun = sub {
	my $url = `curl -F'file=\@$text' http://0x0.st`;
	chomp $url;
	`notify-send 'Uploaded to $url and copied to clipboard'`;
	`echo '$url' | xsel --clipboard --input`
}
