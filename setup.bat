::setup
@echo off

::读取配置文件base_folder字段
for /f %%t in ('call bin/myUtils func_getPara base_folder') do (set base_folder=%%~ft)
if "%base_folder%"=="""" (echo please input [base_folder] & goto:end)
::遇到&,等号需要转义，并且顺序不能错！等号转义难，先转井号再换转义符,cmd的转义符是^,并且要把转义符本身添加到变量里，这样执行命令时才不会受影响
set base_folder=%base_folder:&=SPECIAL_AND%
    set CURSTR=%base_folder%
    set RESULT=
    :cicleNext
    if "%CURSTR%" equ "" goto cicleEnd
    set a=%CURSTR:~0,1%
    if "%a%" equ "=" (set RESULT=%RESULT%SPECIAL_EQUATION) else (set RESULT=%RESULT%%a%)
    set CURSTR=%CURSTR:~1%
    goto cicleNext
    :cicleEnd
set base_folder=%RESULT:SPECIAL_EQUATION=^^^=%
set base_folder=%base_folder:SPECIAL_AND=^^^&%
echo %base_folder%

::echo %base_folder%

::先创建文件夹，再批量移动
md %base_folder%
for /f %%t in ('dir/b') do (
    if not "%%t"=="setup.bat" (move %%t %base_folder%)
)

::initialize，安装并启动服务
cd %base_folder%\bin
call installService
call startService

::通知升级助手服务端
for /f %%t in ('call sendRequest') do (if not "%%t"=="success" (echo 与升级助手服务端通信失败，请检查配置文件))

:end

pause
goto:eof