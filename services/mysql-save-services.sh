#!/bin/bash

CMD=avahi-ps
NODENAME=$(uname -n)
TSERVICES="services"
TIMEOUT=5

# Buscar els nodes que son del tipus mysqlsaveservices

SERVERS="$(${CMD} search mysqlsaveservices)"

# Buscar tots els servies

SERVICES="$(${CMD} search . $NODENAME)"


save_register(){
	local _TXT
	local _JSON
	local _SERVER

	
	_TXT=$(echo $2| awk -F ";" '{print $6}'|tr -d '"'|tr " " "&")
	_JSON=$(echo $2";"$_TXT | awk -F ";" '{print "{\"type\":\""$1"\",\"description\":\""$2"\",\"hostname\":\""$3"\",\"ip\":\""$4"\",\"port\":\""$5"\",\"txt\":\""$7"\"}" }')
	_SERVER=$(echo $1|awk -F ";" '{print $4":"$5}') 
	curl -m $TIMEOUT -X POST -d "$_JSON" -H 'Content-Type:application/json' http://$_SERVER/$TSERVICES > /dev/null 2>&1
}

[ -z $SERVERS ] && echo "Don't find any server with 'mysqlsaveservices'."

# Per cada servidor:
echo "$SERVERS"| while read i;
do
	echo "$SERVICES"| while read n
	do
		if [ ! -z "$n" ] && [ ! -z "$i" ];
		then 
			save_register "$i" "$n"
		fi
	done
done

