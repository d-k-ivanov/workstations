Configuration AddChocoPackages 
{
    Param(
        [Parameter(Mandatory)]
        [string[]] $Packages
    )

    Import-DscResource -ModuleName cChoco

    cChocoinstaller installChocolatey {
        InstallDir = "C:\ProgramData\chocolatey"
    }

    foreach ($p in $Packages) {        
        cChocoPackageInstaller $p
        {
            Name="$p"
            DependsOn = "[cChocoInstaller]installChocolatey"
        }
    }
    

#    cChocoPackageInstaller googlechrome
#    {
#        Name="googlechrome"
#        DependsOn = "[cChocoInstaller]installChocolatey"
#    }
#
#    cChocoPackageInstaller notepadplusplus
#    {
#        Name="notepadplusplus.install"
#        DependsOn = "[cChocoInstaller]installChocolatey"
#    }
#
#    foreach ($p in $Packages) {        
#        $executionName = $p.Name -replace '\(|\)|\.| ', ''
#        $executionName = "Chocolatey_$executionName"
#        $p.ChocolateyOptions = [hashtable]$p.ChocolateyOptions
#        (Get-DscSplattedResource -ResourceName ChocolateyPackage -ExecutionName $executionName -Properties $p -NoInvoke).Invoke($p)
#    }
}





