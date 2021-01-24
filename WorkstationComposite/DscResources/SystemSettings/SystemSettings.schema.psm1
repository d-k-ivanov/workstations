<#
.SYNOPSIS
Install virtualization tools.

.DESCRIPTION
Install virtualization tools.

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
        [switch] $NoUpgrate
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -Module ComputerManagementDsc -Name Computer


    # ============================== Computer ==============================
    if ($SetComputerName)
    {
        Computer SetName
        {
            Name                    = $ComputerName
            WorkGroupName           = $ComputerWorkgroup
        }
    }


    # ============================== Internet Explorer =====================
    Registry DisableIEFirstRunCustomization
    {
        Ensure                  = "Present"
        Key                     = "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main"
        ValueName               = "DisableFirstRunCustomize"
        ValueData               = "2"
        ValueType               = "Dword"
        PsDscRunAsCredential    = $Credential
    }

    Registry ShowFileExtensions
    {
        Ensure                  = "Present"
        Key                     = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        ValueName               = "HideFileExt"
        ValueData               = "0"
        ValueType               = "Dword"
        PsDscRunAsCredential    = $Credential
    }


    # ============================== Windows Features ======================
    WindowsOptionalFeature  EnableTelnetClientFeature
    {
        Name                 = 'TelnetClient'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableTFTPFeature
    {
        Name                 = 'TFTP'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableSimpleTCPFeature
    {
        Name                 = 'SimpleTCP'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableNFSClientFeature
    {
        Name                 = 'ServicesForNFS-ClientOnly'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableNFSInfrastructureFeature
    {
        Name                 = 'ClientForNFS-Infrastructure'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  EnableNFSAdministrationFeature
    {
        Name                 = 'NFS-Administration'
        Ensure               = 'Enable'
    }

    WindowsOptionalFeature  DisablePringToPDFFeature
    {
        Name                 = 'Printing-PrintToPDFServices-Features'
        Ensure               = 'Disable'
    }

    WindowsOptionalFeature  DisablePringToXPSFeature
    {
        Name                 = 'Printing-XPSServices-Features'
        Ensure               = 'Disable'
    }

    WindowsOptionalFeature  DisableWorkFoldersFeature
    {
        Name                 = 'WorkFolders-Client'
        Ensure               = 'Disable'
    }

    WindowsOptionalFeature  DisableWindowsMediaPlayerFeature
    {
        Name                 = 'WindowsMediaPlayer'
        Ensure               = 'Disable'
    }

    If($DisableSearchEngine)
    {
        WindowsOptionalFeature  DisableSearchEngineFeature
        {
            Name                 = 'SearchEngine-Client-Package'
            Ensure               = 'Disable'
        }
    }
}

