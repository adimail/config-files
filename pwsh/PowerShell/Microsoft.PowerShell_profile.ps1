# Variables
$enableLog = $false
$nvimconfigdir = 'C:\Users\pradi\AppData\Local\nvim'
$classroom = 'C:\Users\pradi\Documents\classroom' 


# --------------------------------------------------------------------------------------------------------
# Aliases
Set-Alias tt tree
Set-Alias ll ls
Set-Alias g git
Set-Alias vv nvim
Set-Alias dropmyneedle Activate-My-Powershell 
Set-Alias gd gotodesktop

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
            cd $targetPath
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
    code C:\Users\pradi\Documents\classroom
}

function portfolio ($command) {
    if ($command -eq "view") {
        start https://adimail.github.io
    }
    elseif ($command -eq "code") {
        code C:\Users\pradi\Documents\adimail.github.io
    }
    else {
        echo "Invalid command: comands avaliable=>  "view" && "code""
    }
}

function keybr {
    start https://www.keybr.com/
}

function llm ($command) {
    if ($command -eq "gpt") {
        start https://chat.openai.com
    }
    elseif ($command -eq "bard") {
        start https://bard.google.com/chat
    }
    else {
        echo "Invalid command: comands avaliable=>  gpt && bard"
    }
}

function gotodesktop {
    cls
    cd C:\Users\pradi\Desktop
}

function yt ($command) {
    if ($command -eq "hist") {
        start https://www.youtube.com/feed/history
    }
    elseif (-not $command) {
        start https://www.youtube.com
    }
    else {
        echo "Invalid command: commands available=> hist"
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

# Display information when a new terminal session is started
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



function Activate-My-Powershell {
    figlet Welcome ADI
    Show-StartupInfo
}

cls
Set-PSReadLineOption -PredictionViewStyle ListView
Activate-My-Powershell
