*** Settings ***
Library    Process


*** Variables ***
${DUT}                        baylibre_rpi2-1
${TEST_CLIENT}                ebf
${COMMAND_GET_RESOURCE}       ${TEST_CLIENT} ${DUT} get-resource power-measurement
${WORKLOAD_COMMAND}           sudo stress --cpu 4 --io 3 --vm 2 --vm-bytes 256M --timeout 60s  2> /dev/null
${MAX_POWER_COMMAND}          xargs -n 1|tail -n+2| cut -d',' -f2,3 --output-delimiter=' '|awk '{printf "%.3f\\n", $1*$2/1000000}'|sort -r|head -1
${THRESHOLD_POWER}            2.5


*** Test Cases ***
Get Power-Measurement
    ${result}    Run Process    ${COMMAND_GET_RESOURCE}    shell=True
    Set Suite Variable    ${RESOURCE}     ${result.stdout}

    ${result}    Run Process    ${TEST_CLIENT} ${RESOURCE} power-measurement start    shell=True
    Set Suite Variable    ${ID}     ${result.stdout}

    ${result}    Run Process    ${TEST_CLIENT} ${DUT} ssh run "${WORKLOAD_COMMAND}"      shell=True

    ${result}    Run Process    ${TEST_CLIENT} ${RESOURCE} power-measurement stop ${ID}    shell=True
    Should Match     ${result.stdout}   success

    ${result}    Run Process    ${TEST_CLIENT} ${RESOURCE} power-measurement get-data ${ID}   shell=True
    Set Suite Variable    ${POWER_DATA}     ${result.stdout}

    ${result}    Run Process    echo "${POWER_DATA}" | ${MAX_POWER_COMMAND}     shell=True
    Set Suite Variable    ${MAX_POWER_USED}     ${result.stdout}
    Should Be True    ${MAX_POWER_USED} <= ${THRESHOLD_POWER}

    ${result}    Run Process    ${TEST_CLIENT} ${RESOURCE} power-measurement delete ${ID}    shell=True
