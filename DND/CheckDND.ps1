$s = cat website.txt | measure-object
Out-File results.txt
for (($c = 0); $c -lt $s.Count; $c++) {
	$website = cat website.txt | select -First $c | select -Last 1
	$file = $website.replace("https://raw.githubusercontent.com/5etools-mirror-1/5etools-mirror-1.github.io/master/data/spells/spells-", '')
	echo $file
	echo $file | Out-File results.txt -append
	$content = (curl $website -UseBasicParsing).Content.Split([Environment]::NewLine).replace('	', "!").replace("!!!", "@").replace('@@"name"', "skip")| select-string '@"name":' | Out-String
	$content = $content.replace('@"name": ', "").replace('"', "").replace(",", "").trim().split([Environment]::NewLine)
	for (($gcc = 0); $gcc -lt $content.length; $gcc++) {
		if ($content[$gcc].length -gt 0) {
			if ($content[$gcc].length -gt 19) {
				echo "$($content[$gcc]), length: $($content[$gcc].length)"
				echo "$($content[$gcc]) $($content[$gcc].length)"| Out-File results.txt -append
			}
		}
	}
	echo " "
	echo " " | Out-File results.txt -append
}
