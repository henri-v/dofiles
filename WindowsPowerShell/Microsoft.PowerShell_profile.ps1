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

	$git_toplevel = git rev-parse --show-toplevel
	if ($git_toplevel) {
		$repo_name = [System.IO.Path]::GetFileName($git_toplevel)
		$git_branch = git symbolic-ref --short HEAD |
			Select-TruncatedString -MaxLength 20
		$gitstr = "$repo_name($git_branch) "
	} else {
		$gitstr = ""
	}

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

	return "[$time] $gitstr$shortcwd$exitstatusstr$promptchars "
}
