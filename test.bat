::install service
@echo off
::获取管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~f0 ::","","runas",1)(window.close)&&exit
cd /d %~dp0

::call startSingletonNginx.bat

::curl "http://%ip_address%:%port%/bat/update/%softwareName%/%version%/%softwareType%"

::for /f %%t in ('call myUtils func_getPara service_description') do (echo %%t)

::for /f %%t in ('call myUtils func_getPara service_stdin') do (set service_stdin=%%t)
::echo %service_stdin%

::setlocal enabledelayedexpansion

:end
::endlocal
pause
goto:eof