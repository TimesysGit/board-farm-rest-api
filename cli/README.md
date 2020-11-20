## Contents:
 * Overview
 * Installing EBF cli tool
 * Using EBF cli tool

## Overview

'ebf' is a tool that uses the board farm REST API to discover and
manipulate objects in an automated test lab.  It uses 'curl' to send
requests to the server and receive responses back, and 'jq' to parse
the response data received, which is in json format.

'ebf' is written as a single, standalone shell script.  The current
implementation of 'ebf' can successfully communicate with a TimeSys
board farm cloud server which implements the board farm REST API.  The
goal is to have it support interaction with other board farm management
servers, such as "LabControl".  The current version of 'ebf' supports
both generic and vendor-specific features, with this first
implementation supporting some TimeSys-specific fields and operations.
The goal over time is to mark non-vendor-neutral functionality in 'ebf',
and possibly in the future to provide a mechanism which supports
plugging in new vendor-specific extensions.  However, this is currently
under discussion.

'ebf' is intended to serve as a reference implementation of the client
side of th board farm REST API.  If you would like to implement a board
farm REST API client in another language (e.g. in Python), to provide as
another reference implementation, please let us know.

## Installing EBF cli tool

1. Install Pre-requisites on your linux machine
  * [curl](https://curl.haxx.se/)
  * [jq](https://stedolan.github.io/jq/)
2. Clone board-farm-rest-api repository
```
git clone https://github.com/TimesysGit/board-farm-rest-api.git
```
3. copy ebf tool to /usr/local/bin
```
sudo cp board-farm-rest-api/cli/ebf /usr/local/bin/ebf
```
4. Provide executable permission
```
sudo chmod a+x /usr/local/bin/ebf
```
5. Run below help command to see supported options and commands
```
ebf help
```

## Using EBF cli tool

Most operations that you perform with the 'ebf' tool are operations on
"boards" in a board farm.  A few commands are for authenticating with
the lab and showing configuration, and some other operations are for
discovering the set of boards in the lab, other lab setup.

When performing an operation on a board, the name of the board must be
specified.  Prior to perfoming operations on a board, the board must be
reserved for your use.

Here is a sequence of commands that show some characteristic operations:

```
 $ ebf list devices
 1 beaglebone-1
 2 Raspberry_Pi_1
 3 raspi4_gpio

 $ ebf mydevices
 1 raspi4_gpio

 $ ebf raspi4_gpio info

            ************************
            *  Device Information  *
            ************************

  Hostname:                 raspi4_gpio
  Device Port:              2
  IOCX Status:              true
  Zombie Name:              BFZombie3
  Zombie IP:                172.16.99.23
  ZOMBIE_URL:               http://172.16.99.23/
  Power Switch:             APC AP7931
  Power Switch Port:        2
  Power Switch Commands:    on off reboot on-delay off-delay reboot-delay cancel-pending status
  TFTP DIR:                 upload/DUT2
  NFS DIR:                  /var/lib/lava/dispatcher/tmp/nfs/DUT2/tmp

 $ ebf raspi4_gpio release
 Device is Released

 $ ebf mydevices

 $ ebf raspi4_gpio allocate
 Device is assigned to user tim.bird

 $ ebf raspi4_gpio ssh run "uptime"
  16:18:56 up 2 min,  1 user,  load average: 0.03, 0.03, 0.00

 $ ebf raspi4_gpio power reboot
 Device raspi4_gpio is Powered reboot
```
Use 'ebf help' to get a list of commands and operations supported by
'ebf'.
