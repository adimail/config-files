#Alises
set-Alias tt tree
set-Alias ll ls
set-Alias g git
set-Alias vv nvim


#prompt
oh-my-posh init pwsh --config 'C:\Users\pradi\Documents\devprofile\OMP-custom-theme.omp.json' | Invoke-Expression



#Functions
function whereis ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
	Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

#Default module imports
Import-Module Terminal-Icons

Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -PredictionViewStyle ListView
