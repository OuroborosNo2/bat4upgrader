::start service
@echo off

::�������ļ���Ĭ��ֵд��������

::ȡ��������Ĭ��Ϊexe��
if not "%1"=="" (set service_name=%1) else (
    for /f %%t in ('call myUtils func_getPara service_name') do (set service_name=%%t)
    if "%service_name%"=="" (
        ::ȡ��������������ַ
        for /f %%t in ('call myUtils func_getPara server_app') do (set server_app=%%t)
        if "%server_app%"=="" (echo please input [server_app] and [service_name] & goto:end)
        for /f %%t in ("%server_app%") do (set service_name=%%~nt)
    )
)

::ȡϵͳλ��
for /f %%t in ('call myUtils func_getPara is_x86_32') do (set is_x86_32=%%t)
if "%is_x86_32%"=="" (set is_x86_32=false)

if "%is_x86_32%"=="false" (nssm-2.24\win64\nssm start "%service_name%"
) else (nssm-2.24\win32\nssm start "%service_name%")


:end
::pause
goto:eof