function test_pre_check {
    # auto-detect the board farm client
    if [ "$TRANSPORT" = "ebf" ] ; then
        TEST_CLIENT="ebf"
    elif [ "$TRANSPORT" = "lc" ] ; then
        TEST_CLIENT="lc"
    else
        abort_job "Board $NODE_NAME is not configured with a valid Board Farm client"
    fi
    export DUT=${BF_NAME:-${NODE_NAME}}

    export RESOURCE=$($TEST_CLIENT $DUT get-resource power-measurement)
    if [ "$?" != "0" ] ; then
        abort "Cannot get power-measurement resource for board $NODE_NAME"
    fi
    echo "power-measurement resource for board $DUT is $RESOURCE"

    # check for program used for 'stress' workload
    assert_has_program stress
}

function test_run {
    WORKLOAD_COMMAND="sudo stress --cpu 4 --io 3 --vm 2 --vm-bytes 256M --timeout 60s 2>/dev/null"

    echo "Executing power test using '$TEST_CLIENT' on '$DUT' using resource '$RESOURCE'"

    # start measuring power
    echo "Starting power measurement capture"
    token=$($TEST_CLIENT $RESOURCE power-measurement start) || true
    rcode=$?
    if [ "$rcode" != "0" ] ; then
        abort_job "Could not start power measurement capture: msg=$token"
    fi

    report "echo Running 'stress' workload on $DUT"
    report_append "echo command=${WORKLOAD_COMMAND}"

    set +e
    report_append "${WORKLOAD_COMMAND}"
    if [ $? != "0" ] ; then
        report_append "echo NOTE: Got non-zero return code running the workload on the board"
    fi
    set -e

    echo "Stopping power measurement capture"
    $TEST_CLIENT $RESOURCE power-measurement stop $token

    echo "Getting power measurement data"

    # put delimiters around the power data, for the parser
    log_this "echo START_POWER_DATA"
    log_this "$TEST_CLIENT $RESOURCE power-measurement get-data $token"
    log_this "echo END_POWER_DATA"

    echo "Removing power measurement data from the server"
    $TEST_CLIENT $RESOURCE power-measurement delete $token
}

function test_cleanup {
    kill_procs stress
}
