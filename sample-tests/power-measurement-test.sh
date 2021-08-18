#!/bin/sh
#
# power-measurement-test.sh - use lc/ebf to perform power measurement tests
#
# This is a very simple test, measuring power usage of the DUT while doing
# a find operation at the root.
#
# For environment variable use:
#    export TESTING_CLIENT=ebf
# For /opt/test/testing.conf
#    Value should be enter in the format TESTING_CLIENT=ebf
#
WORKLOAD_COMMAND="sudo stress --cpu 4 --io 3 --vm 2 --vm-bytes 256M --timeout 60s  2> /dev/null"
THRESHOLD_POWER=2.500
MAX_POWER_COMMAND="| xargs -n 1| tail -n+2| cut -d',' -f2,3 --output-delimiter=' '| awk '{printf "%.3f\\n", $1*$2/1000000}'| sort -r| head -1"


if [ -n "$TESTING_CLIENT" ];then
  CLIENT=$TESTING_CLIENT
elif [ -f /opt/test/testing.conf ] && [ -n "$(cat /opt/test/testing.conf | grep "TESTING_CLIENT=" | cut -d "=" -f2)" ];then
  CLIENT=$(cat /opt/test/testing.conf | grep "TESTING_CLIENT=" | cut -d "=" -f2)
elif [ $(which ebf) != "" ];then
  CLIENT="ebf"
elif [ $(which lc) != "" ];then
  CLIENT="lc"
else
  echo "FAILED: TESTING_CLIENT not found"
  exit 1
fi

start_time=$(date +"%s.%N")

error_out() {
    echo "Error: $1"
    exit 1
}

if [ -z $1 ] ; then
    echo "Missing board argument for power test"
    exit 1
fi

if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    echo "Usage: power-measurement-test.sh <board>"
    exit 0
fi

BOARD="$1"

echo "Using client $CLIENT with board $BOARD"

echo "Getting power measurement resource for board"

RESOURCE=$($CLIENT $BOARD get-resource power-measurement)
if [ "$?" != "0" ] ; then
    error_out "Could not get power measurement resource"
fi

echo "RESOURCE=$RESOURCE"

echo "Starting power measurement"

token=$($CLIENT $RESOURCE power-measurement start)
if [ "$?" != "0" ] ; then
    error_out "Could not start power measurement with $CLIENT, with resource $RESOURCE"
fi

echo "token=$token"

echo "Performing some workload (stress test)"

# run the stress test on board
${CLIENT} ${BOARD} ssh run "${WORKLOAD_COMMAND}"


echo "Stopping power measurement"

$CLIENT $RESOURCE power-measurement stop $token || \
    error_out "Could not stop power measurement with $CLIENT"

echo "Getting data"

echo "Here is the data:"
POWER_DATA=$($CLIENT $RESOURCE power-measurement get-data $token) || \
    error_out "Could not get power data with $CLIENT, using token $token"

echo $POWER_DATA

MAX_POWER_USED=`echo "$POWER_DATA" | xargs -n 1| tail -n+2| cut -d',' -f2,3 --output-delimiter=' '| awk '{printf "%.3f\\n", $1*$2/1000000}'| sort -r| head -1`
echo "MAX-POWER-USED=$MAX_POWER_USED"
echo "THRESHOLD-POWER=$THRESHOLD_POWER"

echo "Deleting the data on the server"

$CLIENT $RESOURCE power-measurement delete $token || \
    echo "Warning: Could not delete data for token $token on server"

if  [ "${MAX_POWER_USED%%.*}" -lt "${THRESHOLD_POWER%%.*}" ]  || [ "${MAX_POWER_USED%%.*}" -eq "${THRESHOLD_POWER%%.*}" -a "${MAX_POWER_USED##*.}" -lt "${THRESHOLD_POWER##*.}" ];then
  echo "Power Measurement test is passed"
  return 0
else
  echo "Power Measurement test is failed"
  return 1
fi
