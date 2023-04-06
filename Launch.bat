@echo off
::管理员权限是个很复杂的问题，一种是在快捷方式上设置获取管理员权限，这会弹窗；
::另一种就是用命令获取，但这衍生了非常多问题，如路径更改、路径短名、打开新窗口让原窗口结束……
::但是服务操作必须要管理员权限

::获取管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~f0 ::","","runas",1)(window.close)&&exit
cd /d %~dp0

setlocal enabledelayedexpansion

::先检查mysql有没有打开，没的话会跳过for循环
for /f "delims=" %%t in ('tasklist ^| findstr mysqld') do (
    goto:continue
)
echo 请检查mysql，可能的原因是mysql服务未启动
goto:end

:continue
del log.txt 2>nul
call startService.bat
set /p log=< log.txt
::如果服务没安装说明还没初始化，先初始化
if "%log%"=="Service hasn't been installed" (
    ::不能无脑执行这个导入，因为会修改数据
    for /f "delims=" %%t in ('call importSql.bat') do (
        ::sql成功导入时没有输出，其他情况会有输出，不用if判断也行
        echo %%t
        echo 请检查mysql，可能的原因是mysql服务未启动或密码不正确
        goto:end
    )
    call installService.bat
    call startService.bat
)

call startSingletonNginx.bat
echo "启动成功！"
pause
start "" http://localhost:8083/upgrader/#/dlzc/login
goto:eof

:end
::没全部执行成功就暂停查看
pause
endlocal
goto:eof