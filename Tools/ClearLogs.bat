:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::  URL: https://github.com/ghostiam-DayZ  ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off

:: CD to batch script dir
cd /D "%~dp0"

CALL KillAll.bat

:: Load settings
if not exist ..\mod.cfg (
	echo Failed to find mod.cfg file.
	goto:ERROR
)
FOR /F "tokens=*" %%i in ('type ..\mod.cfg ^| findStr.exe "%1="') do SET %%i
:: / Load Settings

:: Check
if "%GameDirectory%" == "" (
	echo Failed to find GameDirectory in mod.cfg file.
	goto:ERROR
)
if "%ServerDirectory%" == "" (
	echo Failed to find ServerDirectory in mod.cfg file.
	goto:ERROR
)

:: Work
del /s /q /f "%ServerDirectory%\%ServerProfileDirectory%\*.rpt"
del /s /q /f "%ServerDirectory%\%ServerProfileDirectory%\*.log"
del /s /q /f "%ServerDirectory%\%ServerProfileDirectory%\*.mdmp"
del /s /q /f "%ServerDirectory%\%ServerProfileDirectory%\*.ADM"

del /s /q /f "%localappdata%\DayZ\*.rpt"
del /s /q /f "%localappdata%\DayZ\*.log"
del /s /q /f "%localappdata%\DayZ\*.mdmp"
del /s /q /f "%localappdata%\DayZ\*.ADM"

endlocal
goto:eof

:ERROR
endlocal
pause