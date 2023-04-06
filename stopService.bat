::stop service
@echo off
::获取管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d %~dp0

setlocal enabledelayedexpansion

    for /f %%t in ('call myUtils func_getPara service_name') do (set service_name=%%t)
    if "!service_name!"=="""" (
        for /f %%t in ('call myUtils func_getPara server_app') do (set server_app=%%t)
        if "!server_app!"=="""" (echo please input [server_app] and [service_name] & goto:end)
        for /f %%t in ("!server_app!") do (set service_name=%%~nt)
    )


for /f %%t in ('call myUtils func_getPara is_x86_32') do (set is_x86_32=%%t)
if not "%is_x86_32%"=="true" (set is_x86_32=false)

if "%is_x86_32%"=="false" (nssm-2.24\win64\nssm stop "%service_name%"
) else (nssm-2.24\win32\nssm stop "%service_name%")
goto:eof

:end
::没有全部运行成功则暂停
pause
endlocal
goto:eof