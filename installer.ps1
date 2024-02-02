# Function to clone a Git repository with error handling
function Clone-Repository {
    param (
        [string]$RepoUrl,
        [string]$TargetDir
    )

    Write-Host "Cloning $RepoUrl to $TargetDir..."
    try {
        git clone $RepoUrl $TargetDir
        Write-Host "Clone successful."
    } catch {
        Write-Host "Error: Could not clone $RepoUrl to $TargetDir."
        exit 1
    }
}

# Main script
$configRepo = "https://github.com/adimail/config-files.git"
$nvimConfig = "$env:LOCALAPPDATA\nvim"
$ConfigRepo = "https://github.com/Alexis12119/nvim-config.git"
$ConfigPlugins = "$env:LOCALAPPDATA\nvim-data\lazy"

# Check if a Neovim configuration already exists
if (Test-Path -Path $NvChadConfig) {
    Write-Host "A Neovim configuration already exists at $NvChadConfig."
    $confirmReplace = Read-Host "Do you want to replace it with the new configuration? [Y/N]"
    if ($confirmReplace -eq "Y" -or $confirmReplace -eq "y") {
        $confirmRemovePlugins = Read-Host "Do you want to remove the existing plugins as well? [Y/N]"
        if ($confirmRemovePlugins -eq "Y" -or $confirmRemovePlugins -eq "y") {
            Write-Host "Removing the existing plugins..."
            Remove-Item $ConfigPlugins -Recurse -Force
        }

        Write-Host "Removing the existing configuration..."
        Remove-Item $NvChadConfig -Recurse -Force
    } else {
        Write-Host "Installation cancelled."
        return
    }
}

# Clone the Git repositories
Clone-Repository -RepoUrl $NvChadRepo -TargetDir $NvChadConfig
Clone-Repository -RepoUrl $ConfigRepo -TargetDir "$NvChadConfig\lua\custom"
nvim

Write-Host "Installation complete. Your Neovim configuration is now set up."




# Clone the repository with a depth of 1 and sparse-checkout
git clone --depth 1 --filter=blob:none --sparse https://github.com/adimail/config-files.git nvim

# Change into the cloned directory
cd nvim

# Enable sparse-checkout and include only the "nvim" subdirectory
git sparse-checkout init --cone
git sparse-checkout set nvim



# Clone the repository with a depth of 1 and sparse-checkout
git clone --depth 1 --filter=blob:none --sparse https://github.com/adimail/config-files.git

# Change into the cloned directory
cd config-files

# Enable sparse-checkout and include only specific files from the "nvim" subdirectory
git sparse-checkout init --cone
git sparse-checkout set nvim/lua

