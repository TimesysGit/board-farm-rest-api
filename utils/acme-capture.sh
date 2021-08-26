#!/bin/bash
#
# acme-capture.sh - capture data from a probe on an acme board
#
# Todo:
#

usage() {
    cat <<USAGE
Usage: acme-capture.sh -a {ip_addr} -u {user} -n {probe} -o {logfile}"

Capture timestamp,voltage,current data from an ACME probe into
the indicated logfile.  Output is in CSV format, with measurement
units of seconds,millivolts,milliamps

Options:
  -h, --help    Show this usage help
  -a {ip_addr}  Specify the address (either IP addres or hostname)
                  of the ACME board.  Default is 'acme'
  -u {user}     Specify the user to log in as (via ssh).  Default
                  is 'root'.
  -p {password} Specify the password to use, if needed.
  -o {logfile}  Specify the output file for the data
  -i {interval} Specify the interval between power samples,
                  in seconds. (Default is 1)
  -n {probe}    Specify the probe number to sample. (Default is 1)
USAGE
    exit 0
}

ACME_IP="acme"
USER="root"
PASSWORD=""
INTERVAL=1
PROBE=1
SSHPASS=""

# parse command line arguments
while [ -n "$1" ] ; do
    case $1 in
        -h|--help) usage
            ;;
        -o) OUTFILE=$2
            shift 2
            ;;
        -a) ACME_IP=$2
            shift 2
            ;;
        -u) USER=$2
            shift 2
            ;;
        -p) PASSWORD=$2
            SSHPASS="sshpass -p \"$PASSWORD\" "
            shift 2
            ;;
        -i) INTERVAL=$2
            shift 2
            ;;
        -n) PROBE=$2
            shift 2
            ;;
        *) echo "Error: unrecognized option $1"
            echo "Use -h to see usage info."
            exit 1
            ;;
    esac
done

if [ -z "$OUTFILE" ] ; then
    echo "Error: Missing outfile for data"
    echo "Use -h to see usage info."
    exit 1
fi

if [ -z "$USER" ] ; then
    echo "Error: Missing user for remote operation"
    echo "Use -h to see usage info."
    exit 1
fi

if [ -z "$ACME_IP" ] ; then
    echo "Error: Missing IP address (or hostname) for remote operation"
    echo "Use -h to see usage info."
    exit 1
fi

# silence messages about host key issues
SSH_ARGS="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=ERROR"
SSH="$SSHPASS ssh $SSH_ARGS ${USER}@${ACME_IP}"

cleanup() {
    echo "Cleaning up"
    $SSH rm /usr/bin/${ON_BOARD_SCRIPT_NAME}
    rm /tmp/${ON_BOARD_SCRIPT_NAME}
}

term_handler() {
    if [ -n "$in_term_handler" ] ; then
        echo "Nested SIGTERM - slow down the signals, please"
        return
    else
        in_term_handler="true"
    fi
    echo "Got SIGTERM"
    echo "Killing ${ON_BOARD_SCRIPT_NAME}, on the board"
    # this should result in termination of local ssh command
    # so, there's no need to kill that one
    $SSH pkill -f ${ON_BOARD_SCRIPT_NAME}
    capturing="false"
}

trap term_handler SIGTERM

p="$(( $PROBE - 1 ))"

export ON_BOARD_SCRIPT_NAME="on-board-capture-$PROBE.sh"

cat >/tmp/${ON_BOARD_SCRIPT_NAME} <<HERE
#!/bin/sh
# ${ON_BOARD_SCRIPT_NAME}
vfile="/sys/bus/i2c/devices/1-004$p/iio:device0/in_voltage1_raw"
cfile="/sys/bus/i2c/devices/1-004$p/iio:device0/in_current3_raw"
pfile="/sys/bus/i2c/devices/1-004$p/iio:device0/in_power2_raw"
echo "timestamp,voltage,current"
while true ; do
   timestamp=\$(date +%s)
   voltage=\$(( \$(( \$(cat \$vfile) * 125 )) / 100 ))
   current=\$(cat \$cfile)
   echo "\$timestamp,\$voltage,\$current"
   sleep $INTERVAL
done
HERE

chmod a+x /tmp/${ON_BOARD_SCRIPT_NAME}

$SSH_PASS scp $SSH_ARGS /tmp/${ON_BOARD_SCRIPT_NAME} ${USER}@${ACME_IP}:/usr/bin >/dev/null

# put this in the background, so we can receive a signal
# signal is not delivered until after current command finishes
echo "Starting capture of probe $PROBE on $ACME_IP"
capturing="true"
$SSH ${ON_BOARD_SCRIPT_NAME} >$OUTFILE &

# wait around for capture to stop (ie until we get SIGTERM)
while [ $capturing = "true" ] ; do
    sleep 0.3
done

echo "Capture finished."
cleanup
