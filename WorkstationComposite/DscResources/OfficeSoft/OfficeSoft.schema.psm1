<#
.SYNOPSIS
Install office tools.

.DESCRIPTION
Install office tools.
#>

Configuration OfficeSoft
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
    # }


    # ========================= Audio ==========================
    cChocoPackageInstaller InstallAudacity
    {
        Name                    = 'audacity'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallAudacityLame
    {
        Name                    = 'audacity-lame'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallAudacityFfmpeg
    {
        Name                    = 'audacity-ffmpeg'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallFoobar2000
    {
        Name                    = 'foobar2000'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }


    # ========================= Communication ==================

    cChocoPackageInstaller InstallSlack
    {
        Name                    = 'slack'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallTeams
    {
        Name                    = 'microsoft-teams.install'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallTelegram
    {
        Name                    = 'telegram.install'
        Params                  = 'ALLUSERS=1'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallWhatsapp
    {
        Name                    = 'whatsapp'
        Params                  = 'ALLUSERS=1'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallSkype
    {
        Name                    = 'skype'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # cChocoPackageInstaller InstallZoom
    # {
    #     Name                    = 'zoom'
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    # }


    # ========================= Internet =======================
    cChocoPackageInstaller InstallGoogleChrome
    {
        Name                    = 'googlechrome'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallFirefox
    {
        Name                    = 'firefox'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallQbittorrent
    {
        Name                    = 'qbittorrent'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # cChocoPackageInstaller InstallTorBrowser
    # {
    #     Name                    = 'top-browser'
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    # }

    cChocoPackageInstaller InstallYoutubeDl
    {
        Name                    = 'youtube-dl'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }


    # ========================= Images =========================
    cChocoPackageInstaller InstallFsviewer
    {
        Name                    = 'fsviewer'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallGimp
    {
        Name                    = 'gimp'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallGraphviz
    {
        Name                    = 'graphviz'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallImagemagick
    {
        Name                    = 'imagemagick'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallInkscape
    {
        Name                    = 'inkscape'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallIrfanview
    {
        Name                    = 'irfanview'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallIrfanviewPlugins
    {
        Name                    = 'irfanviewplugins'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallKrita
    {
        Name                    = 'krita'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallLunacy
    {
        Name                    = 'lunacy'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallPaintNet
    {
        Name                    = 'paint.net'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallPencil
    {
        Name                    = 'pencil'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallXnView
    {
        Name                    = 'XnView'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }


    # ========================= Office =========================
    cChocoPackageInstaller InstallAdobereader
    {
        Name                    = 'adobereader'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallCalibre
    {
        Name                    = 'calibre'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallGhostscript
    {
        Name                    = 'Ghostscript.app'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallGrammarly
    {
        Name                    = 'grammarly'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    # cChocoPackageInstaller InstallLibrecad
    # {
    #     Name                    = 'librecad'
    #     AutoUpgrade             = $AutoUpgrade
    #     Ensure                  = 'Present'
    #     DependsOn               = '[cChocoInstaller]InstallChocolatey'
    # }

    cChocoPackageInstaller InstallMiktexInstall
    {
        Name                    = 'miktex.install'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallOffice365
    {
        Name                    = 'office365business'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallPandoc
    {
        Name                    = 'pandoc'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallPdfsam
    {
        Name                    = 'pdfsam'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallWindjview
    {
        Name                    = 'windjview'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallXpdfUtils
    {
        Name                    = 'xpdf-utils'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallYed
    {
        Name                    = 'yed'
        Params                  = '/Associate'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }


    # ========================= Video ==========================
    cChocoPackageInstaller InstallOpenshot
    {
        Name                    = 'openshot'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallScreentogif
    {
        Name                    = 'screentogif'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

    cChocoPackageInstaller InstallVlc
    {
        Name                    = 'vlc'
        AutoUpgrade             = $AutoUpgrade
        Ensure                  = 'Present'
        DependsOn               = '[cChocoInstaller]InstallChocolatey'
    }

}

