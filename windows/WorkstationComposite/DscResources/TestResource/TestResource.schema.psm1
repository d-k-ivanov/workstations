<#
.SYNOPSIS
Test DSC Resource.

.DESCRIPTION
Test DSC Resource.
#>

Configuration TestResource
{
    Script DownloadBindToolsConfig
    {
        SetScript  = {
            Write-Output $MyInvocation >> C:\Temp\TestDSC.txt
        }
        GetScript  = { @{} }
        TestScript = {
            Test-Path C:\Temp\TestDSC.txt
        }
    }
}
