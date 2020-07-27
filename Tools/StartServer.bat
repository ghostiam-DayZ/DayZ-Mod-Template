:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::  URL: https://github.com/ghostiam-DayZ  ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enableextensions enabledelayedexpansion

:: Script settings
set EXE="DayZDiag_x64.exe"
set ARGS="-filePatching -server"
if "%1" == "production" (
	set EXE="DayZServer_x64.exe"
	set ARGS="-server"
)

:: CD to batch script dir
cd /D "%~dp0"

:: Load settings
if not exist ..\mod.cfg (
	echo Failed to find mod.cfg file.
	goto:ERROR
)
FOR /F "tokens=*" %%i in ('type ..\mod.cfg ^| findStr.exe "%1="') do SET %%i
:: / Load Settings

:: Mods
set mods=
if "%AdditionalMPMods%"=="" (
    set mods=%modName%
) else (
    set mods=%AdditionalMPMods%;%modName%
)
for %%a in ("%mods:;=" "%") do (
    set mod=%%~a
	set modDir=%ModBuildDirectory%

	:: Set empty mod dir if mod contain path
	echo !mod! | findstr /C:"\\">nul && (
		set modDir=""
	)
	
	:: Set Workshop dir if mod contain @
	echo !mod! | findstr /C:"@">nul && (
		set modDir="%GameDirectory%^^^!Workshop\"
	)
	
	:: Trim quotes
	set modDir=!modDir:"=!
	
	:: Append
    if not defined modList (
        set modList=!modDir!!mod!
    ) else (
        set modList=!modList!;!modDir!!mod!
    )
)

cd /D "%ServerDirectory%"

start "" %EXE% %ARGS:"=% -scrAllowFileWrite -config=serverDZ.cfg -dologs -adminlog -freezecheck -scriptDebug=true -cpuCount=4 -nosplash -noPause -noBenchmark -port=%ServerPort% "-profiles=%ServerProfileDirectory%"  "-mission=%MPMission%" "-mod=%modList%"

endlocal
goto:eof

:ERROR
endlocal
pause