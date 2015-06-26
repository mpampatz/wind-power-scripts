@echo off

echo m u l t i r a f t _ c o m p a c t
call :edit_aeroin %1
call :delete_old_output
for /l %%i in (%ustart%,%ustep%,%ustop%) do call :rafting_main_loop %%i %Pitch%
ren loads.dat loads_%1.dat
exit /b


:edit_aeroin
  set rtip=%1
  shift
  set  ustart=5
  set  ustep=1
  set  ustop=25
  set  Pitch=-2.5
  for /f %%i in ('calc -d -p -- "70/%rtip%"') do set omega=%%i
  for /f %%i in ('calc -d -p -- "0.03263 * %rtip%"') do set rroot=%%i
  for /f %%i in ('calc -d -p -- "0.22521 * %rtip%"') do set raero=%%i
exit /b


:delete_old_output
  del strip*.dat
::  if exist loads.dat del loads.dat
exit /b


:rafting_main_loop
  call :make_aeroin %1 
  raft.exe
exit /b



:make_aeroin
  del /q aeroin.inp
  echo -- AERO input file for RWT5 blade >> aeroin.inp
  echo %1   ! VELHUB >> aeroin.inp
  echo 1.225   ! AIRDEN >> aeroin.inp
  echo 340.0   ! SSPEED >> aeroin.inp
  echo(    >> aeroin.inp
  echo  3      ! NBLADE >> aeroin.inp
  echo  %omega% ! OMEGA (rad/s) >> aeroin.inp
  echo  %Pitch% ! Collective Pitch >> aeroin.inp
  echo  %rroot% ! RROOT >> aeroin.inp
  echo  %raero% ! RAERO  >> aeroin.inp
  echo  %rtip%  ! RTIP   >> aeroin.inp
  echo  20 ! NSTRIP >> aeroin.inp
  echo 1       ! ITIPLOS  >> aeroin.inp
  echo 0       ! IHUBLOS   >> aeroin.inp
  echo 0.1     ! a >> aeroin.inp
  echo 0.01    ! a' >> aeroin.inp
  echo(   >> aeroin.inp
  echo 1 "geomb.inp" "profilb.inp" >> aeroin.inp
  echo 2 "geomb.inp" "profilb.inp" >> aeroin.inp
  echo 3 "geomb.inp" "profilb.inp" >> aeroin.inp
exit /b

