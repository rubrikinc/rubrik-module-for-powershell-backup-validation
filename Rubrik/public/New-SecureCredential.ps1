function New-SecureCredential {
    param(
        $Path = 'credential',
        [pscredential] $RubrikCred,
        [pscredential] $VMwareCred,
        [pscredential] $GuestCred
    )

    if (-not $RubrikCred) {
        $RubrikCred = Get-Credential -Message 'Please enter credentials to connect to Rubrik cluster...'
    }
    if (-not $VMwareCred) {
        $VMwareCred = Get-Credential -Message 'Please enter credentials to connect to vCenter...'
    }
    if (-not $GuestCred) {
        $GuestCred = Get-Credential -Message 'Please enter credentials to connect to Guest OS'
    } 

    switch (Get-PowerShellVersion) {
        'Windows' {
            if (-not (Test-FolderStructure -Credential)) {
                $null = New-Item -Path './credential' -ItemType Directory
            }
            
            'RubrikCred', 'VMwareCred', 'GuestCred' | ForEach-Object {
                $Credential = (Get-Item variable:$_).Value
                $Credential | Export-Clixml -Path $(Join-Path $Path "$_.xml")
            }
        }
        'macOS' {

        }
        default {Write-Error 'Current OS platform not supported '}
    }
}