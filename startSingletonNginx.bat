::startSingletonNginx
::windows�²�ͬĿ¼��nginx����ͬʱ���У����������Ϊ�˱�֤��Ŀ¼�µ�nginx�ܹ�����
@echo off

setlocal enabledelayedexpansion

set nginx_path="..\nginx"
::nginx\logs�´���pid�ļ����Զ�λ��Ŀ¼��nginx
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
::/B����̨���У�����ʾ�����д���
start /B nginx -c %config_path%
goto:eof

:end
endlocal
pause
goto:eof

