function New-InvokeBuildSplat {
    param(
        [parameter(mandatory)]
            [string] $File,
        [parameter(mandatory)]
            [string] $EnvironmentFile,
        [parameter(mandatory)]
            [string] $ConfigFile,
        [parameter(mandatory)]
            [string] $IdentityPath
    )

    $MyInvocation.BoundParameters
}