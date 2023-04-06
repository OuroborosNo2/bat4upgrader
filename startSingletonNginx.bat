::startSingletonNginx
::windows下不同目录的nginx可以同时运行，这个程序是为了保证此目录下的nginx能够运行
@echo off

setlocal enabledelayedexpansion

set nginx_path="..\nginx"
::nginx\logs下存在pid文件可以定位此目录的nginx
set pid_file=
for /f %%t in ("%nginx_path%") do (set pid_file="%%~ft\logs\nginx.pid")
::nginx.conf
set config_path=
for /f %%t in ("%nginx_path%") do (set config_path="%%~ft\conf\nginx.conf")

cd /d %nginx_path%

if exist %pid_file% (
    set /p pid=<%pid_file%
    for /f %%t in ('tasklist /fi "PID eq !pid!" /nh') do (
        if "%%t"=="nginx.exe" (
            nginx -c %config_path% -s reload
            echo Reloading Nginx...
            goto:eof
        )
    )
)


echo Starting Nginx...
::/B：后台运行，不显示命令行窗口
start /B nginx -c %config_path%
goto:eof

:end
endlocal
pause
goto:eof

