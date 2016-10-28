$isAdmin = (New-Object System.Security.Principal.WindowsPrincipal(
	[System.Security.Principal.WindowsIdentity]::GetCurrent())).
	IsInRole("Administrators")

function prompt {
	# The following should probably be first so that the latter commands
	# won't trash its results.
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

	$curdir = $executionContext.SessionState.Path.CurrentLocation.Path
	$shortcwd = `
		if ($curdir -eq $env:USERPROFILE) { "~" }
		elseif ($curdir -match "^[^:\\/]+:\\$") { $curdir }
		else {
			$curdir.Split("\") |
				Where-Object { -not ($_ -eq "") } |
				Select-Object -Last 1
		}

	$promptchar = if ($isAdmin) { "#" } else { ">" }
	$promptchars = $promptchar * ($nestedPromptLevel + 1)

	$host.UI.RawUI.WindowTitle = "${env:COMPUTERNAME}: $shortcwd"

	return "[$time] $shortcwd$exitstatusstr$promptchars "
}
