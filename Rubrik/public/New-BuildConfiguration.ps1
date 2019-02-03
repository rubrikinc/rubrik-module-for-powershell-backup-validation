function New-BuildConfiguration {
    Write-Output 'Welcome to the Rubrik Build interactive config file generation'
    Write-Output 'For more detailed information about the file generation process, please take a look at the "Quick Start - Use Case PowerShell Backup Validation" guide'
    do {
        $UserInput = Read-Host 'Would you like to open this guide in your browser? [Y]es/[N]o...'
        if (('Y','yes','N','no') -notcontains $UserInput) {
            $UserInput = $null
            Write-Warning 'Please input correct value'
        }
        if (('N','no') -contains $UserInput) {
            Write-Output 'Continuing with script execution without opening Quick Start guide'
        }     
        if (('Y','yes') -contains $UserInput) {
            $Uri = 'https://github.com/rubrikinc/Use-Case-PowerShell-Backup-Validation/blob/master/docs/quick-start.md'
            Write-Output ('Opening {0} in default browser' -f $Uri)
            Start-Process $Uri
        }
    } until ($UserInput)

    Write-Output '###'
    Write-Output 'Please enter the credentials for your Rubrik cluster, vCenter and the VMguest...'
    New-SecureCredential
    
    Write-Output '###'
    Write-Output 'Please enter the IP/FQDN of your Rubrik Cluster and vCenter and the relevant XML filename (Windows), KeyChain entry (macOS) which contains the respective credentials...'
    New-EnvironmentJson

    do {
        $UserInput = Read-Host 'Would you like to generate an additional Environment json? [Y]es/[N]o...'
        if (('Y','yes','N','no') -notcontains $UserInput) {
            $UserInput = $null
            Write-Warning 'Please input correct value'
        }
        if (('N','no') -contains $UserInput) {
        }     
        if (('Y','yes') -contains $UserInput) {
            $UserInput = $null
            Write-Output '###'
            Write-Output 'Please enter the IP/FQDN of your Rubrik Cluster and vCenter and the relevant XML filename (Windows), KeyChain entry (macOS) which contains the respective credentials...'
            New-EnvironmentJson
        }
    } until ($UserInput)

    Write-Output '###'
    Write-Output 'Please enter the required information for generation of the config file...'
    New-ConfigJson
    do {
        $UserInput = Read-Host 'Would you like to generate an additional Config Json? [Y]es/[N]o...'
        if (('Y','yes','N','no') -notcontains $UserInput) {
            $UserInput = $null
            Write-Warning 'Please input correct value'
        }
        if (('N','no') -contains $UserInput) {
        }     
        if (('Y','yes') -contains $UserInput) {
            $UserInput = $null
            Write-Output '###'
            Write-Output 'Please enter the required information for generation of the config file...'
            New-ConfigJson
        }
    } until ($UserInput)

    Write-Output '###'
    do {
        $UserInput = Read-Host 'Would you like to validate the config files that you have created? [Y]es/[N]o...'
        if (('Y','yes','N','no') -notcontains $UserInput) {
            $UserInput = $null
            Write-Warning 'Please input correct value'
        }
        if (('N','no') -contains $UserInput) {
        }     
        if (('Y','yes') -contains $UserInput) {
            Test-BuildConfiguration | Out-String
        }
    } until ($UserInput)

    Write-Output '###'
    do {
        $UserInput = Read-Host 'Would you like to validate if the required PowerShell modules for Backup Validation are currently installed?'
        if (('Y','yes','N','no') -notcontains $UserInput) {
            $UserInput = $null
            Write-Warning 'Please input correct value'
        }
        if (('N','no') -contains $UserInput) {
        }     
        if (('Y','yes') -contains $UserInput) {
            Test-PowerShellDependency | Out-String
        }
    } until ($UserInput)

    Write-Output '###'
    do {
        $UserInput = Read-Host 'Would you like to run the Backup Configuration?'
        if (('Y','yes','N','no') -notcontains $UserInput) {
            $UserInput = $null
            Write-Warning 'Please input correct value'
        }
        if (('N','no') -contains $UserInput) {
        }     
        if (('Y','yes') -contains $UserInput) {
            $Splat = New-InvokeBuildSplat
            Invoke-Build @Splat
        }
    } until ($UserInput) 
}