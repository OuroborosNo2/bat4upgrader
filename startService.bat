::start service
@echo off

setlocal enabledelayedexpansion
::读配置文件，默认值写死在这里

::取服务名，默认为exe名

    for /f %%t in ('call myUtils func_getPara service_name') do (set service_name=%%t)
    if "!service_name!"=="""" (
        ::取服务端启动程序地址
        for /f %%t in ('call myUtils func_getPara server_app') do (set server_app=%%t)
        if "!server_app!"=="""" (echo please input [server_app] and [service_name] & goto:end)
        for /f %%t in ("!server_app!") do (set service_name=%%~nt)
    )


::取系统位数
for /f %%t in ('call myUtils func_getPara is_x86_32') do (set is_x86_32=%%t)
::if not "%is_x86_32%"=="true" (set is_x86_32=false)
if not "%is_x86_32%"=="true" (set command=nssm-2.24\win64\nssm start "%service_name%"
) else (set command=nssm-2.24\win32\nssm start "%service_name%")

::这个报错的输出只有第一行是正常的，第二行是乱码，很麻烦。并且在命令行中是正确显示的，在这里只能获取到第一个字母
for /f %%i in ('!command! 2^>^&1') do (
    if "%%i"=="C" (echo Service hasn't been installed>log.txt) else (echo Service started>log.txt)
)
goto:eof

:end
::没全部执行成功就暂停查看
pause
endlocal
goto:eof