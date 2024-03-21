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

function Out-ColoredNames
{
[cmdletBinding(PositionalBinding=$false)]
param(
[Parameter(Mandatory = $true,
           ValueFromPipeline = $true,
           ValueFromPipelineByPropertyName=$true
           )]
[string]$Name
)
Begin
{
    Write-Verbose "Der Beginn wird einmal zum Start ausgeführt. Zb. zum importieren von Modulen"
}
Process
{
    #Wird für jedes übergebene Objekt ausgeführt
    for($i = 0; $i -lt $Name.Length; $i++)
    {
        Write-Host -Object $Name[$i] -ForegroundColor (Get-Random -Maximum 15) -BackgroundColor (Get-Random -Maximum 15) -NoNewline
    }
    Write-Host
}
End
{
    Write-Verbose "Der End wird einmal zum Ende ausgeführt. Zb.zum beenden bzw schließen von Remote Verbindungen"
}



}

function Test-ParameterSet
{
[cmdletBinding(DefaultParameterSetName="Process")]
param(
[Parameter(ParameterSetName="Process",ValueFromPipeLineByPropertyName=$true,Mandatory=$true)]
[string]$ProcessName,

[Parameter(ParameterSetName="Service",ValueFromPipeLineByPropertyName=$true,Mandatory=$true)]
[string]$ServiceName,

[Parameter(ParameterSetName="Process",Mandatory=$true)]
[Parameter(ParameterSetName="Service",Mandatory=$false)]
[ValidateRange(0,15)]
[int]$Color = 13
)

Process
{
    switch($PSCmdlet.ParameterSetName)
    {
        "Process" {Write-Host -Object $ProcessName -ForegroundColor $color}
        "Service" {Write-Host -Object $ServiceName -ForegroundColor $color}
    }
}

}

function Test-Debug
{
[cmdletBinding()]
param(
[Parameter(MAndatory=$true)]
[ValidateRange(1,15)]
[int]$Anzahl,

[string]$Wort = "Äpfel"
)

Write-Debug -Message "Vor der zählenden Schleife"
for($i = 1; $i -le $Anzahl; $i++)
{    
    Write-Host -Object ("" + $i + " " + $Wort)
}


}

