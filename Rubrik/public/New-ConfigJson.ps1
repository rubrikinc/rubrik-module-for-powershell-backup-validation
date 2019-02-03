function New-ConfigJson {
    param(
        [parameter(Mandatory)]
            [string] $ConfigFilePath,
        [parameter(Mandatory)]
            [string] $Name,
        [parameter(Mandatory)]
            [string] $MountName,
        [parameter(Mandatory)]
            [string] $GuestCred,
        [parameter(Mandatory)]
            [ipaddress] $TestIp,
        [parameter(Mandatory)]
            [string] $TestNetwork,
        [parameter(Mandatory)]
            [ipaddress] $TestGateway,
        [parameter(Mandatory)]
            [string[]] $Tasks
    )

    if (-not (Test-FolderStructure -Config)) {
        $null = New-Item -Path './config' -ItemType Directory
    }

    $CurrentConfig = [pscustomobject]$MyInvocation.BoundParameters
    $CurrentConfig.TestIp = $CurrentConfig.TestIp.ToString()
    $CurrentConfig.TestGateway = $CurrentConfig.TestGateway.ToString()
    
    $CurrentConfig |
    ConvertTo-Json -Depth 3 | 
    Set-Content -Path (Join-Path './config' $ConfigFilePath)
}