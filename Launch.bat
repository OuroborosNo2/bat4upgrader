@echo off
::����ԱȨ���Ǹ��ܸ��ӵ����⣬һ�����ڿ�ݷ�ʽ�����û�ȡ����ԱȨ�ޣ���ᵯ����
::��һ�־����������ȡ�����������˷ǳ������⣬��·�����ġ�·�����������´�����ԭ���ڽ�������
::���Ƿ����������Ҫ����ԱȨ��

::��ȡ����ԱȨ��
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~f0 ::","","runas",1)(window.close)&&exit
cd /d %~dp0

setlocal enabledelayedexpansion

::�ȼ��mysql��û�д򿪣�û�Ļ�������forѭ��
for /f "delims=" %%t in ('tasklist ^| findstr mysqld') do (
    goto:continue
)
echo ����mysql�����ܵ�ԭ����mysql����δ����
goto:end

:continue
del log.txt 2>nul
call startService.bat
set /p log=< log.txt
::�������û��װ˵����û��ʼ�����ȳ�ʼ��
if "%log%"=="Service hasn't been installed" (
    ::��������ִ��������룬��Ϊ���޸�����
    for /f "delims=" %%t in ('call importSql.bat') do (
        ::sql�ɹ�����ʱû���������������������������if�ж�Ҳ��
        echo %%t
        echo ����mysql�����ܵ�ԭ����mysql����δ���������벻��ȷ
        goto:end
    )
    call installService.bat
    call startService.bat
)

call startSingletonNginx.bat
echo "�����ɹ���"
pause
start "" http://localhost:8083/upgrader/#/dlzc/login
goto:eof

:end
::ûȫ��ִ�гɹ�����ͣ�鿴
pause
endlocal
goto:eof