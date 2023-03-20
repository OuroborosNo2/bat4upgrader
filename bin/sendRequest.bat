::sendRequest
@echo off

::�����
for /f %%t in ('call myUtils func_getPara softwareName') do (set softwareName=%%t)
if "%softwareName%"=="" (echo please input softwareName & goto:end)

::�汾
for /f %%t in ('call myUtils func_getPara version') do (set version=%%t)
if "%version%"=="" (echo please input version & goto:end)

::�������
for /f %%t in ('call myUtils func_getPara softwareType') do (set softwareType=%%t)
if "%softwareType%"=="" (echo please input softwareType & goto:end)

::ip��Ĭ��Ϊlocalhost
for /f %%t in ('call myUtils func_getPara ip_address') do (set ip_address=%%t)
if "%ip_address%"=="" (set ip_address=localhost)

::port
for /f %%t in ('call myUtils func_getPara port') do (set port=%%t)
if "%port%"=="" (echo please input port & goto:end)

::�Ƿ����ڸ��£�Ĭ��Ϊfalse
for /f %%t in ('call myUtils func_getPara is_update') do (set is_update=%%t)
if not "%is_update%"=="true" (set is_update=false)

::������
if "%is_update%"=="true" (
curl "http://%ip_address%:%port%/bat/download/%softwareName%/%version%/%softwareType%") else (
curl "http://%ip_address%:%port%/bat/update/%softwareName%/%version%/%softwareType%")

echo success

:end
pause
goto:eof