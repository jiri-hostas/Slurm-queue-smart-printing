#!/bin/sh

# Cleaning of old files
rm -f ~/qqqqqs ~/uber_cele ~/uber_moje ~/jelitko ~/my_jobs_in_the_queue

#1. Counting number of jobs

squeue -u $USER > ~/my_jobs_in_the_queue

all=$(cat ~/my_jobs_in_the_queue | wc -l)
R_amount=$(cat ~/my_jobs_in_the_queue | grep " R " | wc -l)
Q_amount=$(cat ~/my_jobs_in_the_queue | grep " PD " | wc -l)
C_amount=$(cat ~/my_jobs_in_the_queue | grep " C "| wc -l)
array=( "$R_amount" "$C_amount" "$Q_amount" )
array_names=( "Running" "Completed/Cancelled" "Queuing" )
begining="     "
between="  "
ending="  "

printf '%s\n'" ------------------------------------------------------------- "                                                 >> ~/outside
printf '%s\n'"                                                               "                                                 >> ~/outside
printf '%s\n'"                        Job Statistics                         "							                                  	>> ~/outside
printf '%s\n'"                                                               "                                                 >> ~/outside
printf '%s\n'"$begining Running jobs: ${R_amount} $between Queuing jobs: $Q_amount $between Completed: $C_amount $ending"		   >> ~/outside
printf '%s\n'"                                                               "							                                   >> ~/outside
printf '%s\n'" ------------------------------------------------------------- "							                                  >> ~/outside
echo ""														                                                                                         		>> ~/outside

# awk used for text allignment
/home/hostas/bin/center_print ~/outside
rm ~/outside

DIGITS=$(cat ~/.bashrc | tail -15 | wc -l)

#2. Raising error if number of jobs is larger than 100. Printing out job IDs otherwise.

if [[ $all -gt 100 ]]
   then
   	echo "There is more than 100 jobs in the queue, exiting!"
	exit
fi

counter=0 
for jobtypes in R C PD
do 
	echo ""
	echo ${array[$counter]}  ${array_names[$counter]} jobs
	((counter++))
	
	touch ~/uber_moje ; touch ~/uber_cele ; touch ~/jelitko
	squeue -u $USER | grep $USER | grep " $jobtypes " | cut -c-$DIGITS >  ~/uber_moje
	amount=$(wc -l < /home/hostas/uber_moje)

		#3. Preparation of command
	touch ~/uber_cele
	for i in `seq 1 $amount`; do echo "scontrol show jobid -dd" >> ~/uber_cele; done
		#3.1 Pasting together
	paste ~/uber_cele ~/uber_moje > ~/qqqqqs; chmod 751 ~/qqqqqs

		#4. Executing commands one by one
	while read name
	do
		name_short=$(echo $name | awk '{print $3}')
		$name | sed '/exec_host/d' | sed '/Work/!d;s//&\n/;s/.*\n//;:a;/Hold_Types/bb;$!{n;ba};:b;s//\n&/;P;D' | sed 'N;s/\n/ /' | awk '{key=$0; getline; print key ", " $0;}' | sed "s/Error_Path = lattice://g" | xargs | sed "s/, //g ; s/ //g" >> ~/jelitko
	done < ~/qqqqqs

		#5. Printing of the results
	paste ~/uber_moje ~/jelitko | sed "s/Dir=//g" | sed "s/StdErr=.*$//g"

		#6. Deleting processed files
	rm ~/qqqqqs ~/uber_cele ~/uber_moje ~/jelitko
	
done

rm ~/my_jobs_in_the_queue
