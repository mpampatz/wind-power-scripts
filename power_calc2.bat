
@echo off

echo p o w e r _ c a l c 2
set Ucutin=5
set Ucutout=25
set ustep=1
set k=2.026878
set c=9.908575

set mpower=0

for /f "tokens=1,3 delims= " %%i in (loads_%1.dat) do call :calc_mean_power %%i %%j
exit /b

:calc_mean_power
  set U=%1
  set P=%2
  for /f %%i in ('calc.exe -d -p -- "(%k%/%c%)*(power((%U%/%c%),(%k%-1)))*(exp(-power((%U%/%c%),%k%)))"') do set weibval=%%i
  for /f %%i in ('calc.exe -d -p -- "%ustep%*%weibval%*%P%"') do set dmpower=%%i
  for /f %%i in ('calc.exe -d -p -- "%mpower%+%dmpower%"') do set mpower=%%i

::  echo %u% %p% %weibval% %dmpower% %mpower%
exit /b


