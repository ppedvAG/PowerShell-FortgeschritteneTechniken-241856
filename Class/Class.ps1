class Vehicle
{
    [string]$Farbe
    [string]$Hersteller
    [int]$istzplätze
    [string]$Model
    [Antriebsart]$Antrieb

}

class Auto : Vehicle
{
    [int]$Räder
    [int]$Höchstgeschwindigkeit
    [int]$Power
    
    #Konstruktoren werden verwendet zur Erstellung einer neuen Instanz
    #Diese Konstruktoren können für verschiedene Szenarien paralell erstellt werden
    Auto()
    {# Konstruktor wird verwendet wenn eine neue Instanz ohne ÜbergabeWerte angelegt wird
    }

    Auto([string]$Hersteller)
    {#Konstruktor wird verwendet wenn der neuen Instanz ein Herstellerwert übergeben wird
    $this.Hersteller = $Hersteller
    }

    #Methoden sind die "Funktionen" innerhalb der Klassen die wir definieren oder überschreiben/überladen
    #Methoden haben immer vor dem Methodennamen den Datentyp den Sie ausgeben
    [void]Lock()
    {
        Write-Host -Object "Tüüt Tüüt"
    }

    [void]Fahre([int]$Strecke)
    {
        [int]$speed = 0
        [string]$Fahrbahn = "🚗"

        for($i = 1; $i -le $Strecke; $i ++)
        {
            $Fahrbahn = "-" + $Fahrbahn
            if($speed -le $this.Höchstgeschwindigkeit)
            {
                $speed += 15
            }

            Start-Sleep -Milliseconds (300 - $speed)
            Clear-Host
            Write-Host -Object $Fahrbahn
        }
    }


    #StandardMethode ToSTring wird überladen mit eigener Logik
    [string]ToString()
    {
        [string]$Ausgabe = ""
        $Ausgabe = $this.Hersteller + " " + $this.Model

        return $Ausgabe
    }
    [string]ToString([String]$InformationLevel)
    {
        [string]$Ausgabe = ""
        switch($InformationLevel)
        {
            Detailed {$Ausgabe = "[" + $this.Hersteller + " | " + $this.Model + " | " + $this.Räder + " ]"}
            Default {$Ausgabe = $this.ToString()}
        }
        return $Ausgabe
    }
}

enum Antriebsart
{
    Sonstiges
    BenzinVerbrenner
    DieselVerbrenner
    Elektrisch
    Hybrid
    Wasserstoff
}
<# Konstruktor ohne Übergabewerte
$MyCar = [Auto]::new()
$MyCar.Hersteller = "BMW"
#>
#Konstruktor mit Herstellerübergabe
$MyCar = [Auto]::new("BMW")

$MyCar.Antrieb = [Antriebsart]::BenzinVerbrenner
$MyCar.Model = "F31"
$MyCar.Höchstgeschwindigkeit = 260
$MyCar.Farbe = "GrauMetallic"
$MyCar.Power = 252
$MyCar.istzplätze = 5
$MyCar.Räder = 4