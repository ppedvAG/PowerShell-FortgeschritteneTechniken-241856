<#
.SYNOPSIS
 Skript Kurzbeschreibung: Abfrage von Events
.DESCRIPTION
 Eine lange Beschreibung: Dieses Skript dient der Abfrage von Anmeldebezogenen Events
.PARAMETER EventId
 4624 Anmeldung
 4625 fehlgeschlagene Anmeldung
 4634 Abmeldung
.EXAMPLE
 Beispiel 1
.EXAMPLE
Skript Ausführung mit Angabe des PFlicht Parameters und dem optionalen Parameter Verbose für die zusätzliche Ausgabe.
 .\Skriptbeispiel\Get-LogonEvents.ps1 -EventId 4624 -Verbose
AUSFÜHRLICH: Zusätzliche Info

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  703346 Mrz 20 11:49  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  703343 Mrz 20 11:49  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  703340 Mrz 20 11:49  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  703337 Mrz 20 11:48  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  703332 Mrz 20 11:48  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1#syntax-for-comment-based-help-in-scripts
#>
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5 ,

[string]$Computername = "localhost"
)

Write-Verbose -Message "Zusätzliche Info"

Get-EventLog -LogName Security -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest

