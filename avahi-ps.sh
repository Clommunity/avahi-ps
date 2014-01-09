#!/bin/bash
# 
# avahi-ps: Avahi Publicar i Buscar - 
# Amb aquest script podem buscar i configurar els serveis que trovem per avahi.
# També podem publicar nous serveis.

if [ $# -lt 1 ]
then
	echo "Avahi - Publish and Search: System to publish avahi services or Search existents services."
	echo "Use: $0 publish|search <options>"

	echo "Use: $0 publish <describe> <type> <port> <txt>"
	echo "		<describe>: Text describe service."
	echo "		<type>: Service type."
	echo "		<port>: Service port."
	echo "		<txt>: Other information, format 'attibute1=value1&attribute2=value2&...&attributeN=valueN'. "

	echo "Use: $0 search <type> <hostname>"
	exit
fi

# Variables 
PLUG_DIR="./plugs/"
CONNECTS_DIR="./connects/"
IPv="IPv4"

DATABASE="none"
PUBLIC_DEVICE="wlan0"
CLOUD_NAME="guifi"
DEVICE_NAME=${CLOUD_NAME}
EXECUTE_IN="memory"


# Calculate Variables.
PUBLIC_IP=$(ip addr show dev $PUBLIC_DEVICE|grep "inet "|awk '{print $2}'|awk -F "/" {'print $1'})
FILENAME="avahi-ps-"
NODENAME=$(uname -n)
# PUBLIC_IP=$(ifconfig $PUBLIC_DEVICE|grep "inet "|awk '{print $2}'|awk -F ":" '{print $2}')

# Load plugins.
# Execution
if [ ! -f ${PLUG_DIR}${FILENAME}${EXECUTE_IN} ]
then
	echo "Error, don't exist '${PLUG_DIR}${FILENAME}${EXECUTE_IN}' plugs."
	exit 
fi
. ${PLUG_DIR}${FILENAME}${EXECUTE_IN}

# Database
if [ ! -f ${PLUG_DIR}${FILENAME}${DATABASE} ]
then
	echo "Error, don't exist '${PLUG_DIR}${FILENAME}${DATABASE}' plugs."
	exit 
fi
. ${PLUG_DIR}${FILENAME}${DATABASE}

# Publish
if [ $1 == "publish" ]
	then
		echo "Make publish"
		shift
		publish_service $@

elif [ $1 == "search" ]
	then
		echo "Make search"
		shift
		find_service $@
fi

