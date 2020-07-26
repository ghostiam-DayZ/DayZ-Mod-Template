:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::          URL: https://ghost.im          ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off
setlocal enableextensions enabledelayedexpansion

set ARGS="-packonly"
if "%1" == "production" (
	set ARGS=""
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

:: Check
if "%ModBuildDirectory%" == "" (
	echo Failed to find ModBuildDirectory in mod.cfg file.
	goto:ERROR
)
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
if "%ToolsDirectory%" == "" (
	echo Failed to find ToolsDirectory in mod.cfg file.
	goto:ERROR
)

:: Work
@echo on

set builder="%ToolsDirectory%\Bin\AddonBuilder\AddonBuilder.exe"

IF exist "%ModBuildDirectory%%ModName%\" (
	echo Removing folder "%ModBuildDirectory%%ModName%\"
	rmdir /S /Q "%ModBuildDirectory%%ModName%\"
)

IF NOT exist "%ModBuildDirectory%%ModName%\" (
	echo Creating folder "%ModBuildDirectory%%ModName%\"
	mkdir "%ModBuildDirectory%%ModName%\"
)

IF NOT exist "%ModBuildDirectory%%ModName%\Keys\" (
	echo Creating folder "%ModBuildDirectory%%ModName%\Keys\"
	mkdir "%ModBuildDirectory%%ModName%\Keys\"
)

IF NOT exist "%ModBuildDirectory%%ModName%\Addons\" (
	echo Creating folder "%ModBuildDirectory%%ModName%\Addons\"
	mkdir "%ModBuildDirectory%%ModName%\Addons\"
)

echo Copying over "%KeyDirectory%\%keyName%.bikey" to "%ModBuildDirectory%%ModName%\Keys\"
copy "%KeyDirectory%\%keyName%.bikey" "%ModBuildDirectory%%ModName%\Keys\" > nul

echo Packaging %ModName% PBO's

@echo off

IF EXIST "%workDrive%%Prefix%\%ModName%\config.cpp" (
	%builder% "%workDrive%%Prefix%\%ModName%" "%modBuildDirectory%%modName%\Addons" -binarizeFullLogs  -clear -sign="%keyDirectory%%keyName%.biprivatekey" -prefix="%Prefix%\%ModName%" -include="..\build_include.txt" %ARGS:"=%
) ELSE (
	for /f "tokens=*" %%D in ('dir /b /s "%workDrive%%Prefix%\%ModName%\*"') do (
		IF EXIST "%%~fD\config.cpp" (
			IF NOT EXIST "%%~fD\..\config.cpp" (
				IF NOT EXIST "%%~fD\..\..\config.cpp" (
					IF NOT EXIST "%%~fD\..\..\..\config.cpp" (
						IF NOT EXIST "%%~fD\..\..\..\..\config.cpp" (
							IF NOT EXIST "%%~fD\..\..\..\..\..\config.cpp" (
								IF NOT EXIST "%%~fD\..\..\..\..\..\..\config.cpp" (
									set pboNameBase=%%~pnD
									set pboName=!pboNameBase:\%Prefix%\%ModName%\=!
									set pboName=!pboName:\=_!

									%builder% "%%~dpnxD" "%ModBuildDirectory%%ModName%\Addons" -binarizeFullLogs  -clear -sign="%keyDirectory%%keyName%.biprivatekey" -prefix="!pboNameBase:\%Prefix%=%Prefix%!" -include="..\build_include.txt" %ARGS:"=%
								)
							)
						)
					)
				)
			)
		)
	)
)

endlocal
TIMEOUT /T 5 /NOBREAK
goto:eof

:ERROR
endlocal
pause