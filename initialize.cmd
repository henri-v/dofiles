@echo off
setlocal

if not "%~1"=="" goto %1

:help
echo Usage: %0 [all^|^<section^>]
goto :eof

:all
call :git
call :vim
call :powershell
goto :eof

:git
git config --global user.name "Henri Vettenranta"
git config --global user.email heto88@gmail.com
git config --global core.editor "cmd //c \"gvim -f\""
git config --global core.excludesfile "%~dp0gitexcludes"
goto :eof

:vim
if exist "%UserProfile%\_vimrc" (
	echo %UserProfile%\_vimrc exists - not setting up vim >&2
	goto :eof
)
if exist "%UserProfile%\_gvimrc" (
	echo %UserProfile%\_gvimrc exists - not setting up vim >&2
	goto :eof
)
goto vim_force

:vim_force
rem Have to use short names for runtimepath so that we can be sure it does not
rem contain spaces.
echo set runtimepath^^=%~sdp0vimfiles runtimepath+=%~sdp0vimfiles\after ^
	>"%UserProfile%\_vimrc"
rem Spaces seem to be fine with the source command.
echo source %~dp0vimfiles\vimrc >>"%UserProfile%\_vimrc"

echo source %~dp0vimfiles\gvimrc >"%UserProfile%\_gvimrc"

goto :eof

:powershell
mklink /j "%USERPROFILE%\Documents\WindowsPowerShell" "%~dp0WindowsPowerShell"

goto :eof
