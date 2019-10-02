$name = "Copy to clipboard";
$priority = 1000;
$result = $source ne "clipboard";

$fun = sub {
	`cat $text_file | xsel --clipboard --input`
}
