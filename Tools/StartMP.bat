:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::  URL: https://github.com/ghostiam-DayZ  ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off
cd /D "%~dp0"

call KillAll.bat

call StartServer.bat

TIMEOUT /T 10 /NOBREAK

call StartClient.bat