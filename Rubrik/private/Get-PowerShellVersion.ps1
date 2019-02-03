function Get-PowerShellVersion {
    if (($PSVersiontable.Platform -eq 'Win32NT') -or
    ($PSVersiontable.PSVersion.Major -lt 6))
    {
        'Windows'
    }
    elseif (($PSVersiontable.Platform -eq 'Unix') -and
    ($PSVersiontable.OS -match 'Darwin'))
    {
        'macOS'
    } elseif ($PSVersiontable.Platform -eq 'Unix') {
        'UnknownUnix'
    }
    else {
        'Unknown'
    }
}
