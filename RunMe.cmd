：： This batch file record the sensor info on a remote server, using IPMIcommands
Setlocal EnableDelayedExpansion

@ECHO OFF
:: do not have space before and after =
SET client_ip=192.168.1.127
SET user_name=admin
SET password=admin
SET output="RS510_%date%_raw.txt"
SET run_time_in_m=120

::add in the error checking portions


:: Do not edit any info below unless necessary

ECHO .
ECHO .
ECHO .
ECHO PLEASE MAKE SURE THE CONFIGURATION FILE IS PROPERLY SET UP
ECHO CONFIRM TO PROCEED?
PAUSE
ECHO Welcome to Smart IPMI logger
ECHO Starting Time
ECHO %DATE%
ECHO %TIME%
ECHO .
ECHO "starting date and time:" >> %output%
SET steps=%run_time_in_m%*1;
ECHO PLEASE DONT KILL ME
@ECHO ON
FOR /L %%G IN (1,1,%steps%) DO (
ECHO %DATE% >> %output%
ECHO !TIME! >> %output%
ipmiutil-3.0.5-win64\ipmiutil.exe sensor -N %client_ip% -U %user_name% -P %password% >> %output%
ECHO . >> %output%
ECHO . >> %output%
ECHO . >> %output%
PING 127.0.0.1 -n 60 >> NUL
)
ECHO DONE
ECHO END TIME: !TIME!