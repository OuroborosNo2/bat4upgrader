::uninstall service
@echo off
::获取管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~f0 ::","","runas",1)(window.close)&&exit
cd /d %~dp0

setlocal enabledelayedexpansion

for /f %%t in ('call myUtils func_getPara service_name') do (set service_name=%%t)
if "!service_name!"=="""" (
    for /f %%t in ('call myUtils func_getPara server_app') do (set server_app=%%~nxt)
    if "!server_app!"=="""" (echo please input [server_app] and [service_name] & goto:end)
    for /f %%t in ("!server_app!") do (set service_name=%%~nt)
)



for /f %%t in ('call myUtils func_getPara is_x86_32') do (set is_x86_32=%%t)
if not "%is_x86_32%"=="true" (set is_x86_32=false)

::先停服务
if "%is_x86_32%"=="false" (nssm-2.24\win64\nssm stop "%service_name%"
) else (nssm-2.24\win32\nssm stop "%service_name%")

call ..\nginx\stop-nginx.bat

::再用vbs调用nssm 移除服务
echo dim Wshell > uninstallService.vbs
echo set Wshell=CreateObject("WScript.Shell") >> uninstallService.vbs
if "%is_x86_32%"=="false" (echo Wshell.Run "nssm-2.24\win64\nssm remove !service_name!" >> uninstallService.vbs) else (echo Wshell.Run "nssm-2.24\win32\nssm remove !service_name!" >> uninstallService.vbs)
echo wscript.sleep 500 >> uninstallService.vbs
echo Wshell.SendKeys "{ENTER}" >> uninstallService.vbs
echo Wshell.SendKeys "{ENTER}" >> uninstallService.vbs
uninstallService.vbs
del uninstallService.vbs


:end
endlocal
goto:eof