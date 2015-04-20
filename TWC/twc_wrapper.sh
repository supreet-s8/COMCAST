#!/bin/bash

directory="/data/TOOLS_TEAM/root/TWC"

mail_to=`cat ${directory}/mail_to`

if [ -f ${directory}/twc_log.txt ]
then
	rm -f ${directory}/twc_log.txt
fi


if [ -f ${directory}/tmp.txt ]
then

	rm -f ${directory}/tmp.txt

fi


if [ -f ${directory}/out.txt ]
then

        rm -f ${directory}/out.txt

fi

/usr/sbin/vpnc

perl ${directory}/twc_monitoring.pl >  ${directory}/twc_log.txt

#perl -pi -e 's/\e\[01;31m//g' ${directory}/twc_log.txt
#perl -pi -e 's/\e\[0m//g' ${directory}/twc_log.txt
#perl -pi -e 's/\e\[m//g' ${directory}/twc_log.txt
#perl -pi -e 's/\e\[\?1034h//g' ${directory}/twc_log.txt
#perl -pi -e 's/\e\]0;//g' ${directory}/twc_log.txt
#perl -pi -e 's/\r//g' ${directory}/twc_log.txt 
#perl -pi -e 's/^root.*\[/\[/g' ${directory}/twc_log.txt
#perl -pi -e 's/^nz.*\[/\[/g' ${directory}/twc_log.txt

#ps -ef|grep vpnc|grep -v grep|awk '{print $2}'|xargs -I {} kill -9 {}

#perl ${directory}/twc_parse.pl ${directory}/twc_log.txt

if [ -f ${directory}/twc_log.txt ]
then

	perl ${directory}/twc_parse.pl ${directory}/twc_log.txt

	ps -ef|grep vpnc|grep -v grep|awk '{print $2}'|xargs -I {} kill -9 {}
		
	if [ -s ${directory}/out.txt ]
	then
		cat ${directory}/out.txt > ${directory}/tmp.txt
	
		echo "" >> ${directory}/tmp.txt
		echo "" >> ${directory}/tmp.txt
		echo "------------------- Script Logs -------------------" >> ${directory}/tmp.txt

		echo "" >> ${directory}/tmp.txt
		
		cat ${directory}/twc_log.txt >> ${directory}/tmp.txt

		cat ${directory}/tmp.txt | mail -s "TWC Monitoring Report" $mail_to
	else
		cat ${directory}/twc_log.txt >> tmp.txt

                cat ${directory}/tmp.txt | mail -s "TWC Monitoring Report" $mail_to

	fi

else

	echo "Script Failed, please run again" | mail -s "TWC Monitoring Report" $mail_to
fi
