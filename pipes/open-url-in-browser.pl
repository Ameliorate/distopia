$name = "Open in browser";
$priority = 10;
$result = /^https?:\/\//;

$fun = sub {
	`xdg-open \$(cat $text_file)`;
}
