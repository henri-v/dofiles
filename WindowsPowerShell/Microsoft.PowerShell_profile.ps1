if (Get-Module -ListAvailable posh-git) { Import-Module posh-git }

$isAdmin = (New-Object System.Security.Principal.WindowsPrincipal(
	[System.Security.Principal.WindowsIdentity]::GetCurrent())).
	IsInRole("Administrators")

function prompt {
	# The following should probably be first so that the latter commands
	# won't trash $?
	$exitstatusstr = if ($?) { "" } else {
		# If we haven't run any external executables yet, LASTEXITCODE
		# does not seem to exist yet.
		 if (Test-Path variable:LASTEXITCODE) {
			" " + $LASTEXITCODE.ToString()
		} else {
			" E"
		}
	}

	$time = (Get-Date -DisplayHint Time).DateTime

	$curloc = $executionContext.SessionState.Path.CurrentLocation

	$git_toplevel =
		if ($curloc.Provider.Name -eq "FileSystem")
		{ git rev-parse --show-toplevel } else { $null }

	if ($git_toplevel) {
		$repo_name = [System.IO.Path]::GetFileName($git_toplevel)
		$git_branch = git symbolic-ref -q --short HEAD |
			Select-TruncatedString -MaxLength 20
		if (-not $git_branch) {
			$git_branch = git rev-parse --short HEAD
		}
		$gitstr = "$repo_name($git_branch) "
	} else {
		$gitstr = ""
	}

	$drive = $curloc.Drive.Name
	$shortcwd = switch ($curloc.Path) {
		$curloc.Provider.Home { "~" }
		($drive + ":\") { "\" }
		default {
			$curloc.Path.Split("\") | Where-Object { $_ -ne "" } |
				Select-Object -Last 1
		}
	}

	$promptchar = if ($isAdmin) { "#" } else { ">" }
	$promptchars = $promptchar * ($nestedPromptLevel + 1)

	$host.UI.RawUI.WindowTitle = "${env:COMPUTERNAME}: ${drive}:$shortcwd"

	return "[$time] $gitstr${drive}:$shortcwd$exitstatusstr$promptchars "
}
