# config-files
config files for my dev profile (nvim, git, vscode, et al.)

# PowerShell Shortcuts and Commands

Welcome to the PowerShell Shortcuts and Commands reference! This document provides a list of essential PowerShell commands for common tasks.

## Navigation

| Command                | Description                                    |
|------------------------|------------------------------------------------|
| `cd` or `Set-Location` | Change directory.                              |
| `ls` or `Get-ChildItem`| List the contents of a directory.              |
| `pwd` or `Get-Location` | Print the current directory path.              |
| `pushd` and `popd`      | Push and pop locations onto a stack.           |

## File System

| Command                | Description                              |
|------------------------|------------------------------------------|
| `cp` or `Copy-Item`    | Copy a file or directory.                |
| `mv` or `Move-Item`    | Move or rename a file or directory.      |
| `rm` or `Remove-Item`  | Remove a file or directory.              |
| `ni` or `New-Item`     | Create a new file or directory.          |

## Utilities

| Command                  | Description                                      |
|--------------------------|--------------------------------------------------|
| `clear` or `Clear-Host`  | Clear the console screen.                        |
| `cls`                    | An alias for `clear`.                             |
| `echo`                   | Display messages or turn on/off echoing of commands. |
| `help` or `Get-Help`    | Get help for commands.                            |
| `history` or `Get-History`| Display a list of commands in the session history. |

## Process Management

| Command                    | Description                                    |
|----------------------------|------------------------------------------------|
| `ps` or `Get-Process`      | List processes.                               |
| `kill` or `Stop-Process`   | Stop a running process.                       |
| `start` or `Start-Process` | Start a new process.                          |

## Directory Tree

- `Get-ChildItem | Tree`: Display a visual representation of the directory tree (requires the `tree` command from Windows Sysinternals).
