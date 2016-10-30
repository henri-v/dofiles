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

filter Select-TruncatedString($MaxLength=15) {
	if ($_.Length -le $MaxLength) {
		$_
	} elseif ($MaxLength -gt 3) {
		$_.Substring(0, $MaxLength - 3) + "..."
	} else {
		"...".Substring(0, $MaxLength)
	}
}
