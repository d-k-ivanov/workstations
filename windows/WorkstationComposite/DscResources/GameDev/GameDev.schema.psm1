<#
.SYNOPSIS
Install various game development tools.

.DESCRIPTION
Install various game development tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration GameDev
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [switch] $AutoUpdate
    )

    Import-DscResource -ModuleName cChoco

    cChocoinstaller InstallChocolatey
    {
        InstallDir = "C:\ProgramData\chocolatey"
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name        = 'PackageName'
    #     Version     = ''
    #     Params      = ''
    #     AutoUpgrade = $AutoUpdate
    #     Ensure      = 'Present | Absent'
    #     DependsOn   = "[cChocoInstaller]InstallChocolatey"
    # }

    cChocoPackageInstaller InstallGodotMono
    {
        Name                 = 'godot-mono'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallUnity
    # {
    #     Name                 = 'unity'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Absent'
    #     DependsOn            = "[cChocoInstaller]InstallChocolatey"
    #     PsDscRunAsCredential = $Credential
    # }
}
