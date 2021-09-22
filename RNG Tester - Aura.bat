@echo off
md %USERPROFILE%\.rngtester
md %USERPROFILE%\.rngtester\data
md %USERPROFILE%\.rngtester\dropdata
title RNG Tester
set /a tries=0
set /a moneygain=0
set /a moneyminute=0
set /a raredrops=0
MODE con: lines=3

:askchance
	cls
	set /p chance=Chances of getting number: 1/
	set /a chance="%chance%"+1
	goto askmoney
	
:askmoney
	cls
	set /p money=How much money will you get each drop? Enter Number: 
	goto askname
	
:askname
	cls
	set /p name=What is the name of the rare drop (No spaces): 
	goto askshow
	
:askshow
	cls
	set /p trytf=Would you like to show tries and time? Y/N: 
	if "%trytf%"=="Y" goto autotrysetup
	if "%trytf%"=="N" goto autosetup

:asklog
	cls
	set /p data=Would you like your drop data to be logged? Y/N: 
	if "%datatf%"=="Y" goto checktrylog
	if "%datatf%"=="N" goto checktry

:autotrysetup
	cls
	set /p time=Time in between (Min.1): 
	goto autotry
	
:autotry
	cls
	set /a num=%random% %%%chance%
	set /a tries=%tries% + 1
	set /a timespent=%tries% * %time%
	set /a moneycalc=%moneygain% / %timespent%
	set /a moneyminute=%moneycalc% * 60
	echo Number Rolled: %num% / Try #%tries% / Time Spent: %timespent% seconds / Rare Drops: %raredrops% / Money Gained: %moneygain% / Estimated Money per Minute: %moneyminute%
	if "%num%"=="1" goto claim
	timeout /t %time% >nul
	goto autotry
	
:autosetup
	cls
	set /p time=Time in between (Min.1):
	goto auto
	
:auto
	cls
	set /a num=%random% %%%chance%
	set /a tries=%tries% + 1
	set /a timespent=%tries% * %time%
	set /a moneycalc=%moneygain% / %timespent%
	set /a moneyminute=%moneycalc% * 60
	echo Number Rolled: %num% / Rare Drops: %raredrops% / Money Gained: %moneygain% / Estimated Money per Minute: %moneyminute%
	if "%num%"=="1" goto claim2
	timeout /t %time% >nul
	goto auto
	
:claim
	set /a raredrops=%raredrops% + 1
	set /a moneygain=%moneygain%+%money%
	if "%logtf%"=="Y" echo Timespent: %timespent% seconds / Tries: %tries% / Rare Drops: %raredrops% / Money Gained: %moneygain% / Estimated Money per Minute: %moneyminute% />>%userprofile%\.rngtester\dropdata\%name%.txt
	goto autotry
	
:claim2
	set /a raredrops=%raredrops% + 1
	set /a moneygain=%moneygain%+%money%
	if "%logtf%"=="Y" echo Rare Drops: %raredrops% / Money Gained: %moneygain% / Estimated Money per Minute: %moneyminute%>>%userprofile%\.rngtester\dropdata\%name%.txt
	goto auto
