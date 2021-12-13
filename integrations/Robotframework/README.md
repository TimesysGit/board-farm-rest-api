## Content

 * Overview
 * EBF-CLI and Robot Framework setup
   * Robot Framework Installation
   * Installation and configuration of 'ebf'
 * Robot Framework test integration

## Overview

This document describes the integration between Robot Framework and the board
farm REST API.  There are two main areas of integration:
 * EBF-CLI and Robot Framework setup
 * Integration into RobotFramework tests

## EBF-CLI and Robot Framework setup

### Robot Framework Installation

Robot Framework is implemented with Python, so you need to have Python installed.

Installing Robot Framework with pip is simple:
```
pip install robotframework
```

To check that the installation was successful, run
```
robot --version
```

Next you need to install RobotFramework libraries needed for EBF integration
```
pip install robotframework-sshlibrary
```

### Installing and configuring ebf

Refer [`ebf` setup guide](https://github.com/TimesysGit/board-farm-rest-api/blob/main/cli/README.md)

## Robot Framework test integration

Tests can use the REST API to control Board and other hardware in the lab during
the test by including EBF-CLI tool commands in the test script.

You can set board name(DUT) and the EBF-CLI tool as variables within the test script and use them in the test cases.
Here is an example.

```
*** Settings ***
Library    Process

*** Variables ***
${DUT}                        rpi3-2
${TEST_CLIENT}                ebf
${COMMAND_GET_RESOURCE}       ${TEST_CLIENT} ${DUT} get-resource power-measurement
${WORKLOAD_COMMAND}           sudo stress --cpu 4 --io 3 --vm 2 --vm-bytes 256M --timeout 60s  2> /dev/null
${MAX_POWER_COMMAND}          xargs -n 1|tail -n+2| cut -d',' -f2,3 --output-delimiter=' '|awk '{printf "%.3f\\n", $1*$2/1000000}'|sort -r|head -1
${THRESHOLD_POWER}            5


*** Test Cases ***
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
```

**Note:** In above example Board (DUT) set in the test must already be assigned to user running 
the Robot Framework test suite.

**For More Information, please see:**

[EBF Website](https://timesys.com/solutions/embedded-board-farm/)