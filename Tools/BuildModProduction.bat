:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::          URL: https://ghost.im          ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enableextensions enabledelayedexpansion

cd /D "%~dp0"

:: Load settings
if not exist ..\mod.cfg (
	echo Failed to find mod.cfg file.
	goto:ERROR
)
FOR /F "tokens=*" %%i in ('type ..\mod.cfg ^| findStr.exe "%1="') do SET %%i
:: / Load Settings

call BuildMod.bat production
endlocal