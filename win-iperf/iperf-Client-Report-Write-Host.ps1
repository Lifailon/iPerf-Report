$srv = "server-name" # iperf-server
$trigger = "155" # Mbits/sec

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
Write-Host "Low upload: $upload"
} else {Write-Host "Ok upload: $upload"}

if ($int_download -lt $trigger) {
Write-Host "Low download: $download"
} else {Write-Host "Ok download: $download"}

pause