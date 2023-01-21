Write-Host 'Remove Windows Defender Policies'
cmd /c 'reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /f'

Write-Host 'Enable Windows Defender services'
cmd /c 'reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "2" /f'
cmd /c 'reg add "HKLM\System\CurrentControlSet\Services\WdBoot" /v "Start" /t REG_DWORD /d "2" /f'
cmd /c 'reg add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d "2" /f'
cmd /c 'reg add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "2" /f'
cmd /c 'reg add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "2" /f'
cmd /c 'reg add "HKLM\System\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "2" /f'

Write-Host 'Enable Windows Defender Logging'
cmd /c 'reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "1" /f'
cmd /c 'reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "1" /f'

Write-Host 'Enable WD Tasks'
cmd /c 'schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Enable'
cmd /c 'schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Enable'
cmd /c 'schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Enable'
cmd /c 'schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Enable'

# 1 - Potentially Unwanted Application protection (PUP) is enabled, the applications with unwanted behavior will be blocked at download and install-time
Write-Host 'Enable Potentially Unwanted Application protection (PUP)'
cmd /c 'reg add "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d "1" /f'

# 0 - Disable
# 1 - Basic
# 2 - Advanced
Write-Host 'Enable Cloud-based Protection'
cmd /c 'reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v "SpynetReporting" /t REG_DWORD /d "1" /f'

# Send file samples when further analysis is required
# 0 - Always prompt
# 1 - Send safe samples automatically
# 2 - Never send
# 3 - Send all samples automatically
Write-Host 'Enable Send file samples'
cmd /c 'reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v "SubmitSamplesConsent" /t REG_DWORD /d "1" /f'

# To prevent WD using too much CPU, add this file to the exclusion list:
# C:\Program Files\Windows Defender\MsMpEng.exe
# Write-Host 'Add MsMpEng.exe to the exclusion list'
# cmd /c 'reg add "HKLM\Software\Microsoft\Windows Defender\Exclusions\Paths" /v "C:\Program Files\Windows Defender\MsMpEng.exe" /t REG_DWORD /d "0" /f'
