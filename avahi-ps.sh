#!/bin/bash
# 
# avahi-ps: Avahi Publicar i Buscar - 
# Amb aquest script podem buscar i configurar els serveis que trovem per avahi.
# També podem publicar nous serveis.

# General functions
avahi-ps-help(){

	echo "Avahi - Publish and Search: System to publish avahi services or Search existents services."
	echo "Use: $0 publish|search|unpublish <options>"

	echo "Use: $0 publish <describe> <type> <port> [txt]"
	echo "		<describe>: Text describe service."
	echo "		<type>: Service type."
	echo "		<port>: Service port."
	echo "		<txt>: Other information, format 'attibute1=value1&attribute2=value2&...&attributeN=valueN'. "

	echo "Use: $0 search [type] [hostname]"
	exit

}

# Start program

if [ $# -lt 1 ]
then
	avahi-ps-help
fi

# Variables 
PLUG_DIR="./plugs/"
IPv="IPv4"

DATABASE="none"
PUBLIC_DEVICE="wlan0"
CLOUD_NAME="guifi"
#DEVICE_NAME=${CLOUD_NAME}
DEVICE_NAME="demo"
EXECUTE_IN="memory"
ERRORS_PLUG="errors"
SAVE_SERVICE="none"

# Calculate Variables.
PUBLIC_IP=$(ip addr show dev $PUBLIC_DEVICE|grep "inet "|awk '{print $2}'|awk -F "/" {'print $1'})
FILENAME="avahi-ps-"
NODENAME=$(uname -n)
# PUBLIC_IP=$(ifconfig $PUBLIC_DEVICE|grep "inet "|awk '{print $2}'|awk -F ":" '{print $2}')

# Load plugins.
# Errors
if [ ! -f ${PLUG_DIR}${FILENAME}${ERRORS_PLUG} ]
then
	echo "Error, don't exist '${PLUG_DIR}${FILENAME}${ERRORS_PLUG}' plugs."
	exit 
fi
. ${PLUG_DIR}${FILENAME}${ERRORS_PLUG}

# Execution
if [ ! -f ${PLUG_DIR}${FILENAME}${EXECUTE_IN} ]
then
	echo "Error, don't exist '${PLUG_DIR}${FILENAME}${EXECUTE_IN}' plugs."
	exit 
fi
. ${PLUG_DIR}${FILENAME}${EXECUTE_IN}

if [ -f ${PLUG_DIR}${FILENAME}${SAVE_SERVICE} ]
	then
	. ${PLUG_DIR}${FILENAME}${SAVE_SERVICE}
fi

# Database
if [ ! -f ${PLUG_DIR}${FILENAME}${DATABASE} ]
then
	echo "Error, don't exist '${PLUG_DIR}${FILENAME}${DATABASE}' plugs."
	exit 
fi
. ${PLUG_DIR}${FILENAME}${DATABASE}

# Publish
if [ "$1" == "publish" ]
	then
		shift
		publish_service $@

elif [ "$1" == "search" ]
	then
		shift
		search_service $@

elif [ "$1" == "unpublish" ]
	then
		shift
		unpublish_service $@	
fi


