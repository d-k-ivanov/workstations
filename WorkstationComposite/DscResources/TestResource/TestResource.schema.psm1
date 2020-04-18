<#
.SYNOPSIS
Test DSC Resource.

.DESCRIPTION
Test DSC Resource.
#>


Configuration TestResource
{
    Import-DscResource –ModuleName PSDesiredStateConfiguration

    Script DownloadBindToolsConfig
    {
        SetScript               = {
            Write-Output $MyInvocation >> C:\Temp\TestDSC.txt
        }
        GetScript               = { @{} }
        TestScript              = {
            Test-Path C:\Temp\TestDSC.txt
        }
    }
}
