::install service
@echo off

call D:\Code\Upgrader\exe4jtest\stimulation\bin\myUtils func_getPara client_folder

@REM setlocal enabledelayedexpansion

@REM set tmp=""

@REM for /f "tokens=1,* delims=" %%i in ('findstr "^softwareName=[\u4E00-\u9FA5\uFF08\uFF09A-Za-z0-9_./\\]*" .\configuration.txt') do (
@REM         ::�����һ��Ϊ׼
@REM         set tmp=%%i
@REM         echo %%i
@REM         echo �鵽��
@REM     )
@REM if "%tmp%"=="""" (echo ""& goto:eof)
@REM set compare=����\^
@REM echo %compare%
@REM if "%tmp%"=="%compare%" (echo ����)
@REM echo yes

:end
endlocal
pause
goto:eof