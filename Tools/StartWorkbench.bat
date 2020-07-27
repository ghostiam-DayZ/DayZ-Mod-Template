:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::  URL: https://github.com/ghostiam-DayZ  ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enableextensions enabledelayedexpansion

:: Script settings
set ARGS="-filePatching"

:: CD to batch script dir
cd /D "%~dp0"

:: Load settings
if not exist ..\mod.cfg (
	echo Failed to find mod.cfg file.
	goto:ERROR
)
FOR /F "tokens=*" %%i in ('type ..\mod.cfg ^| findStr.exe "%1="') do SET %%i
:: / Load Settings

:: Generate project
set wd=%WorkDrive%
if "%WorkDrive:~-1,1%" == "\" (
	set wd=%WorkDrive:~0,-1%
)

DEL Workbench\dayz.gproj >NUL  2>NUL
For /f "tokens=* delims= " %%a in (Workbench\dayz.gproj.template) do (
	set str=%%a
	set str=!str:{{GameRoot}}=%wd%!
	set str=!str:{{pluginDir}}=%CD%\Workbench\plugins!
	echo.!str!>>Workbench\dayz.gproj
)

:: Mods
set mods=
if "%AdditionalWorkbenchMods%"=="" (
    set mods=%wd%\%Prefix%\%ModName%
) else (
    set mods=%AdditionalWorkbenchMods%;%modName%
)
for %%a in ("%mods:;=" "%") do (
    set mod=%%~a
	set modDir=%wd%\%Prefix%\%ModName%\

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

chdir /D "%ToolsDirectory%\Bin\Workbench\"
start workbenchApp.exe -gproj=%~dp0Workbench\dayz.gproj "-mod=%modList%"

endlocal
goto:eof

:ERROR
endlocal
pause