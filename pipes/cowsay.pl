$name = "Cowsay";
$priority = 800;
$result = 1;

$fun = sub {
	`cat $text_file | cowsay | xsel --input --clipboard`;
	`notify-send "Copied cowsay to clipboard"`;
}
