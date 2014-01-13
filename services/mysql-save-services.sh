#!/bin/bash



CMD=./avahi-ps.sh
TSERVICES="services"
# Buscar els nodes que son del tipus mysqlsaveservices

_SERVERS="$(${CMD} search mysqlsaveservices)"

# Buscar tots els servies

_SERVICES="$(${CMD} search)"

[ -z $_SERVERS ] && echo "Don't find any server with 'mysqlsaveservices'."
# Guarder el IFS
OIFS=$IFS
IFS=$(echo -e '\n') 
# Per cada servidor:
for i in $_SERVERS;
do
	for n in $_SERVICES
	do
		echo $i":"$n
	done
done
IFS=$OIFS

save_register(){
	#TODO: Validar que no existeix

	echo $@;

	echo "INSERT INTO ${TSERVICES} values (null, );"
}
