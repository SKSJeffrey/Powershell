$Service=Get-Service -name bits
$Service | GM
$Service.status
