#!/bin/bash
source ./setting.txt


echo "*******************************************************"
echo "* CIARA IPMITOOL Auto Logging Tool                    *"
echo "* 2017-09-11      Ver.1                               *"		
echo "*	Please check setting.txt to set	runtime & remote    *"
echo "* destination etc...                                  *"
echo "*                                                     *"
echo "*******************************************************"

##could check here if destination is reachable.

##could check if user/password combo is correct.

total_call=$(( $run_time_in_m*60/$logging_interval )) ##calculate the amount of looping needed

for((i=1; i<=$total_call; i++))
do
	echo "Current time: | $(date)" > .temp;
	echo "Time stamp: | $(date +%s)" >>.temp;
	echo "Excel time format: | $(date +"%e/%m/%g %r")" >>.temp;
	ipmitool -H $IP -U $user -P $pw sdr >> .temp;
	echo "exit code: $?" >>.temp;
	cat .temp | tee -a ./Results/$output_file$(date -I).txt
	sleep $logging_interval >> /dev/null;

done

rm .temp;

echo "done"
