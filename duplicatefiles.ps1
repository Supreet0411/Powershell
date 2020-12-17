# Script1: Find and eliminate duplicate files from a folder and move them to another folder

clear

#Enter folder path to search duplicate files
$filepath = Read-Host 'Enter file path for searching duplicate files :    '

# if-else statement to check that given folder path is present or not. 
If (Test-Path $filepath) {
''
Write-Warning 'Please wait ...'

#Searching for duplicate files based on hash value of a file 
$duplicates = Get-ChildItem $filepath -File -Recurse `
-ErrorAction SilentlyContinue |
Get-FileHash |
Group-Object -Property Hash |
Where-Object Count -GT 1
 
# If-else statement to check that the any file content is present more than 1 time or not
If ($duplicates.count -lt 1)
 
{
Write-Warning 'There is no duplicate file'
Break ''
}
 
else {
Write-Warning "yeh…. I found duplicate files…."
$result = foreach ($d in $duplicates)
{
$d.Group | Select-Object -Property Path, Hash
}
 
# move the duplicate files to a new folder name (duplicate + date)
$date = Get-Date -Format "MM/dd/yyy"

#make a grid table to show duplicate files together
$itemstomove = $result |
Out-GridView -Title `
"Select files (CTRL for multiple) and press OK. Selected files will be moved to C:\Duplicates_$date" `
-PassThru
 
If ($itemstomove)
 #set a location for new duplicate folder 
{
New-Item -ItemType Directory `
-Path $env:SystemDrive\Duplicates_$date -Force
Move-Item $itemstomove.Path `
-Destination $env:SystemDrive\Duplicates_$date -Force
''
Write-Warning `
"Successfully Selected files moved to C:\Duplicates_$date"
 
Start-Process "C:\Duplicates_$date"
}
 
else
{
Write-Warning "Operation aborted. No files selected."
}
}
}
else
{
Write-Warning `
"Folder not found. Use full path to directory....."
}
#end of the script 
