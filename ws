#!/bin/bash
# D. Racine 20130513

umask 0177

IPADDR="$(/sbin/ifconfig |awk '/inet .*broadcast/ {print $2}')"

LOGFILE="/tmp/ws.log"

printf "
  This will serve the PWD (%s) at http://%s:8000
  Are you SURE you want to do this? (y|n): " $PWD $IPADDR

read A; [[ "$A" != [yY] ]] && { echo "Didn't read 'y' or 'Y'. Exiting."; exit 1; }

printf "
  Starting 'python -m SimpleHTTPServer'.
  The contents of %s are available at http://%s:8000
  An access log will be written to the terminal and %s\n" $PWD $IPADDR $LOGFILE

python -m SimpleHTTPServer 2>&1 |tee -a $LOGFILE
