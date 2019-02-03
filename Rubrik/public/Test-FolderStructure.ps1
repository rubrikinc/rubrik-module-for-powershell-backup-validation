function Test-FolderStructure {
    param(
        [parameter(ParameterSetName='Environment')]
        [parameter(ParameterSetName='Config')]
        [parameter(ParameterSetName='Credential')]
        [string] $Path = '.',
        [parameter(ParameterSetName='Environment')]
            [switch] $Environment,
        [parameter(ParameterSetName='Config')]
            [switch] $Config,
        [parameter(ParameterSetName='Credential')]
            [switch] $Credential
    )

    if ($Environment) {
        Test-Path -Path (Join-Path $Path 'environment')
    }

    if ($Config) {
        Test-Path -Path (Join-Path $Path 'config')
    }

    if ($Credential) {
        Test-Path -Path (Join-Path $Path 'credential')
    }
}