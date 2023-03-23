::stop service
@echo off
setlocal enabledelayedexpansion

if not "%1"=="" (set service_name=%1) else (
    for /f %%t in ('call myUtils func_getPara service_name') do (set service_name=%%t)
    if "!service_name!"=="" (
        for /f %%t in ('call myUtils func_getPara server_app') do (set server_app=%%t)
        if "!server_app!"=="" (echo please input [server_app] and [service_name] & goto:end)
        for /f %%t in ("!server_app!") do (set service_name=%%~nt)
    )
)

for /f %%t in ('call myUtils func_getPara is_x86_32') do (set is_x86_32=%%t)
if "%is_x86_32%"=="" (set is_x86_32=false)

if "%is_x86_32%"=="false" (nssm-2.24\win64\nssm stop "%service_name%"
) else (nssm-2.24\win32\nssm stop "%service_name%")
goto:eof

:end
::没全部执行成功就暂停查看
pause
endlocal
goto:eof