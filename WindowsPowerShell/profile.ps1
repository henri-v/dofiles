# PSReadLine options
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Ctrl+V -Function Paste
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+I -Function Complete

Set-PSReadlineOption -HistorySearchCursorMovesToEnd

function Format-PrettyLength([long]$Length) {
	$Units = @("B", "K", "M", "G", "T", "P", "E")
	$threshold = 1.5kb
	[double]$lengthInUnit = $Length
	$unit = 0
	while (($unit + 1) -lt $Units.Length -and $lengthInUnit -gt $threshold) {
		++$Unit
		$lengthInUnit /= 1kb
	}
	if ($unit -gt 0 -and $lengthInUnit -lt 10) {
		"{0:f1}{1}" -f $lengthInUnit, $Units[$unit]
	} else {
		"{0:f0}{1}" -f $lengthInUnit, $Units[$unit]
	}
}

Update-FormatData -PrependPath $PSScriptRoot\FileSystem.format.ps1xml

if (Get-Module -Name Pscx -ListAvailable) {
	Import-Module Pscx -arg $PSScriptRoot\Pscx.UserPreferences.ps1
}

function git-cdup {
	Set-Location -Path $(git rev-parse --show-cdup)
}

function lsrf([Parameter(Position=0)]$Filter) {
	# TODO @args does not work yet
	Get-ChildItem -File -Recurse -Filter $Filter @args
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
