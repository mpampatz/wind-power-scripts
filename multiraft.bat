:: m u l t i r a f t . b a t
::
:: 1 Ζητάει verhub και pitch
:: 2 Διαγράφει όλα τα παλιά strip με ονόματα της μορφής strip*.dat
:: 3 Φτιάχνει το νεο aeroin.inp διαγραφοντας το παλιο και τρέχει το raft.exe
:: 4 Μετονομάζει το νεο strip σε strip_uXX_pYY.YY.dat 
::   X το verhub Y το pitch
:: 5 Προβάλει το loads.dat
:: 6 Ρωτάει για να λουπάρει από την αρχή.
::
:: Για να τρεξει πρεπει αν είναι στον ίδιο φακελο με το raft.exe.
:: Γινεται να λουπάρουμε τα βήματα 3 και 4 παραπάνω για ένα ευρος ταχυτήτων(βλ :edit_aeroin)
  

@echo off

:loop_script
call :edit_aeroin
::call :show_aeroin %ustart% %Pitch%
call :delete_old_output
for /l %%i in (%ustart%,%ustep%,%ustop%) do call :main %%i %Pitch% %omega% 
  echo Done!
  echo(
  echo loads.dat
  more loads.dat
  echo Loop script?(y)
  set /p ans=
  if %ans%==y (goto :loop_script)
exit /b




:edit_aeroin
  echo  u =..
  set /p ustart=

:: Για να λουπάρουμε την ταχυτητα απο ustart μεχρι ustop με βημα ustep,
:: uncomment τις επομενες τεσσερις εντολες 
:: και comment τις μεθεπομενες δυο. Χρήσιμο για το 5.1
:: Για τη ρυθμιση γωνίας βήματος με τριαλ-εν-ερρορ στο 5.2, όπως είναι.
:: Η ρύθμιση της ταχυτητας περιστροφής για ταχύτητες μικτοτερες της ονομαστικής
:: πρέπει να γίνει χειροκίνητα ή να μπει στον κώδικα ερώτηση για το OMEGA.

:: echo ustep=..
:: set /p ustep=
:: echo ustop=..
:: set /p ustop=

  set /a ustep=1
  set /a ustop=%ustart%
  
  echo omega=
  set /p omega=

  echo Pitch =..
  set /p Pitch=
exit /b



:show_aeroin
  echo(
  echo This aeroin.inp file will be created
  echo -----------------------------------------------------
  echo(
  echo -- AERO input file for RWT5 blade 
  echo %1     ! VELHUB   
  echo 1.225   ! AIRDEN 
  echo 340.0   ! SSPEED 
  echo(    
  echo  3      ! NBLADE 
  echo  1.5556 ! OMEGA (rad/s) 
  echo %2   ! Collective Pitch 
  echo  1.4684 ! RROOT 
  echo 10.1404 ! RAERO  
  echo 45.0000 ! RTIP   
  echo 20 ! NSTRIP 
  echo 1       ! ITIPLOS  
  echo 0       ! IHUBLOS   
  echo 0.1     ! a 
  echo 0.01    ! a' 
  echo(   
  echo 1 "geomb.inp" "profilb.inp" 
  echo 2 "geomb.inp" "profilb.inp" 
  echo 3 "geomb.inp" "profilb.inp" 
  echo(
  echo -----------------------------------------------------
  pause
exit /b



:delete_old_output
  cls
  echo C A R E ! !
  echo Will delete old strip*.dat files
  pause
  del strip.dat
exit /b



:main
  echo(
  echo Making aeroin.inp file for U = %1 ...
  call :make_aeroin %1 %2 %3
  echo Running  raft.exe ...
  raft.exe
  echo Renaming  strip.dat to strip_u%1_p%2.dat ...
  ren strip.dat strip_u%1_p%2.dat
exit /b



:make_aeroin
::edit τις τιμές που θα μπαίνουν στο aeroin.inp όπως πρεπει.
::Το pitch και το VERHUB εισάγωνται κατά την εκτέλεση. Να μην πειραχτουν!
::
  del /q aeroin.inp
  echo -- AERO input file for RWT5 blade >> aeroin.inp
  echo %1   ! VELHUB >> aeroin.inp
  echo 1.225   ! AIRDEN >> aeroin.inp
  echo 340.0   ! SSPEED >> aeroin.inp
  echo(    >> aeroin.inp
  echo  3      ! NBLADE >> aeroin.inp
  echo  %3 ! OMEGA (rad/s) >> aeroin.inp
  echo  %2 ! Collective Pitch >> aeroin.inp
  echo  1.4684 ! RROOT >> aeroin.inp
  echo  10.140 ! RAERO  >> aeroin.inp
  echo  45.000 ! RTIP   >> aeroin.inp
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

