::initialize
@echo off
::��ȡ����ԱȨ��
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d %~dp0

call installService.bat
call importSql.bat
call startService.bat
call startSingletonNginx.bat

:end
echo ��ʼ���ɹ�����������ɲ��Զ�����
pause
goto:eof