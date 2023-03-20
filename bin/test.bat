::install service
@echo off

call D:\Code\Upgrader\exe4jtest\stimulation\bin\myUtils func_getPara client_folder

@REM setlocal enabledelayedexpansion

@REM set tmp=""

@REM for /f "tokens=1,* delims=" %%i in ('findstr "^softwareName=[\u4E00-\u9FA5\uFF08\uFF09A-Za-z0-9_./\\]*" .\configuration.txt') do (
@REM         ::按最后一个为准
@REM         set tmp=%%i
@REM         echo %%i
@REM         echo 查到了
@REM     )
@REM if "%tmp%"=="""" (echo ""& goto:eof)
@REM set compare=中文\^
@REM echo %compare%
@REM if "%tmp%"=="%compare%" (echo 等于)
@REM echo yes

:end
endlocal
pause
goto:eof