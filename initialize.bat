::initialize
@echo off
::获取管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d %~dp0

call installService.bat
call importSql.bat
call startService.bat
call startSingletonNginx.bat

:end
echo 初始化成功，服务部署完成并自动启动
pause
goto:eof