::install service
@echo off
cd /d %~dp0
setlocal enabledelayedexpansion

::base_folder
for /f %%t in ('call myUtils func_getPara base_folder') do (set base_folder=%%~ft)
if "%base_folder%"=="""" (echo please input [base_folder] & goto:end)

::server_app
for /f %%t in ('call myUtils func_getPara server_app') do (set server_app=%%t)
if "%server_app%"=="""" (echo please input [server_app] & goto:end) else (set server_app=!base_folder!\!server_app!)

::service_name
for /f %%t in ('call myUtils func_getPara service_name') do (set service_name=%%t)
if "%service_name%"=="""" (
    for /f %%t in ("%server_app%") do (set service_name=%%~nt)
)

::service_description
for /f %%t in ('call myUtils func_getPara service_description') do (set service_description=%%t)
if "%service_description%"=="""" (set service_description=!service_name!服务端服务（由升级助手生成）)

::service_auto
for /f %%t in ('call myUtils func_getPara service_auto') do (set service_auto=%%t)
if not "%service_auto%"=="false" (set service_auto=true)

::service_arguments
for /f %%t in ('call myUtils func_getPara service_arguments') do (set service_arguments=%%t)

::interact_with_desktop
for /f %%t in ('call myUtils func_getPara interact_with_desktop') do (set interact_with_desktop=%%t)
if not "%interact_with_desktop%"=="true" (set interact_with_desktop=false)

::service_stdin
for /f %%t in ('call myUtils func_getPara service_stdin') do (set service_stdin=%%t)
if not "%service_stdin%"=="""" (set service_stdin=!base_folder!\!service_stdin!)
::service_stdout
for /f %%t in ('call myUtils func_getPara service_stdout') do (set service_stdout=%%t)
if not "%service_stdout%"=="""" (set service_stdout=!base_folder!\!service_stdout!)
::service_stderr
for /f %%t in ('call myUtils func_getPara service_stderr') do (set service_stderr=%%t)
if not "%service_stderr%"=="""" (set service_stderr=!base_folder!\!service_stderr!)

::service_append
for /f %%t in ('call myUtils func_getPara service_append') do (set service_append=%%t)
if not "%service_append%"=="false" (set service_append=true)

::rotate_files
for /f %%t in ('call myUtils func_getPara rotate_files') do (set rotate_files=%%t)
if not "%rotate_files%"=="false" (set rotate_files=true)

::rotate_online
for /f %%t in ('call myUtils func_getPara rotate_online') do (set rotate_online=%%t)
if not "%rotate_online%"=="true" (set rotate_online=false)

::rotate_seconds
for /f %%t in ('call myUtils func_getPara rotate_seconds') do (set rotate_seconds=%%t)

::rotate_bytes
for /f %%t in ('call myUtils func_getPara rotate_bytes') do (set rotate_bytes=%%t)

::is_x86_32,systemBit
for /f %%t in ('call myUtils func_getPara is_x86_32') do (set is_x86_32=%%t)
if not "%is_x86_32%"=="true" (set is_x86_32=false)
if "%is_x86_32%"=="false" (set systemBit=64) else (set systemBit=32)

nssm-2.24\win%systemBit%\nssm stop "%service_name%"

if "%service_arguments%"=="""" (
nssm-2.24\win%systemBit%\nssm install "%service_name%" "%server_app%") else (
nssm-2.24\win%systemBit%\nssm install "%service_name%" "%server_app%" "%service_arguments%"
)

nssm-2.24\win%systemBit%\nssm set "%service_name%" Description "%service_description%"

if "%service_auto%"=="true" (
nssm-2.24\win%systemBit%\nssm set "%service_name%" Start SERVICE_AUTO_START) else (
nssm-2.24\win%systemBit%\nssm set "%service_name%" Start SERVICE_DEMAND_START)

if "%interact_with_desktop%"=="true" (
nssm-2.24\win%systemBit%\nssm set "%service_name%" AppNoConsole 0) else (
nssm-2.24\win%systemBit%\nssm set "%service_name%" AppNoConsole 1)

if not "%service_stdin%"=="""" (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppStdin "%service_stdin%")
if not "%service_stdout%"=="""" (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppStdout "%service_stdout%")
if not "%service_stderr%"=="""" (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppStderr "%service_stderr%")
if not "%rotate_files%"=="false" (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppRotateFiles 1) else (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppRotateFiles 0)
if not "%rotate_online%"=="true" (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppRotateOnline 0) else (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppRotateOnline 1)
if not "%rotate_seconds%"=="""" (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppRotateSeconds "%rotate_seconds%")
if not "%rotate_bytes%"=="""" (nssm-2.24\win%systemBit%\nssm set "%service_name%" AppRotateBytes "%rotate_bytes%")

goto:eof


:end
::没全部执行成功则暂停
pause
endlocal
goto:eof