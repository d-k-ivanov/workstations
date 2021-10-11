<#
.SYNOPSIS
Install various development tools.

.DESCRIPTION
Install various development tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration DevTools
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [switch] $AutoUpdate
    )

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
    #     AutoUpgrade             = $AutoUpdate
    #     Ensure                  = 'Present | Absent'
    #     DependsOn               = "[cChocoInstaller]InstallChocolatey"
    # }

    cChocoPackageInstaller InstallBuckaroo
    {
        Name                    = 'buckaroo'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCmake
    {
        Name                    = 'cmake'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCutter
    {
        Name                    = 'cutter'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallCppCheck
    {
        Name                    = 'cppcheck'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDeltaGitPager
    {
        Name                    = 'delta'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDependencies
    {
        Name                    = 'dependencies'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDependencyWalker
    {
        Name                    = 'dependencywalker'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallDrMemory
    {
        Name                    = 'drmemory'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    # https://dvc.org/
    cChocoPackageInstaller InstallDVC
    {
        Name                    = 'dvc'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallEmscripten
    {
        Name                    = 'emscripten'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGhidra
    {
        Name                    = 'ghidra'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGit
    {
        Name                    = 'git'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGitExtensions
    {
        Name                    = 'gitextensions'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGitVersion
    {
        Name                    = 'gitversion.portable'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallGradle
    {
        Name                    = 'gradle'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMercurial
    {
        Name                    = 'hg'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallHXD
    {
        Name                    = 'hxd'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallImHex
    {
        Name                    = 'imhex'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        chocoParams             = "--pre --force"
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallJDK8
    {
        Name                    = 'jdk8'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    # cChocoPackageInstaller InstallJetBrainsToolbox
    # {
    #     Name                    = 'jetbrainstoolbox'
    #     AutoUpgrade             = $AutoUpdate
    #     Ensure                  = 'Present'
    #     DependsOn               = "[cChocoInstaller]InstallChocolatey"
    #     PsDscRunAsCredential    = $Credential
    # }

    cChocoPackageInstaller InstallJQ
    {
        Name                    = 'jq'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallIdaFree
    {
        Name                    = 'ida-free'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallInsomniaRestApiClient
    {
        Name                    = 'insomnia-rest-api-client'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallKDiff3
    {
        Name                    = 'kdiff3'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallLLVM
    {
        Name                    = 'llvm'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMake
    {
        Name                    = 'make'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMaven
    {
        Name                    = 'maven'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallMeld
    {
        Name                    = 'meld'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    # cChocoPackageInstaller InstallMeshLab
    # {
    #     Name                    = 'meshlab'
    #     AutoUpgrade             = $AutoUpdate
    #     Ensure                  = 'Present'
    #     DependsOn               = "[cChocoInstaller]InstallChocolatey"
    #     PsDscRunAsCredential    = $Credential
    # }

    cChocoPackageInstaller InstallNinja
    {
        Name                    = 'ninja'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNotepadPlusPlus
    {
        Name                    = 'notepadplusplus.install'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNPPPluginmanager
    {
        Name                    = 'notepadplusplus-npppluginmanager'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNugetCommandline
    {
        Name                    = 'nuget.commandline'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallNugetPackageExplorer
    {
        Name                    = 'nugetpackageexplorer'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOctopusTools
    {
        Name                    = 'octopustools'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallOllyDebugger
    {
        Name                    = 'ollydbg'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }


    cChocoPackageInstaller InstallOpenJDK # Latest
    {
        Name                    = 'openjdk'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallPacketPowershell
    {
        Name                    = 'paket.powershell'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    # https://pmd.github.io/
    cChocoPackageInstaller InstallPacketPMD
    {
        Name                    = 'pmd'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallPostman
    {
        Name                    = 'postman'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallResourceHacker
    {
        Name                    = 'reshack'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSoapUI
    {
        Name                    = 'soapui'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallSVN
    {
        Name                    = 'svn'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVim
    {
        Name                    = 'vim'
        Params                  = '/RestartExplorer /NoDesktopShortcuts /NoDefaultVimrc'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Absent'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVimNeo
    {
        Name                    = 'neovim'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallVSCode
    {
        Name                    = 'vscode'
        Params                  = '/NoDesktopIcon'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWinMerge
    {
        Name                    = 'winmerge'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallWixToolset
    {
        Name                    = 'wixtoolset'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallXDebugger
    {
        Name                    = 'x64dbg.portable'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallYarn
    {
        Name                    = 'yarn'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }

    cChocoPackageInstaller InstallYQ
    {
        Name                    = 'yq'
        AutoUpgrade             = $AutoUpdate
        Ensure                  = 'Present'
        DependsOn               = "[cChocoInstaller]InstallChocolatey"
        PsDscRunAsCredential    = $Credential
    }
}
