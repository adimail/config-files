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


#Opens a folder in my directory for practice coding
Function classroom {
    code C:\Users\pradi\Documents\classroom
}

function portfolio ($command){
    if($command -eq "view"){
        start https://adimail.github.io
    } elseif ($command -eq "code"){
        code C:\Users\pradi\Documents\adimail.github.io
    } else {
        echo "Invalid command: comands avaliable=>  "view" && "code""
    }
}

function llm ($command){
    if($command -eq "gpt"){
        start https://chat.openai.com
    } elseif ($command -eq "bard"){
		start https://bard.google.com/chat
    } else {
        echo "Invalid command: comands avaliable=>  gpt && bard"
    }
}

function yt ($command){
    if ($command -eq "hist") {
        start https://www.youtube.com/feed/history
    } elseif (-not $command) {
        start https://www.youtube.com
    } else {
        echo "Invalid command: commands available=> hist"
    }
}


Function Get-InternetStatus {
    $network = Get-NetConnectionProfile

    if ($network) {
        return "Connected to $($network.Name) $($network.wlan)"
    } else {
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


[System.Console]::Title = "pwsh"


# Call the function when a new terminal session starts
figlet Welcome ADI
Show-StartupInfo

import-Module terminal-icons
set-PSReadLineOption -PredictionViewStyle ListView