@echo off
:main
    call :%1 %2 %3 %4 %5
goto:eof

:func_print
    echo %1
goto:eof

:func_test
    echo ""
goto:eof

::���ַ������ȣ�%1���ַ���
:func_length
    set /a count=0
    set tempStr=%1
    :flag1
    ::ע�����ţ������д������ֱ�ӵ��ڿ�
    if not "%tempStr%"=="" (
        set /a count+=1
        set tempStr=%tempStr:~0,-1%
        goto flag1
    )
    echo %count%
goto:eof

::��ȡĳ������ֵ,--����ʱ���뿪�����ӳ�--,%1��������
:func_getPara
    ::��Ϊ�޷�ȷ���Լ������ĸ�Ŀ¼�����ã�Ҳ���޷�����func_length����,�����Ȼ�ȡ��Ŀ¼
    for /f %%t in ('chdir') do (set root=%%t)
    if "%root:~-3%"=="bin" (set root=%root:~0,-4%)

    if "%1"=="" (echo "" & goto:eof)
    set tmp=""
    ::[\u4E00-\u9FA5A-Za-z0-9_]*$ ������ʽ���������С�Ӣ�������»��߽�β���ַ���  "^%1=[\u4E00-\u9FA5\uFF08\uFF09A-Za-z0-9_./\\]*"
    for /f %%i in ('findstr "^%1=" %root%\configuration.txt') do (
        ::�����һ��Ϊ׼
        set tmp=%%i
    )
    ::û�ҵ������
    if "%tmp%"=="""" (echo "" & goto:eof)
    for /f %%t in ('call %root%\bin\myUtils func_length %1') do (set /a length=%%t)
    setlocal enabledelayedexpansion
    ::����=�ĳ���
    set /a length+=1
    echo !tmp:~%length%!
    endlocal
goto:eof



