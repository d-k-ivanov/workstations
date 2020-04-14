[CmdletBinding(SupportsShouldProcess=$true)]
param
(
    [Parameter(Mandatory, ValueFromPipeline)]
    [ValidateNotNullOrEmpty()]
    [string] $ResourceName,

    [switch] $Force
)

$resourceFolder  = Join-Path $PSScriptRoot "WorkstationComposite\DscResources\${ResourceName}" 
$resourcePSM     = "$($ResourceName).schema.psm1"
$resourcePSD     = "$($ResourceName).psd1"
    
if($PSCmdlet.ShouldProcess($resourceFolder, "Creating new resource $ResourceName"))
{ 
    New-Item -ItemType Directory -Path $resourceFolder -Force:$Force  | Out-Null

    if ((-not (test-path $resourcePSM)) -or ($Force)) { 
        $ModuleBody = @"
Configuration ${ResourceName}
{
}

"@
        $ModuleBody | Out-File "${resourceFolder}\${resourcePSM}"
    }
    if ((-not (test-path $resourcePSD)) -or ($Force)) { 
        $Manifest = @"
@{
    RootModule           = '${ResourceName}.schema.psm1'
    ModuleVersion        = '0.1.0'
    GUID                 = '$([System.guid]::NewGuid().toString())'
    Author               = '${Env:USERNAME}'
    CompanyName          = 'NA'
    Copyright            = 'NA'
    DscResourcesToExport = @('${ResourceName}')
}

"@
        $Manifest | Out-File "${resourceFolder}\${resourcePSD}"
    }
}    
