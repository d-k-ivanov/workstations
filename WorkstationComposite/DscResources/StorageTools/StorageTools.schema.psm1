<#
.SYNOPSIS
Install storage tools.

.DESCRIPTION
Install storage tools.

.PARAMETER Credential
User credental.

.PARAMETER NoUpgrade
Do not upgrade installed packages to their latest versions.
#>

Configuration StorageTools
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [switch] $NoUpgrade
    )

    if ($NoUpgrade)
    {
        $AutoUpgrade = $false
    }
    else
    {
        $AutoUpgrade = $true
    }

    Import-DscResource -ModuleName cChoco

    cChocoinstaller InstallChocolatey
    {
        InstallDir              = 'C:\ProgramData\chocolatey'
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name                    = 'PackageName'
    #     Version                 = ''
    #     Params                  = ''
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present | Absent'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential    = $Credential
    # }

    cChocoPackageInstaller InstallDropBox
    {
        Name                    = 'dropbox'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

}

