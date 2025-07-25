﻿<#
.SYNOPSIS
Install office tools.

.DESCRIPTION
Install office tools.

.PARAMETER Credential
User credental.

.PARAMETER AutoUpdate
Upgrade installed packages to their latest versions.
#>

Configuration OfficeTools
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
        InstallDir = 'C:\ProgramData\chocolatey'
    }

    ## Template
    # cChocoPackageInstaller InstallPackageName
    # {
    #     Name        = 'PackageName'
    #     Version     = ''
    #     Params      = ''
    #     AutoUpgrade = $AutoUpdate
    #     Ensure      = 'Present | Absent'
    #     DependsOn   = '[cChocoInstaller]InstallChocolatey'
    # }

    cChocoPackageInstaller InstallAdobereader
    {
        Name                 = 'adobereader'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        chocoParams          = '--ignore-checksums'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallAnki
    {
        Name                 = 'anki'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallCalibre
    {
        Name                 = 'calibre'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFontCascadiaCode
    {
        Name                 = 'cascadiacode'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFontCascadiaMono
    {
        Name                 = 'cascadiamono'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallFontCascadiaMonoPL
    # {
    #     Name                 = 'cascadiamonopl'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Present'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }.

    cChocoPackageInstaller InstallFontDejavu
    {
        Name                 = 'dejavufonts'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFontFiraCode
    {
        Name                 = 'firacode'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFontForge
    {
        Name                 = 'fontforge'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFontInconsolata
    {
        Name                 = 'inconsolata'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFontNerdSourceCodePro
    {
        Name                 = 'nerd-fonts-hack'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFontNerdSourceCodePro
    {
        Name                 = 'nerd-fonts-sourcecodepro'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallFontSourceCodePro
    {
        Name                 = 'sourcecodepro'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallGhostscript
    {
        Name                 = 'Ghostscript.app'
        Version              = '9.53.3'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallGrammarly
    {
        Name                 = 'grammarly'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallLibreOffice
    {
        Name                 = 'libreoffice-fresh'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallNotion
    {
        Name                 = 'notion'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # cChocoPackageInstaller InstallOffice365
    # {
    #     Name                 = 'office365business'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Absent'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }

    cChocoPackageInstaller InstallPdf24
    {
        Name                 = 'pdf24'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallPdfsam
    {
        Name                 = 'pdfsam'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    # Not working. Download from here: https://quest-app.appspot.com
    # cChocoPackageInstaller InstallQtranslate
    # {
    #     Name                 = 'qtranslate'
    #     AutoUpgrade          = $AutoUpdate
    #     Ensure               = 'Present'
    #     DependsOn            = '[cChocoInstaller]InstallChocolatey'
    #     PsDscRunAsCredential = $Credential
    # }

    cChocoPackageInstaller InstallSumatraPDF
    {
        Name                 = 'sumatrapdf.install'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        chocoParams          = '--ignore-checksums'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallThunderbird
    {
        Name                 = 'thunderbird'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallWindjview
    {
        Name                 = 'windjview'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Absent'
        chocoParams          = '--ignore-checksums'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }

    cChocoPackageInstaller InstallXpdfUtils
    {
        Name                 = 'xpdf-utils'
        AutoUpgrade          = $AutoUpdate
        Ensure               = 'Present'
        DependsOn            = '[cChocoInstaller]InstallChocolatey'
        PsDscRunAsCredential = $Credential
    }
}
