::initialize
@echo off
installService.bat
startService.bat

for /f %%t in ('sendRequest.bat') do (if not "%%t"=="success" (echo ���������ַ����ͨ��ʧ�ܣ����������ļ�))
:end
pause
goto:eof