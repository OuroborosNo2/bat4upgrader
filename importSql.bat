@echo off
cd /d %~dp0
setlocal enabledelayedexpansion

::base_folder
for /f %%t in ('call myUtils func_getPara base_folder') do (set base_folder=%%~ft)
if "%base_folder%"=="""" (echo please input [base_folder] & goto:end)

::mycnf_address
for /f %%t in ('call myUtils func_getPara mycnf_address') do (set mycnf_address=%%t)
if "%mycnf_address%"=="""" (echo please input [mycnf_address] & goto:end) else (set mycnf_address=!base_folder!\!mycnf_address!)

::sql_address
for /f %%t in ('call myUtils func_getPara sql_address') do (set sql_address=%%t)
if "%sql_address%"=="""" (echo please input [sql_address] & goto:end) else (set sql_address=!base_folder!\!sql_address!)

mysql --defaults-extra-file="!mycnf_address!" -e "source !sql_address!" 2>&1

:end
endlocal
goto:eof