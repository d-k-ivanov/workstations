<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.

.PARAMETER Credential
User credental.

.PARAMETER NoUpgrate
Do not upgrade installed packages to their latest versions.
#>

Configuration DevTools
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

    Import-DscResource -ModuleName cChoco

    cChocoinstaller InstallChocolatey {
        InstallDir              = "C:\ProgramData\chocolatey"
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name                    = 'PackageName'
    #     Version                 = ''
    #     Params                  = ''
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present | Absent'
    #     DependsOn               = "[cChocoInstaller]InstallChocolatey"
    # }

    cChocoPackageInstaller InstallBuckaroo
    {
        Name                    = 'buckaroo'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCmake
    {
        Name                    = 'cmake'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDependencyWalker
    {
        Name                    = 'dependencywalker'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDrMemory
    {
        Name                    = 'drmemory'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGit
    {
        Name                    = 'git'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGitExtensions
    {
        Name                    = 'gitextensions'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGradle
    {
        Name                    = 'gradle'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMercurial
    {
        Name                    = 'hg'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallHXD
    {
        Name                    = 'hxd'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallJDK8
    {
        Name                    = 'jdk8'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallJetBrainsToolbox
    {
        Name                    = 'jetbrainstoolbox'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallJQ
    {
        Name                    = 'jq'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKDiff3
    {
        Name                    = 'kdiff3'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallLLVM
    {
        Name                    = 'llvm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMake
    {
        Name                    = 'make'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMaven
    {
        Name                    = 'maven'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMeld
    {
        Name                    = 'meld'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMiniconda3
    {
        Name                    = 'miniconda3'
        Params                  = '/InstallationType:AllUsers /AddToPath:0 /RegisterPython:0'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNinja
    {
        Name                    = 'ninja'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNotepadPlusPlus
    {
        Name                    = 'notepadplusplus.install'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNPPPluginmanager
    {
        Name                    = 'notepadplusplus-npppluginmanager'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNugetCommandline
    {
        Name                    = 'nuget.commandline'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNugetPackageExplorer
    {
        Name                    = 'nugetpackageexplorer'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOctopusTools
    {
        Name                    = 'octopustools'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOllyDebugger
    {
        Name                    = 'ollydbg'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }


    cChocoPackageInstaller InstallOpenJDK #14
    {
        Name                    = 'openjdk'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallPacketPowershell
    {
        Name                    = 'paket.powershell'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallResourceHacker
    {
        Name                    = 'reshack'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSVN
    {
        Name                    = 'svn'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVim
    {
        Name                    = 'vim'
        Params                  = '/RestartExplorer /NoDesktopShortcuts /NoDefaultVimrc'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVSCode
    {
        Name                    = 'vscode'
        Params                  = '/NoDesktopIcon'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWinMerge
    {
        Name                    = 'winmerge'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWixToolset
    {
        Name                    = 'wixtoolset'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallXDebugger
    {
        Name                    = 'x64dbg.portable'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallYarn
    {
        Name                    = 'yarn'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }
}
