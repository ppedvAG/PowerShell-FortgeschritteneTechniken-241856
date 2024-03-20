param(
$EventId,
$Newest = 5 ,
$Computername = "localhost"
)
Get-EventLog -LogName Security -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest

