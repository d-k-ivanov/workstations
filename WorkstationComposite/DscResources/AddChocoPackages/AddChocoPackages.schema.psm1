Configuration AddChocoPackages 
{
    Param
    (
        [Parameter(Mandatory)]
        [string[]] $Packages
    )

    Import-DscResource -ModuleName cChoco

    cChocoinstaller InstallChocolatey {
        InstallDir = "C:\ProgramData\chocolatey"
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name                    = 'PackageName'
    #     Version                 = ''
    #     Params                  = ''
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present'
    #     DependsOn               = "[cChocoInstaller]InstallChocolatey"
    # }

    foreach ($p in $Packages) {        
        cChocoPackageInstaller $p
        {
            Name                    = "$p"
            DependsOn               = "[cChocoInstaller]InstallChocolatey"
        }
    }
}





