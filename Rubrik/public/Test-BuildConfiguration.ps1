function Test-BuildConfiguration {
    param(
        [string] $Path = '.'
    )

    if (Test-Path $Path) {
        if (Test-FolderStructure -Environment -Path $Path) {
            $Files = Get-ChildItem -Path (Join-Path $Path 'environment') -File -ErrorAction SilentlyContinue
            if ($Files) {
                $Files | ForEach-Object {
                    try {
                        $null = Get-Content -Raw -Path $_.FullName | ConvertFrom-Json -ErrorAction Stop
                        $CurrentHash = [ordered]@{
                            ValidJson = $true
                            Text = 'The configuration file ''{0}'' is a valid Json file' -f $_.Name
                        }
                    } catch {
                        $CurrentHash = [ordered]@{
                            ValidJson = $false
                            Text = 'The configuration file ''{0}'' could not be converted to a PowerShell object, invalid Json' -f $_.Name
                        }
                    } finally {
                        $CurrentHash.FileName = $_.FullName
                        [pscustomobject]$CurrentHash
                    }
                }
            } else {
                [pscustomobject]@{
                    FileName = $null
                    ValidJson = $null
                    Text = 'No files found in the environment folder, please create the required files'
                }
            }
        }
        if (Test-FolderStructure -Config -Path $Path) {
            $Files = Get-ChildItem -Path (Join-Path $Path 'config') -File -ErrorAction SilentlyContinue
            if ($Files) {
                $Files | ForEach-Object {
                    $CurrentHash = [ordered]@{
                        FileName = $_.FullName
                    }

                    try {
                        $null = Get-Content -Raw -Path $_.FullName | ConvertFrom-Json -ErrorAction Stop
                        $CurrentHash = [ordered]@{
                            ValidJson = $true
                            Text = 'The configuration file ''{0}'' is a valid Json file' -f $_.Name
                        }
                    } catch {
                        $CurrentHash = [ordered]@{
                            ValidJson = $false
                            Text = 'The configuration file ''{0}'' could not be converted to a PowerShell object, invalid Json' -f $_.Name
                        }
                    } finally {
                        $CurrentHash.FileName = $_.FullName
                        [pscustomobject]$CurrentHash
                    }
                }
            } else {
                [pscustomobject]@{
                    FileName = $null
                    ValidJson = $null
                    Text = 'No files found in the config folder, please create one config json file'
                }
            }        
        }
        
        switch (Get-PowerShellVersion) {
            'Windows' {
                $Files = Get-ChildItem -Path (Join-Path $Path 'credential') -File -ErrorAction SilentlyContinue
                if ($Files) {
                    $Files | ForEach-Object {
                        $CurrentHash = [ordered]@{
                            FileName = $_.FullName
                            UserName = $false
                            Password = $false
                        }
    
                        try {
                            $CurrentXml = Import-Clixml -Path $_.FullName -ErrorAction Stop
                            $CurrentHash.ValidXml = $true
                            $CurrentHash.Text = 'The configuration file ''{0}'' is a valid XML file' -f $_.Name
                        } catch {
                            $CurrentHash.ValidXml = $false
                            $CurrentHash.Text = 'The configuration file ''{0}'' could not be converted to a PowerShell object, invalid Xml' -f $_.Name
                        } finally {
                            if ($CurrentXml.UserName) {
                                $CurrentHash.UserName = $true
                            }
                            if ($CurrentXml.Password) {
                                $CurrentHash.Password = $true
                            }
                            $CurrentHash.FileName = $_.FullName
                            [pscustomobject]$CurrentHash
                        }
                    }
                } else {
                    [pscustomobject]@{
                        ValidXml = $null
                        Text = 'No files found in the credential folder, please create the required credential files'
                        UserName = $null
                        Password = $null
                        FileName = $null
                    }
                }
            }
            'macOS' {
    
            }
        }
    }
}
