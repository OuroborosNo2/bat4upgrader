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

::求字符串长度，%1：字符串
:func_length
    set /a count=0
    set tempStr=%1
    :flag1
    ::注意引号，如果不写引号则直接等于空
    if not "%tempStr%"=="" (
        set /a count+=1
        set tempStr=%tempStr:~0,-1%
        goto flag1
    )
    echo %count%
goto:eof

::获取某参数的值,--调用时必须开变量延迟--,%1：参数名
:func_getPara
    ::因为无法确定自己是在哪个目录被调用，也就无法调用func_length函数,所以先获取根目录
    for /f %%t in ('chdir') do (set root=%%t)
    if "%root:~-3%"=="bin" (set root=%root:~0,-4%)

    if "%1"=="" (echo "" & goto:eof)
    set tmp=""
    ::[\u4E00-\u9FA5A-Za-z0-9_]*$ 正则表达式，以若干中、英、数、下划线结尾的字符串  "^%1=[\u4E00-\u9FA5\uFF08\uFF09A-Za-z0-9_./\\]*"
    for /f %%i in ('findstr "^%1=" %root%\configuration.txt') do (
        ::按最后一个为准
        set tmp=%%i
    )
    ::没找到则结束
    if "%tmp%"=="""" (echo "" & goto:eof)
    for /f %%t in ('call %root%\bin\myUtils func_length %1') do (set /a length=%%t)
    setlocal enabledelayedexpansion
    ::加上=的长度
    set /a length+=1
    echo !tmp:~%length%!
    endlocal
goto:eof



