:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::          URL: https://ghost.im          ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enableextensions enabledelayedexpansion

:: Script settings
set EXE="DayZDiag_x64.exe"
set ARGS="-filePatching -window"
if "%1" == "production" (
	set EXE="DayZ_x64.exe"
	set ARGS="-window"
)

:: CD to batch script dir
cd /D "%~dp0"

call KillAll.bat

:: Load settings
if not exist ..\mod.cfg (
	echo Failed to find mod.cfg file.
	goto:ERROR
)
FOR /F "tokens=*" %%i in ('type ..\mod.cfg ^| findStr.exe "%1="') do SET %%i
:: / Load Settings

:: Mods
set mods=
if "%AdditionalSPMods%"=="" (
    set mods=%modName%
) else (
    set mods=%AdditionalSPMods%;%modName%
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

chdir /d "%GameDirectory%"

start "" %EXE% %ARGS:"=% -scrAllowFileWrite -config=serverDZ.cfg -dologs -adminlog -freezecheck -scriptDebug=true -cpuCount=4 -nosplash -noPause -noBenchmark "-mission=%SPMission%" "-mod=%modList%"

endlocal
goto:eof

:ERROR
endlocal
pause