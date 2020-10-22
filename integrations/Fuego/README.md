## Content

 * Overview
 * Fuego core integration
   * Installation and configuration of 'ebf'
   * Board settings for a remote board
 * Fuego test integration
 * Configuring Jenkins nodes and jobs
 * Future work
   * LabControl
   * Direct integration into Fuego's overlay layer

## Overview

This document describes the integration between Fuego and the board
farm REST API.  There are two main areas of integration:
 * into the Fuego core
 * into Fuego tests


## Fuego core integration

The Fuego core has two abstraction layers for interfacing with boards during
a test:
 * the TRANSPORT layer
 * the BOARD_CONTROL layer

Both of these layers already support use of an external target
control tool called 'ttc'.  See https://elinux.org/Ttc_Program_Usage_Guide

For initial integration of the board farm REST API, Fuego supports
ebf operations through the 'ttc' command.  The style of integration
might change in future versions of Fuego.  See the section 'Future work'
below for some ideas on this subject.


### Installing and configuring ttc and ebf

When Fuego is installed, it incorporates the 'ttc' command into the Fuego
docker container.  It also copies the user's /etc/ttc.conf file from the
host system (/etc directory) to /fuego-ro/conf/ttc.conf inside the Fuego
docker container.

The ttc.conf file has the mapping from 'ttc' commands to 'ebf' commands

Here is the 'ttc' configuration for board called 'raspi4_gpio' running
in the main board farm cloud lab of TimeSys.

```
#======================================
target=rp4
ebf_name=raspi4_gpio

description="""Raspberry Pi 4 board in TimeSys board farm
(used in gpio testing and for ELCE board farm API talk)"""

run_cmd=ebf %(ebf_name)s ssh run "$COMMAND"

copy_to_cmd="""ebf %(ebf_name)s ssh upload $src $dest
if [ -x $src ] ; then ebf %(ebf_name)s ssh run "chmod a+x $dest/$(basename
$src)" ; fi
"""

copy_from_cmd=ebf %(ebf_name)s ssh download $src $dest

reboot_cmd=ebf %(ebf_name)s power reboot
```

Note that while running Fuego, there are two copies of 'ttc' on the
system.  One is on the host machine, and uses /etc/ttc.conf.  The other
is inside the docker container, and uses /fuego-ro/conf/ttc.conf.  These
two files must be kept synchronized in order to avoid confusion when
performing operations manually either inside or outside the docker
container.  Usually this is not a problem.  Once your configuration for
a board is set, you do not need to adjust it.  However, when initially
setting up the 'ttc' configuration for a board it is recommended to
first get all required operations (ttc run, ttc cp, and ttc reboot)
running correctly on your host system (by editing /etc/ttc.conf), and
then transferring that ttc.conf inside the docker container for use in
automated testing by Fuego.

The 'ebf' program needs to also be installed into the docker container.
Assuming it is already located at /usr/local/bin on your host machine,
execute the following commands to place it inside Fuego's docker
container:

```
 $ docker cp /usr/local/bin/ebf fuego-container:/usr/local/bin
```

If you used a different docker container name when you installed
Fuego, use that name in place of 'fuego-container' for the
above command.

During test execution, Fuego executes commands as the user 'jenkins'
inside the docker container.  The system is configured so that
the 'jenkins' user can execute the 'ebf' command to perform
operations on boards in remote labs.

The jenkins user account must have a correct ebf
config.  In the Fuego docker container, this means that
the file /var/lib/jenkins/.ebfconfig must exist, and must
have the correct server address, user credentials and authentication
token.

To achieve this, before interacting with a board in a remote
board farm, first execute the following commands inside the
docker container (starting as root):

```
 $ su - jenkins
 $ ebf login
 [ provide login name and password ]
 $ ebf list config
```

This operation only needs to be perfomed once, when setting
up a remote board for inclusion in a Fuego lab.


### Board settings for a remote board

In order to use Fuego with ebf and the board farm API, you need to
create a Fuego board definition for the remote board. Do this by
creating a board file as usual (located a fuego-ro/boards), and then add
the additional lines to the file inside the Fuego docker container.  Here
are the lines for the raspi4_gpio board in the TimeSys lab, configured
as proxy board 'rp4' in Tim's Fuego system:

TRANSPORT=ttc
BOARD_CONTROL=ttc
TTC_TARGET=rp4
LAB_SERVER=bfc.timesys.gpio
LAB_BOARD_NAME=raspi4_gpio

With these settings in the Fuego board file and in ttc.conf and
in the .ebfconfig file, the remote board is now fully defined in Fuego.


## Fuego test integration

Besides Fuego core, the test themselves need to support use
of the board farm REST API, in order to operate in a lab-independent
fashion.

Test can use the REST API to control other hardware in the lab
during the test.  However, before doing this, the test needs
to know the lab server address, and the name of the board within
the lab.

These are passed as environment variables to the test.  Fuego uses
the environment variable LAB_SERVER to indicate the leading part
of the URL for the server, and BOARD_NAME to specify the name
of the board.

Here are example values used during initial integration with
the board farm API.

```
LAB_SERVER=bfc.timesys.com
BOARD_NAME=raspi4_gpio
```

Note that BOARD_NAME is set from the LAB_BOARD_NAME specified
in the Fuego board file, not from the NODE_NAME set during the Fuego
test execution.


## Configuring Jenkins nodes and jobs

The final step of integration is to add a Jenkins node for the board,
and install jobs for that node.  This is the same as for any other
board defined in Fuego.  It can be accomplished with the following
commands, which are executed inside the docker container:

```
 $ ftc add-node -b rp4
 $ ftc add-job -b rp4 -t fuego_board_check
 $ ftc add-job -b rp4 -t gpio
```

This would install the Fuego board 'rp4' as node in the Jenkins
interface, and add two jobs that Jenkins can use to perform those
tests on the board.

Now, the tests can be executed manually using the Jenkins interface,
or they can be scheduled usig Jenkins features (e.g. triggering
jobs based on schedules or Jenkins-detected events).


## Future work

### LabControl

Tim Bird is working on development of a standalone board farm server
called "LabControl".  This project implements the board farm REST API
in a CGI/WSGI script, suitable for integration into a web server on
your lab site.  It also includes a command line interface tool called
'lc'.  This code is not yet ready for production use, but you
can review the project if you like.

The git repository is at https://github.com/tbird20d/labcontrol

This project may be integrated with Fuego in the future.


### Direct integration into Fuego's overlay layer

In the future, it may be desirable to integrate board farm REST API
operations directly into Fuego's overlay system (described below).
Currently, there are multiple layers involved, which requires lots of
extra configuration, is slightly inefficient.  The Fuego core calls the
overlay functions, when then call ttc, which calls ebf, which invokes
curl and jq.

Instead of using ttc and ebf, the direct calls to the board farm server
could be integrated into Fuego's overlay functions.

Fuego's support for board control and management operations uses
an abstraction layer called the "overlay" system, which implements
commands to access boards through a set of shell functions which can
be overridden at test invocation time.

The commands for performing operations on the device under test are
located in 'fuego-core/overlays/base/base-board.fuegoclass'.

Board access methods are defined by the routines:
 * ov_board_setup
 * ov_board_teardown
 * ov_transport_connect
 * ov_transport_disconnect
 * ov_transport_get
 * ov_transport_put
 * ov_transport_cmd
 * ov_board_control_reboot

These functions use variables that are defined in the Fuego board file,
as part of performing operations on a board during a test.
See http://fuegotest.org/wiki/Overlay_Generation for a description
of this Fuego feature.

Integration of the board farm API directly into this layer of Fuego
is under current consideration.
