$name = "Shorten URL";
$priority = 2000 / length; # neat dynamic priority thing
$result = /https?:\/\//;

$fun = sub {
	my $url;

	if (length $text < 4096) {
		$url = `curl -F\"shorten=\$(cat $text_file)\" http://0x0.st`;
	} else {
		my $content = <<"EOF";
<!DOCTYPE html><meta http-equiv="refresh" content="0;url=$text"/><a href="$text">$text</a>
EOF
		# 0x0.st's upload lifetime is based on file size, so minified HTML gets us a few extra days.
		my ($upload_fh, $upload_path) = tempfile();
		print $upload_fh $content;
		$url = `curl -F'file=\@$upload_path' http://0x0.st`;
	}

	chomp $url;
	`notify-send 'Shortened to $url. Copied to clipboard.'`;
	`echo '$url' | xsel --clipboard --input`;
}
