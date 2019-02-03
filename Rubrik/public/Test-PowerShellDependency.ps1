function Test-PowerShellDependency {
    $RequiredModules = 'Rubrik','VMware.PowerCLI','InvokeBuild'

    $RequiredModules | ForEach-Object {
        $CurrentHash = [ordered]@{
            Module = $_
        }
        
        if (Get-Module -ListAvailable -Name $_) {
            $CurrentHash.Installed = $true
            $CurrentHash.Text = "$_ PowerShell module is installed and available"
        } else {
            $CurrentHash.Installed = $false
            $CurrentHash.Text = "$_ PowerShell module is not available"
        }

        [pscustomobject]$CurrentHash
    }
}