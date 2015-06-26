@echo off
set /a rstart=50
set /a rstep=1
set /a rstop=50

if exist loads*.dat del loads*.dat
if exist mpowers.dat del  mpowers.dat
for /l %%i in (%rstart%,%rstep%,%rstop%) do call :comple_main %%i
  pause
exit /b

:comple_main
  set rotor_radius=%1
  call cool %rotor_radius%
  call multiraft_compact %rotor_radius%
  call power_calc2 %rotor_radius% 
::  echo %rotor_radius% %mpower% 
  more loads_%1.dat
exit /b
