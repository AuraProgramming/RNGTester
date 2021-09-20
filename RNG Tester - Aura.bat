@echo off
title RNG Tester
set /a tries=0
MODE con: lines=3

:askchance
	cls
	set /p chance=Chances of getting number: 1/
	set /a chance="%chance%"+1
	goto asklog
	
:asklog
	cls
	set /p trytf=Would you like to log tries and time? (Y/N):
	if "%trytf%"=="Y" goto autologsetup
	if "%trytf%"=="N" goto autosetup

:autologsetup
	cls
	set /p time=Time in between (Min.1):
	goto autolog
	
:autolog
	cls
	set /a num=%random% %%%chance%
	set /a tries=%tries%+1
	set /a timespent=%tries%*%time%
	echo Number Rolled: %num% Try #%tries% Time Spent: %timespent%
	if "%num%"=="1" goto stop
	timeout /t %time% >nul
	goto autolog
	
:autosetup
	cls
	set /p time=Time in between (Min.1):
	goto auto
	
:auto
	cls
	set /a num=%random% %%%chance%
	echo Number Rolled: %num%
	if "%num%"=="1" goto stop
	timeout /t %time% >nul
	goto auto
	
:stop
	timeout /t 60
	exit