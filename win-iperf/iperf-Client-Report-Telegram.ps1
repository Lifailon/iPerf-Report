$srv = "server-name"
$trigger = "150"
$token_bot = "5517149522:AAFop4_darMpTT7VgLpY2hjkDkkV1dzmGNM"
$id_chat = "-609779646"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function telegram {
$payload = @{
"chat_id" = $id_chat
"text" = $out
"parse_mode" = "html"
}
Invoke-RestMethod -Uri ("https://api.telegram.org/bot{0}/sendMessage" -f $token_bot) -Method Post -ContentType "application/json;charset=utf-8" -Body (ConvertTo-Json -Compress -InputObject $payload)
}

$iperf = ".\iperf\iperf3.exe"
$test_up = .$iperf -c $srv -p 5221 -n 1100MB
$test_down = .$iperf -c $srv -p 5221 -n 1100MB -R

$upload = $test_up[-3]
$download = $test_down[-3]
$upload = $upload -replace ".+(?<=GBytes)"
$upload = $upload -replace "receiver"
$upload = $upload -replace "\s{2,10}"
$download = $download -replace ".+(?<=GBytes)"
$download = $download -replace "receiver"
$download = $download -replace "\s{2,10}"

$char_upload = $upload.ToCharArray()
foreach ($ch in $char_upload) {
if ($ch -match "\d") {
[string]$int_upload += $ch
}
}

$char_download = $download.ToCharArray()
foreach ($ch in $char_download) {
if ($ch -match "\d") {
[string]$int_download += $ch
}
}

if ($int_upload -lt $trigger) {
$out = "Low upload: <b>$upload</b>"
telegram
}

if ($int_download -lt $trigger) {
$out = "Low download: <b>$download</b>"
telegram
}

$date = Get-Date
"$date  Upload: $upload  Download: $download" >> iperf-log.txt