#!/bin/bash

# Make the default flows available in the user library
mkdir -p /data/node-red/user/lib/flows || true
cp /usr/src/app/flows/* /data/node-red/user/lib/flows/

# default to UTC if no TIMEZONE env variable is set
echo "Setting time zone to ${TIMEZONE=UTC}"
#  this only works for debian based images
ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo "${TIMEZONE}" > /etc/timezone
dpkg-reconfigure tzdata

# Start app
DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket node-red --settings /usr/src/app/settings.js
