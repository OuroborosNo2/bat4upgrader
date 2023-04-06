@echo off
cd %~dp0
set SHORTCUT=%USERPROFILE%\Desktop\Launch.url
set TARGET="..\Launch.exe"
for /f %%t in ("%TARGET%") do (set TARGET=%%~ft)
set ICON="..\Launch.exe"
for /f %%t in ("%ICON%") do (set ICON=%%~ft)
set WORKING_DIR="..\"
for /f %%t in ("%WORKING_DIR%") do (set WORKING_DIR=%%~ft)
::set DESC="Calculator"
::for /f %%t in ("%DESC%") do (set DESC="%%~ft")

echo [InternetShortcut] >> %SHORTCUT%
echo URL="file:///%TARGET%" >> %SHORTCUT%
echo IconIndex=0 >> %SHORTCUT%
echo IconFile=%ICON% >> %SHORTCUT%
::echo Description=%DESC% >>%SHORTCUT%

start %SHORTCUT%