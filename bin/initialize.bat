::initialize
@echo off
installService.bat
startService.bat

for /f %%t in ('sendRequest.bat') do (if not "%%t"=="success" (echo 与升级助手服务端通信失败，请检查配置文件))
:end
pause
goto:eof