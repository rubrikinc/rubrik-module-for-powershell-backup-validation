function New-EnvironmentJSON {
    param(
        [parameter(Mandatory)]
            [string] $EnvironmentFilePath,
        [parameter(Mandatory)]
            [string] $RubrikServer,
        [parameter(Mandatory)]
            [string] $RubrikCred,
        [parameter(Mandatory)]
            [string] $VMwareServer,
        [parameter(Mandatory)]
            [string] $VMwareCred
    )

    if (-not (Test-FolderStructure -Environment)) {
        $null = New-Item -Path './environment' -ItemType Directory
    }

    [pscustomobject]$MyInvocation.BoundParameters |
    ConvertTo-Json -Depth 3 | 
    Set-Content -Path (Join-Path './environment' $EnvironmentFilePath)
}