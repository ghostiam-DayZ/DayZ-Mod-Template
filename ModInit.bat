:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::          URL: https://ghost.im          ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enableextensions enabledelayedexpansion

:: CD to batch script dir
cd /D "%~dp0"

:: Load settings
if not exist mod.cfg (
	echo Failed to find mod.cfg file.
	goto:ERROR
)
FOR /F "tokens=*" %%i in ('type mod.cfg ^| findStr.exe "%1="') do SET %%i
:: / Load Settings

:: Check
if "%WorkDrive%" == "" (
	echo Failed to find WorkDrive in mod.cfg file.
	goto:ERROR
)
if "%Prefix%" == "" (
	echo Failed to find Prefix in mod.cfg file.
	goto:ERROR
)
if "%ModName%" == "" (
	echo Failed to find ModName in mod.cfg file.
	goto:ERROR
)
if "%GameDirectory%" == "" (
	echo Failed to find GameDirectory in mod.cfg file.
	goto:ERROR
)
if "%ServerDirectory%" == "" (
	echo Failed to find ServerDirectory in mod.cfg file.
	goto:ERROR
)
if "%ToolsDirectory%" == "" (
	echo Failed to find ToolsDirectory in mod.cfg file.
	goto:ERROR
)

:: Work
IF NOT exist "%WorkDrive%\%Prefix%\" (
	echo Creating folder %WorkDrive%\%Prefix%
	mkdir "%WorkDrive%\%Prefix%"
)

IF exist "%WorkDrive%\%Prefix%\%ModName%\" (
	echo Removing existing link %WorkDrive%\%Prefix%\%ModName%
	rmdir "%WorkDrive%\%Prefix%\%ModName%\"
)

IF exist "%GameDirectory%\%Prefix%\" (
	echo "Removing existing link %GameDirectory%\%Prefix%"
	rmdir "%GameDirectory%\%Prefix%\"
)

IF exist "%ServerDirectory%\%Prefix%\" (
	echo "Removing existing link %ServerDirectory%\%Prefix%"
	rmdir "%ServerDirectory%\%Prefix%\"
)


echo Creating links...
mklink /J "%WorkDrive%\%Prefix%\%ModName%\" "%cd%\Mod\%Prefix%\%ModName%\"
mklink /J "%GameDirectory%\%Prefix%\" "P:\%Prefix%\"
mklink /J "%ServerDirectory%\%Prefix%\" "P:\%Prefix%\"

echo Copy Diag Server
copy "%GameDirectory%\DayZDiag_x64.exe" "%ServerDirectory%\DayZDiag_x64.exe"

:: Generate project
if "%WorkDrive:~-1,1%" == "\" (
	set WorkDrive=%WorkDrive:~0,-1%
)

DEL Tools\Workbench\dayz.gproj >NUL  2>NUL
For /f "tokens=* delims= " %%a in (Tools\Workbench\dayz.gproj.template) do (
	set str=%%a
	set str=!str:{{GameRoot}}=%WorkDrive%!
	set str=!str:{{pluginDir}}=%CD%\Tools\Workbench\plugins!
	echo.!str!>>Tools\Workbench\dayz.gproj
)

echo Copying "%cd%\Tools\Workbench\dayz.gproj" to "%ToolsDirectory%\Bin\Workbench\dayz.gproj"
copy "%cd%\Tools\Workbench\dayz.gproj" "%ToolsDirectory%\Bin\Workbench\dayz.gproj"
echo Copying "%cd%\Workbench\dayz.gproj" to "%GameDirectory%dayz.gproj"
copy "%cd%\Tools\Workbench\dayz.gproj" "%GameDirectory%dayz.gproj"
echo Copying "%cd%\Workbench\dayz.gproj" to "%ServerDirectory%dayz.gproj"
copy "%cd%\Tools\Workbench\dayz.gproj" "%ServerDirectory%dayz.gproj"

endlocal
TIMEOUT /T 5 /NOBREAK
goto:eof

:ERROR
endlocal
pause