$iperf = ".\iperf\iperf3.exe"
$proc_iperf = Get-Process | where Name -match iperf
if ($proc_iperf -eq $null) {
.$iperf -s -D -p 5221
}