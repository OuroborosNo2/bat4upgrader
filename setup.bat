::setup
@echo off

::读取配置文件base_folder字段
for /f %%t in ('call bin/myUtils func_getPara base_folder') do (set base_folder=%%~ft)
if "%base_folder%"=="" (echo please input [base_folder] & goto:end)

::先创建文件夹，再批量移动，路径一定要加引号，否则特殊符号会导致出错
md "%base_folder%"
for /f  "delims=" %%t in ('dir/b') do (
    if not "%%t"=="setup.bat" (move "%%t" "%base_folder%")
)
md "%base_folder%\bin"
echo y | copy "bin" "%base_folder%\bin"
echo y | del bin

::initialize，安装并启动服务
cd /d "%base_folder%\bin"
call installService
call startService

::通知升级助手服务端
call sendRequest
::for /f %%t in ('call sendRequest') do (if not "%%t"=="success" (echo 与升级助手服务端通信失败，请检查配置文件))

:end

pause
goto:eof