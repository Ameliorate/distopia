$name = "Copy to primary selection";
$priority = 1000;
$result = $source ne "primary";

$fun = sub {
	`cat $text_file | xsel --primary --input`
};

