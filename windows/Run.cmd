@echo off

where /q powershell.exe && powershell.exe -NoProfile -File "%~dp0\Run.ps1"
where /q pwsh.exe       && pwsh.exe       -NoProfile -File "%~dp0\Run.ps1"
