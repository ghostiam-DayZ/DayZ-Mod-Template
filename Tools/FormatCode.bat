:::::::::::::::::::::::::::::::::::::::::::::
::                                         ::
::            Author: GhostIAm             ::
::  URL: https://github.com/ghostiam-DayZ  ::
::                                         ::
:::::::::::::::::::::::::::::::::::::::::::::

@echo off

:: CD to batch script dir
cd /D "%~dp0"

AStyle.exe --recursive --style=google --indent-switches --add-braces --unpad-paren --lineend=windows --suffix=none --break-after-logical ..\*.c ..\*.cpp
