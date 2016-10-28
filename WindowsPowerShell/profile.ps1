# PSReadLine options
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Ctrl+V -Function Paste
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+I -Function Complete

Update-FormatData -PrependPath $PSScriptRoot\FileSystem.format.ps1xml

function git-cdup {
	Set-Location -Path $(git rev-parse --show-cdup)
}
