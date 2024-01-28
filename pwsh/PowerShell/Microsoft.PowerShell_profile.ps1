<#
            .___.__               .__.__   
_____     __| _/|__| _____ _____  |__|  |  
\__  \   / __ | |  |/     \\__  \ |  |  |  
 / __ \_/ /_/ | |  |  Y Y  \/ __ \|  |  |__
(____  /\____ | |__|__|_|  (____  /__|____/
     \/      \/          \/     \/         

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
Set-Alias q "exit(0)"
Set-Alias cal Get-Calendar
Set-Alias entry write-note-for-today 

# Prompt
oh-my-posh init pwsh --config 'C:\Users\pradi\Documents\devprofile\adimail.omp.json' | Invoke-Expression


# Functions
Function whereis ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}


function la {
    param (
        [string]$command = ''
    )

    if ($command -eq 'hidden') {
        Get-ChildItem -Force -Attributes Hidden
    }
    else {
        Get-ChildItem -Force
    }
}

function writenote ($command) {
    $notesPath = "C:\Users\pradi\Desktop\notes"

    if ($command) {
        if ($command -eq "today") {
            cls
            write-note-for-today
        }
        else {
            $targetPath = Join-Path $notesPath "self\$command"
            if (Test-Path $targetPath -PathType Container) {
                Set-Location $targetPath
                ls
                cal
            }
            else {
                Write-Host "Error: Folder '$command' not found. Enter an appropriate folder name."
                Write-Host "Available folders in '$notesPath\self':"
                ls (Join-Path $notesPath "self") -Directory
            }
        }
    }
    else {
        cd $notesPath
        cal
        ls
    }
}

function write-note-for-today {
    writenote

    $d = Get-Date
    $month = $d.ToString('MMM', [System.Globalization.CultureInfo]::CurrentCulture).ToLower()
    $date = $d.ToString('dd', [System.Globalization.CultureInfo]::CurrentCulture)
    $year = $d.ToString('yyyy', [System.Globalization.CultureInfo]::CurrentCulture)
    
    
    $dirName = $month + $year
    $dirPath = "C:\Users\pradi\Desktop\notes\self\" + $dirName
    $fileName = $date + $month + ".txt"

    cd $dirPath

    ls
    vv $fileName
}


function Get-Calendar($monthName = (Get-Date).Month, $year = (Get-Date).Year) {
    $monthMap = @{
        "jan" = 1; "feb" = 2; "mar" = 3; "apr" = 4; "may" = 5; "jun" = 6;
        "jul" = 7; "aug" = 8; "sep" = 9; "oct" = 10; "nov" = 11; "dec" = 12
    }

    if ($monthName -is [int]) {
        if (($monthName - 12) -gt 0 -or ($monthName - 1) -lt 0) {
            Write-Error "Invalid month name. Please use a valid valid month number (1-12). You can also use month names (e.g. 'jan' for January)"
            return
        }
        $month = $monthName
    }
    else {
        if (!$monthMap.ContainsKey($monthName.ToLower())) {
            Write-Error "Invalid month name. Please use a valid month abbreviation (e.g., 'jan' for January). You can also use month numbers (e.g. 12 for December)"
            return
        }
        $month = $monthMap[$monthName.ToLower()]
    }

    $dtfi = New-Object System.Globalization.DateTimeFormatInfo
    $AbbreviatedDayNames = $dtfi.AbbreviatedDayNames | ForEach-Object { " {0}" -f $_.Substring(0, 2) }

    $header = "$($dtfi.MonthNames[$month-1]) $year"
    $header = (" " * ([math]::abs(21 - $header.length) / 2)) + $header
    $header += (" " * (21 - $header.length))

    Write-Host $header -BackgroundColor yellow -ForegroundColor black
    Write-Host (-join $AbbreviatedDayNames) -BackgroundColor cyan -ForegroundColor black
    $daysInMonth = [DateTime]::DaysInMonth($year, $month)

    $dayOfWeek = (New-Object DateTime $year, $month, 1).dayOfWeek.value__
    $today = (Get-Date).Day

    for ($i = 0; $i -lt $dayOfWeek; $i++) { Write-Host (" " * 3) -NoNewline }
    for ($i = 1; $i -le $daysInMonth; $i++) {
        if ($today -eq $i) { Write-Host ("{0,3}" -f $i) -NoNewline -BackgroundColor red -ForegroundColor white }
        else { Write-Host ("{0,3}" -f $i) -NoNewline -BackgroundColor white -ForegroundColor black }

        if ($dayOfWeek -eq 6) { Write-Host }
        $dayOfWeek = ($dayOfWeek + 1) % 7
    }
    if ($dayOfWeek -ne 0) { Write-Host }
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

# Clear-Host
Set-PSReadLineOption -PredictionViewStyle ListView
figlet Welcome ADI
init
tasks
