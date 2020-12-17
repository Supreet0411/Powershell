Clear-Host
$Dir = Get-Childitem C:\list -recurse
# $Dir | Get-Member
$List = $Dir | Where-Object {$_.extension -eq ".pdf"}
$List | Format-Table name
$List = $Dir | Where-Object {$_.extension -eq ".docx"}
$List | Format-Table name
$List = $Dir | Where-Object {$_.extension -eq ".txt"}
$List | Format-Table name
$List = $Dir | Where-Object {$_.extension -eq ".ps1"}
$List | Format-Table name