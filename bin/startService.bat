::start service
@echo off
setlocal enabledelayedexpansion
::读配置文件，默认值写死在这里

::取服务名，默认为exe名
if not "%1"=="" (set service_name=%1) else (
    for /f %%t in ('call myUtils func_getPara service_name') do (set service_name=%%t)
    if "!service_name!"=="""" (
        ::取服务端启动程序地址
        for /f %%t in ('call myUtils func_getPara server_app') do (set server_app=%%t)
        if "!server_app!"=="""" (echo please input [server_app] and [service_name] & goto:end)
        for /f %%t in ("!server_app!") do (set service_name=%%~nt)
    )
)

::取系统位数
for /f %%t in ('call myUtils func_getPara is_x86_32') do (set is_x86_32=%%t)
if not "%is_x86_32%"=="true" (set is_x86_32=false)

if "%is_x86_32%"=="false" (nssm-2.24\win64\nssm start "%service_name%"
) else (nssm-2.24\win32\nssm start "%service_name%")
goto:eof

:end
::没全部执行成功就暂停查看
pause
endlocal
goto:eof