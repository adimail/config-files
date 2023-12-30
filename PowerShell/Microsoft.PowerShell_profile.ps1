# Aliases
Set-Alias tt tree
Set-Alias ll ls
Set-Alias g git
Set-Alias vv nvim

# Prompt
oh-my-posh init pwsh --config 'C:\Users\pradi\Documents\devprofile\adimail.omp.json' | Invoke-Expression

# Functions
Function whereis ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

Function Set-ConsoleColor {
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [System.ConsoleColor]$ForegroundColor,

        [Parameter(Position = 1, Mandatory = $false)]
        [System.ConsoleColor]$BackgroundColor = [System.Console]::BackgroundColor
    )

    $Host.UI.RawUI.ForegroundColor = $ForegroundColor
    $Host.UI.RawUI.BackgroundColor = $BackgroundColor
    Clear-Host
}

Function Get-InternetStatus {
    $network = Get-NetConnectionProfile

    if ($network) {
        return "Connected to $($network.Name) - Internet is available"
    } else {
        return "Not connected to any network - No internet access"
    }
}

# Display information when a new terminal session is started
Function Show-StartupInfo {
    $currentPath = Get-Location
    $internetStatus = Get-InternetStatus

    @"

****************************************************

Current Path: $currentPath
$internetStatus

****************************************************

"@
}

# Call the function when a new terminal session starts
figlet Welcome Adi
Show-StartupInfo
