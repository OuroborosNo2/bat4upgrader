::setup
@echo off

::��ȡ�����ļ�base_folder�ֶ�
for /f %%t in ('call bin/myUtils func_getPara base_folder') do (set base_folder=%%~ft)
if "%base_folder%"=="" (echo please input [base_folder] & goto:end)

::�ȴ����ļ��У��������ƶ���·��һ��Ҫ�����ţ�����������Żᵼ�³���
md "%base_folder%"
for /f  "delims=" %%t in ('dir/b') do (
    if not "%%t"=="setup.bat" (move "%%t" "%base_folder%")
)
md "%base_folder%\bin"
echo y | copy "bin" "%base_folder%\bin"
echo y | del bin

::initialize����װ����������
cd /d "%base_folder%\bin"
call installService
call startService

::֪ͨ�������ַ����
call sendRequest
::for /f %%t in ('call sendRequest') do (if not "%%t"=="success" (echo ���������ַ����ͨ��ʧ�ܣ����������ļ�))

:end

pause
goto:eof