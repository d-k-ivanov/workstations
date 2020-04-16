<#
.SYNOPSIS
Install Visual Stodio environment.

.DESCRIPTION
Install Visual Stodio environment.

.PARAMETER Credential
User credental.

.PARAMETER NoUpgrate
Do not upgrade installed packages to their latest versions.
#>

Configuration VisualStudio
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [switch] $NoUpgrate
    )

    if ($NoUpgrate)
    {
        $AutoUpgrade = $false
    }
    else
    {
        $AutoUpgrade = $true
    }

    Import-DscResource –ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName cChoco

    cChocoinstaller InstallChocolatey {
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

    cChocoPackageInstaller InstallVCRedist2008
    {
        Name                    = 'vcredist2008'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVCRedist2010
    {
        Name                    = 'vcredist2010'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVCRedist2012
    {
        Name                    = 'vcredist2012'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVCRedist2013
    {
        Name                    = 'vcredist2013'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVCRedist2015
    {
        Name                    = 'vcredist2015'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVCRedist2017
    {
        Name                    = 'vcredist2017'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDotNet461
    {
        Name                    = 'dotnet4.6.1'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVisualStudioCommunity2019
    {
        Name                    = 'visualstudio2019community'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential    = $Credential
    }

    Script DownloadWindows81Sdk
    {
        SetScript               = { Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/p/?LinkId=323507' -OutFile 'C:\Windows\Temp\sdksetup.exe' }
        GetScript               = { @{} }
        TestScript              = { Test-Path 'C:\Windows\Temp\sdksetup.exe' }
    }

    Script InstallWindows81Sdk
    {
        SetScript               = { cmd /c 'C:\Windows\Temp\sdksetup.exe /features + /q' }
        GetScript               = { @{} }
        TestScript              = { Test-Path "${Env:ProgramFiles(x86)}\Windows Kits\8.1" }
        DependsOn               = '[Script]DownloadWindows81Sdk'
    }

}





