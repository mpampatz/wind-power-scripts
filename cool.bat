@echo off


echo c o o l
set  rr=%1
shift
echo -- Input geometry for 5MW Reference wind turbine > geomb.inp
echo 23      ! NSPANB >>geomb.inp
echo   r     chord   twist    xaer     zaer >>geomb.inp

echo -- Input geometry for 5MW Reference wind turbine > profilb.inp
echo 23 ! NSPANB >> profilb.inp
echo   r          profil >> profilb.inp


for /f "tokens=1,2,3,4,5* delims= " %%i in (grid.dat) do call :make_geomb_profilb %%i %%j %%k %%l %%m %%n
exit /b

:make_geomb_profilb
  for /f "delims=" %%i in ('calc.exe -p %1*%rr%') do set radius=%%i
  for /f "delims=" %%i in ('calc.exe -p %2*%rr%') do set chord=%%i
  set twist=%3
  set thickness=%4
  set xaer=%5
  set zaer=%6
  echo %radius%   %chord%   %twist%   %xaer%   %zaer% >> geomb.inp

  if %thickness% gtr 45 goto :mycylinder
  if %thickness% gtr 30 goto :myblade_45
  if %thickness% gtr 27 goto :myblade_30
  if %thickness% gtr 21 goto :myblade_27
  if %thickness% gtr 18 goto :myblade_21
  echo %radius% "myblade_18" >> profilb.inp
exit /b
  :myblade_30
  echo %radius% "myblade_30" >> profilb.inp
  goto :end_if
  :myblade_27
  echo %radius% "myblade_27" >> profilb.inp
  goto :end_if
  :myblade_21
  echo %radius% "myblade_21" >> profilb.inp
  goto :end_if
  :myblade_45
  echo %radius% "myblade_45" >> profilb.inp
  goto :end_if
  :mycylinder
  echo %radius% "mycylinder" >> profilb.inp 
  goto :end_if

  :end_if
exit /b
