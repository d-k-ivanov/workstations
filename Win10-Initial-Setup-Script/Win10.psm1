##########
# Win 10 / Server 2016 / Server 2019 Initial Setup Script - Default preset
# Author: Disassembler <disassembler@dasm.cz>
# Modified: Dmitry Ivanov <d.k.ivanov@live.com>
# Version: v3.11.0, 2021-01-11
# Source: https://github.com/Disassembler0/Win10-Initial-Setup-Script
##########

# $Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
# $Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Modules = @( Get-ChildItem -Path $PSScriptRoot\Modules\*.ps1 -ErrorAction SilentlyContinue )

# Foreach($import in @($Public + $Private))
Foreach($import in $Modules)
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Export-ModuleMember -Function $Public.Basename
Export-ModuleMember -Function *
