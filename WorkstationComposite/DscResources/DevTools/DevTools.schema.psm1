<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.
#>

Configuration DevTools
{
    Param
    (
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
    }

    cChocoPackageInstaller InstallCmake
    {
        Name                    = 'cmake'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallDependencyWalker
    {
        Name                    = 'dependencywalker'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallDrMemory
    {
        Name                    = 'drmemory'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallGit
    {
        Name                    = 'git'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallGitExtensions
    {
        Name                    = 'gitextensions'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallGradle
    {
        Name                    = 'gradle'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallMercurial
    {
        Name                    = 'hg'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallHXD
    {
        Name                    = 'hxd'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallJDK8
    {
        Name                    = 'jdk8'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallOpenJDK #14
    {
        Name                    = 'openjdk'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallJQ
    {
        Name                    = 'jq'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallKDiff3
    {
        Name                    = 'kdiff3'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallLLVM
    {
        Name                    = 'llvm'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallMake
    {
        Name                    = 'make'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallMaven
    {
        Name                    = 'maven'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallMeld
    {
        Name                    = 'meld'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallMiniconda3
    {
        Name                    = 'miniconda3'
        Params                  = '/InstallationType:AllUsers /AddToPath:0 /RegisterPython:0'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallNinja
    {
        Name                    = 'ninja'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallNotepadPlusPlus
    {
        Name                    = 'notepadplusplus.install'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallNPPPluginmanager
    {
        Name                    = 'notepadplusplus-npppluginmanager'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallNugetCommandline
    {
        Name                    = 'nuget.commandline'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallNugetPackageExplorer
    {
        Name                    = 'nugetpackageexplorer'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallOctopusTools
    {
        Name                    = 'octopustools'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallOllyDebugger
    {
        Name                    = 'ollydbg'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallPacketPowershell
    {
        Name                    = 'paket.powershell'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallResourceHacker
    {
        Name                    = 'reshack'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallSVN
    {
        Name                    = 'svn'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallVim
    {
        Name                    = 'vim'
        Params                  = '/RestartExplorer /NoDesktopShortcuts /NoDefaultVimrc'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallVSCode
    {
        Name                    = 'vscode'
        Params                  = '/NoDesktopIcon'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallWinMerge
    {
        Name                    = 'winmerge'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallWixToolset
    {
        Name                    = 'wixtoolset'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallXDebugger
    {
        Name                    = 'x64dbg.portable'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

    cChocoPackageInstaller InstallYarn
    {
        Name                    = 'yarn'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
    }

}





