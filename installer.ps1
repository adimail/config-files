function Install-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is not installed. Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
}

function Install-Git {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Git is not installed. Installing Git..."
        install-chocolaty
        choco install git -y
    }
}

function Install-Neovim {
    if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
        Write-Host "Neovim is not installed. Installing Neovim..."
        install-chocolaty
        choco install neovim -y
    }
}

# Check if Git and Neovim are installed
Install-Git
Install-Neovim

# Define variables
$configFilesRepo = "https://github.com/adimail/config-files.git"
$nvimConfig = "$env:LOCALAPPDATA\nvim"
$ConfigPlugins = "$env:LOCALAPPDATA\nvim-data"

# Function to remove Neovim plugins
function Remove-Nvim-Plugins {
    if (Test-Path -Path $ConfigPlugins) {
        Write-Host "Removing the existing plugins..."
        try {
            Remove-Item $ConfigPlugins -Recurse -Force -ErrorAction Stop
        } catch {
            Write-Host "Error removing plugins: $_"
            return $false
        }
    }
    return $true
}

# Check if Neovim configuration already exists
if (Test-Path -Path $nvimConfig) {
    Write-Host "A Neovim configuration already exists at $nvimConfig."
    $confirmReplace = Read-Host "Do you want to replace it with the new configuration? [Y/N]"

    if ($confirmReplace -eq "Y" -or $confirmReplace -eq "y") {
        # Remove existing plugins
        if (-not (Remove-Nvim-Plugins)) {
            Write-Host "Installation cancelled due to plugin removal error."
            return
        }

        Write-Host "Removing the existing configuration..."
        try {
            Remove-Item $nvimConfig -Recurse -Force -ErrorAction Stop
            cd $env:LOCALAPPDATA
        } catch {
            Write-Host "Error removing configuration: $_"
            return
        }
    } else {
        Write-Host "Installation cancelled."
        return
    }
} else {
    cd $env:LOCALAPPDATA
}

try {
    git clone --depth 1 --no-checkout $configFilesRepo nvim
    cd nvim
    git sparse-checkout set nvim
    git checkout

    Remove-Item -Path .git, .gitignore, LICENSE, installer.ps1 -Recurse -Force
    Move-Item -Path nvim/init.lua, nvim/lua, nvim/lazy-lock.json -Destination .
    
    nvim
} catch {
    Write-Host "Error during configuration setup: $_"
}
