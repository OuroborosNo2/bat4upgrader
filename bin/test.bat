::install service
@echo off

for /f %%t in ('call myUtils func_getPara service_description') do (echo %%t)

::setlocal enabledelayedexpansion

:end
::endlocal
pause
goto:eof