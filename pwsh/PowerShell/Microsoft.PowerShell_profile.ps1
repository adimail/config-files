<#
                      7#G~
                    7BB7J#P~
                 .?BG!   .?#G!
                :B@J       .?BB7
             ::  :Y#P~        7BB?.
           ^Y#?    :J#G~        !GB?.
          !&@!       .?#G!        J@B:
       ~^  ^Y#5^       .7BB7    .PB?.  ~^
    .!GB7    :Y#5^        !GB7.  ^.    Y#5^
    7&&~       !@@G~       .P@#J.       J@B^
     :J#G~   ~P#J^?#G!   .?#G~~P#Y:  .7BB7
       .?BG7P#J.   .7BB7J#P~    ^5#Y?BG!
         .?BJ.        7#G~        ^5B!

    Author: Aditya Godse (https://adimail.github.io)
    Description: PowersShell Profile containing aliases and functions to be loaded when a new PowerShell session is started.
#>

Clear-Host
$Host.UI.RawUI.WindowTitle = "pwsh - global"

# Variables
$nvimconfigdir = 'C:\Users\pradi\AppData\Local\nvim'
$classroom = 'C:\Users\pradi\Documents\classroom' 

. C:\Users\pradi\OneDrive\Documents\PowerShell\Scripts\adimail.ps1

# --------------------------------------------------------------------------------------------------------
# Aliases
Set-Alias tt tree
Set-Alias ll ls
Set-Alias g git
Set-Alias vv nvim
Set-Alias gd gotodesktop
Set-Alias getwifiinmyrange readwifinearme
Set-Alias viewdb view-main-database
Set-Alias addtask insert-task
Set-Alias rt remove-task
Set-Alias at insert-task

# Prompt
oh-my-posh init pwsh --config 'C:\Users\pradi\Documents\devprofile\adimail.omp.json' | Invoke-Expression


# Functions
Function whereis ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function writenote ($command) {
    $notesPath = "C:\Users\pradi\Desktop\notes"

    if ($command) {
        $targetPath = Join-Path $notesPath "self\$command"
        if (Test-Path $targetPath -PathType Container) {
            Set-Location $targetPath
            ls
        }
        else {
            Write-Host "Error: Folder '$command' not found. Enter an appropriate folder name."
            Write-Host "Available folders in '$notesPath\self':"
            ls (Join-Path $notesPath "self") -Directory
        }
    }
    else {
        cd $notesPath
        ls
    }
}

function nvimconfig {
    Set-Location $nvimconfigdir
    tree
    ls
}

#Opens a folder in my directory for practice coding
Function classroom {
    code $classroom
}

function portfolio ($command) {
    if ($command -eq "view") {
        start https://adimail.github.io
    }
    elseif ($command -eq "code") {
        code C:\Users\pradi\Documents\adimail.github.io
    }
    else {
        Write-Host "Invalid command: comands avaliable=>  "view" && "code""
    }
}

function keybr {
    Start-Process https://www.keybr.com/
}

function llm ($command) {
    if ($command -eq "gpt") {
        Start-Process https://chat.openai.com
    }
    elseif ($command -eq "bard") {
        Start-Process https://bard.google.com/chat
    }
    else {
        Write-Host "Invalid command: comands avaliable=>  gpt && bard"
    }
}

function gotodesktop {
    Clear-Host
    cd C:\Users\pradi\Desktop
}

function yt ($command) {
    if ($command -eq "hist") {
        Start-Process https://www.youtube.com/feed/history
    }
    elseif (-not $command) {
        Start-Process https://www.youtube.com
    }
    else {
        Write-Host "Invalid command: commands available=> hist"
    }
}


Function Get-InternetStatus {
    $network = Get-NetConnectionProfile

    if ($network) {
        return "Connected to $($network.Name) $($network.wlan)"
    }
    else {
        return "Offline"
    }
}

Function Show-StartupInfo {
    $currentPath = Get-Location
    $internetStatus = Get-InternetStatus

    @"

****************************************************

Current Path    : $currentPath
Internet Status : $internetStatus

****************************************************

"@
}

function getwifipasswords {
    $wifiProfiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object {
        $_ -replace "^\s+All User Profile\s+:\s+"
    }

    foreach ($profile in $wifiProfiles) {
        $wifiInfo = netsh wlan show profile $profile key=clear
        $wifiInfo | Select-String "SSID name", "Key Content"
        Write-Host "------------------------"
    }
}


function readwifinearme {
    $wifiNetworks = netsh wlan show networks mode=Bssid
    $wifiNetworks | Select-String "SSID", "Signal", "Channel", "Authentication", "Encryption"
}

# Function to clear environment variables when exiting
function Clear-EnvironmentVariables {
    $env:DB_USERNAME = $null
    $env:DB_PASSWORD = $null
    Write-Host "Environment variables cleared."
}

# Register the function to run when PowerShell exits
$profileDir = Split-Path $PROFILE
$profileExitScript = Join-Path $profileDir "ProfileExit.ps1"
"`n`n Clear-EnvironmentVariables" | Out-File -Append -FilePath $profileExitScript

Clear-Host
Set-PSReadLineOption -PredictionViewStyle ListView
figlet Welcome ADI
Show-StartupInfo

