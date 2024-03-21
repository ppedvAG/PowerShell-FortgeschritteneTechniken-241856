function New-TestFiles
{
[cmdletBinding()]
param(
[ValidateScript({Test-Path -Path $PSItem -Pathtype Container})]
[string]$Path,

[ValidateRange(0,99)]
[int]$FileCount = 9,

[Validatelength(3,20)]
[string]$FileBaseName = "File"

)

for($i = 1; $i -le $FileCount; $i++)
{
    $Filenumber = "{0:D2}" -f $i
    $Name = "File" + $Filenumber + ".txt"

    New-Item -Path $Path -Name $Name -ItemType File
}

}


function New-TestFilesDir
{
[cmdletBinding()]
param(
[ValidateScript({Test-Path -Path $PSItem -Pathtype Container})]
[string]$Path,

[ValidateRange(0,99)]
[int]$DirCount = 3,

[ValidateRange(0,99)]
[int]$FileCount = 9,

[Validatelength(3,20)]
[string]$DirName = "TestFiles2",

[switch]$Force 
)


$TestFilesDirPath = Join-Path -Path $Path -ChildPath $DirName
if(Test-Path -Path $TestFilesDirPath -PathType Container)
{
    if($Force)
    {
        Remove-Item -Path $TestFilesDirPath -Recurse -Force
    }
    else
    {
        throw (Get-Item -Path $TestFilesDirPath)
    }
}

$TestDir = New-Item -Path $Path -Name $DirName -ItemType Directory

New-TestFiles -Path $TestDir.FullName -FileCount $FileCount

for($i = 1; $i -le $DirCount; $i++)
{
    $Dirnumber = "{0:D2}" -f $i
    $DirName = "Dir" + $Dirnumber

    $subdir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory


    New-TestFiles -Path $subdir.FullName -FileCount $FileCount -FileBaseName ($DirName+"File")
}
}