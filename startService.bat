::start service
@echo off

setlocal enabledelayedexpansion
::�������ļ���Ĭ��ֵд��������

::ȡ��������Ĭ��Ϊexe��

    for /f %%t in ('call myUtils func_getPara service_name') do (set service_name=%%t)
    if "!service_name!"=="""" (
        ::ȡ��������������ַ
        for /f %%t in ('call myUtils func_getPara server_app') do (set server_app=%%t)
        if "!server_app!"=="""" (echo please input [server_app] and [service_name] & goto:end)
        for /f %%t in ("!server_app!") do (set service_name=%%~nt)
    )


::ȡϵͳλ��
for /f %%t in ('call myUtils func_getPara is_x86_32') do (set is_x86_32=%%t)
::if not "%is_x86_32%"=="true" (set is_x86_32=false)
if not "%is_x86_32%"=="true" (set command=nssm-2.24\win64\nssm start "%service_name%"
) else (set command=nssm-2.24\win32\nssm start "%service_name%")

::�����������ֻ�е�һ���������ģ��ڶ��������룬���鷳��������������������ȷ��ʾ�ģ�������ֻ�ܻ�ȡ����һ����ĸ
for /f %%i in ('!command! 2^>^&1') do (
    if "%%i"=="C" (echo Service hasn't been installed>log.txt) else (echo Service started>log.txt)
)
goto:eof

:end
::ûȫ��ִ�гɹ�����ͣ�鿴
pause
endlocal
goto:eof