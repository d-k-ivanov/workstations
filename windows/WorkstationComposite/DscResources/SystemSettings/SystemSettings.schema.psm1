<#
.SYNOPSIS
System Settings.

.PARAMETER Credential
User credental.

.PARAMETER ComputerName
User credental.

.PARAMETER ComputerWorkgroup
User credental.
#>

Configuration SystemSettings
{
    Param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [string] $ComputerName,
        [string] $ComputerWorkgroup = 'Workgroup',
        [switch] $SetComputerName,
        [switch] $DisableSearchEngine,
        [switch] $AutoUpdate
    )

    Import-DscResource -Module ComputerManagementDsc -Name Computer

    # ===== Computer ====
    if ($SetComputerName)
    {
        Computer SetName
        {
            Name          = $ComputerName
            WorkGroupName = $ComputerWorkgroup
        }
    }

    # ===== Explorer ======================
    Registry DisableIEFirstRunCustomization
    {
        Ensure               = "Present"
        Key                  = "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main"
        ValueName            = "DisableFirstRunCustomize"
        ValueData            = "2"
        ValueType            = "Dword"
        PsDscRunAsCredential = $Credential
    }

    Registry ShowFileExtensions
    {
        Ensure               = "Present"
        Key                  = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        ValueName            = "HideFileExt"
        ValueData            = "0"
        ValueType            = "Dword"
        PsDscRunAsCredential = $Credential
    }

    # ===== Features ================================
    WindowsOptionalFeature  EnableTelnetClientFeature
    {
        Name   = 'TelnetClient'
        Ensure = 'Enable'
    }

    WindowsOptionalFeature  EnableTFTPFeature
    {
        Name   = 'TFTP'
        Ensure = 'Enable'
    }

    WindowsOptionalFeature  EnableSimpleTCPFeature
    {
        Name   = 'SimpleTCP'
        Ensure = 'Enable'
    }

    WindowsOptionalFeature  EnableNFSClientFeature
    {
        Name   = 'ServicesForNFS-ClientOnly'
        Ensure = 'Enable'
    }

    WindowsOptionalFeature  EnableNFSInfrastructureFeature
    {
        Name   = 'ClientForNFS-Infrastructure'
        Ensure = 'Enable'
    }

    WindowsOptionalFeature  EnableNFSAdministrationFeature
    {
        Name   = 'NFS-Administration'
        Ensure = 'Enable'
    }

    WindowsOptionalFeature  DisablePringToPDFFeature
    {
        Name   = 'Printing-PrintToPDFServices-Features'
        Ensure = 'Disable'
    }

    WindowsOptionalFeature  DisablePringToXPSFeature
    {
        Name   = 'Printing-XPSServices-Features'
        Ensure = 'Disable'
    }

    WindowsOptionalFeature  DisableWorkFoldersFeature
    {
        Name   = 'WorkFolders-Client'
        Ensure = 'Disable'
    }

    # WindowsOptionalFeature  DisableWindowsMediaPlayerFeature
    # {
    #     Name   = 'WindowsMediaPlayer'
    #     Ensure = 'Disable'
    # }

    If ($DisableSearchEngine)
    {
        WindowsOptionalFeature  DisableSearchEngineFeature
        {
            Name   = 'SearchEngine-Client-Package'
            Ensure = 'Disable'
        }
    }

    # ===== Lockscreen =======================================================
    New-Item 'C:\tools\wall' -ItemType Directory -ErrorAction SilentlyContinue
    Script DownloadLockscreenWallpaper
    {
        SetScript  = {
            $lockPath = 'C:\tools\wall'
            New-Item $lockPath -ItemType Directory -ErrorAction SilentlyContinue
            $url = 'https://4kwallpapers.com/images/wallpapers/greebles-render-cgi-3d-background-cyan-background-glowing-3840x2160-2196.jpg'
            Invoke-WebRequest -Uri $url -OutFile "${lockPath}\lock.jpg"
        }
        GetScript  = { @{} }
        TestScript = {
            $lockPath = 'C:\tools\wall'
            Test-Path "${lockPath}\lock.jpg"
        }
    }

    Registry SetDefaultLockscreenWallpaper
    {
        Ensure               = "Present"
        Force                = $true
        Key                  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
        ValueName            = "LockScreenImage"
        ValueData            = "C:\tools\wall\lock.jpg"
        ValueType            = "String"
        PsDscRunAsCredential = $Credential
    }
}
