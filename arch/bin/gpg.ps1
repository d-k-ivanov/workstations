<#
.SYNOPSIS
    Encrypt or decrypt protected files.

.DESCRIPTION
    Encrypt or decrypt protected files.

.PARAMETER Operation
    Operation: encrypt or decrypt.

.EXAMPLE
    gpg.ps1 decrypt

.INPUTS
    String

.OUTPUTS
    None

.NOTES
    Written by: Dmitriy Ivanov
#>
param (
    [Parameter(Mandatory=$true)]
    [string] $Operation
)

function Usage() {
    Write-Host "Usage:" -ForegroundColor Yellow
    $app = Split-Path $MyInvocation.PSCommandPath -Leaf
    Write-Host "`t$app <option>[e]ncrypt [d]ecrypt" -ForegroundColor Yellow
    Write-Host "" -ForegroundColor Yellow
    Write-Host "Options:" -ForegroundColor Yellow
    Write-Host "`t- [e]ncrypt" -ForegroundColor Yellow
    Write-Host "`t- [d]ecrypt" -ForegroundColor Yellow
    Write-Host "" -ForegroundColor Yellow
}

If (Get-Command gpg.exe -ErrorAction SilentlyContinue | Test-Path) {
    $ProjectPath = (Get-Item $PSScriptRoot).Parent.FullName

    $secured_files = @(
        "secrets/ansible_password"
    )

    $recipients = @()

    Get-ChildItem (Join-Path $ProjectPath "gpg") | ForEach-Object {
        $recipients += "-r " + $_.BaseName
    }

    switch ($Operation) {
        ({$PSItem -eq 'encrypt' -Or $PSItem -eq 'e'}) {
            foreach ($file in $secured_files) {
                Write-Host -ForegroundColor Green "Encrypting $file"
                gpg -e --yes --trust-model always $recipients $file
            }
        }
        ({$PSItem -eq 'decrypt' -Or $PSItem -eq 'd'}) {
            foreach ($file in $secured_files) {
                Write-Host -ForegroundColor Green "Decrypting $file"
                gpg --output $file --decrypt $file".gpg"
            }
        }
        Default {
            Write-Host "ERROR: Wrong operation..." -ForegroundColor Red
            Usage
        }
    }

} else {
    Write-Host "ERROR: gpg.exe not found..." -ForegroundColor Red
    Write-Host "ERROR: GPG4Win should be installed and gpg.exe added to the %PATH% env" -ForegroundColor Red
}

