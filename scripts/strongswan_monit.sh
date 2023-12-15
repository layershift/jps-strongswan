#!/bin/bash

/bin/systemctl status strongswan > /dev/null  2>&1
if [ "$?" -gt "0" ]; then
    /bin/systemctl restart strongswan > /dev/null  2>&1
    if [ "$?" -eq "0" ]; then
        /bin/logger -p local0.info -t strongswan_monit strongswan restarted successfully
    else
        /bin/logger -p local0.info -t strongswan_monit Failed to restart strongswan
    fi
# else
#         logger -p local0.info -t strongswan_monit strongswan is ok
#         echo "strongswan is ok";
fi