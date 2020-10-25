# REST APIs

This directory holds the actual API definitions for the board farm REST
APIs.  This content is under construction.  If you see anything missing
from this directory, or something is unclear, please contact the
project leaders or the community in the forums mentioned in the top
README file.

## Overview

The APIs provided by the board farm REST APIs are web-based APIS, and
are modeled on the Django REST API framework which is described at
https://www.django-rest-framework.org/

Individual APIs in this standard are described using files in openapi
format in this directory.
 * [Device List](https://github.com/TimesysGit/board-farm-rest-api/blob/main/spec/device_list)
 * [Device Info](https://github.com/TimesysGit/board-farm-rest-api/blob/main/spec/device_info)
 * [Power On](https://github.com/TimesysGit/board-farm-rest-api/blob/main/spec/power_on)

In general, an API is called by making a request of a server and receiving
a response.  Usually, the materials for the request are passed in JSON format,
and the response is transmitted back to the requesting client also in
JSON format.

A client, called 'ebf' is supplied with this distribution, which
implements the API to provide a command line interface to the board
farm REST API functionality.  It is very helpful to examine the
source code for that client in order to see how the API is used
in practice.

# Example:

Here is an example of one of the board farm REST APIs.  It
shows the GPIO 'read' operation for an endpoint in
a board farm connected to one of the GPIO pins on a board
under test.

## GPIO API

**Endpoint URI**
```
https//bfc.timesys.com/api/{DeviceName}/gpio/{gpio_command}/{gpio_pin_pattern(location)}/{gpio_pin_data}
```
Parameter | Type | Description
------------ | ------------- | -------------
DeviceName | String | Name of device in Board Farm
gpio_command | String | Any GPIO command supported by the API
gpio_pin_pattern(location) | Integer | GPIO Pin number or pattern mask
gpio_pin_data | Integer/String | For GPIO pin commands - GPIO Pin mode or set value. For GPIO mask commands - mode mask and mask patterns.

Here is a list of different GPIO operations in the lab, and the
URI paths associated with those operations.

Method | GPIO Command | HTTP request
------------ | ------------- | -------------
get | set_mode | GET /api/{DeviceName}/gpio/set_mode/{gpio_pin_number}/{write/read}
get | get_mode | GET /api/{DeviceName}/gpio/get_mode/{gpio_pin_number}
get | write | GET /api/{DeviceName}/gpio/write/{gpio_pin_number}/{0/1}
get | read | GET /api/{DeviceName}/gpio/read/{gpio_pin_number}
get | set_mode_mask | GET /api/{DeviceName}/gpio/set_mode_mask/{Lab pin locations pattern mask}/{0-255}
get | get_mode_mask | GET /api/{DeviceName}/gpio/get_mode_mask/{Lab pin locations pattern mask}
get | write_mask | GET /api/{DeviceName}/gpio/write_mask/{Lab pin locations pattern mask}/{0-255}
get | read_mask | GET /api/{DeviceName}/gpio/read_mask/{Lab pin locations pattern mask}

NOTE: "mode" refers to read/write. Pattern 0-255 is for a 8 pin GPIO controller. It would vary for controllers having more/less GPIO lines.

**Responses**
**Format**

Each response is a JSON object.

**result** (string) - success/fail

**data** (integer/string) - GPIO command dependent - OPTIONAL

**message** (string) - GPIO command failure reason when result is a fail - OPTIONAL

**Success Response (example)**
```
{
 "result": "success",
 "data": 255
}
```

**Error Response (example)**
```
{
 "result": "fail",
 "message": "One or more GPIO pins being written to is in input mode."
}
```

Finally, here is the openapi specification for the gpio read operation.

**OpenAPI specification**

```
openapi: 3.0.0
info:
  title: Generated for BFC-TAS
  version: '0.2'
servers:
  - url: https://bfc.timesys.com
paths:
  /api/raspi4_gpio/gpio/read/{pin_number}:
    get:
      parameters:
        - in: path
          name: pin_number
          required: true
          schema:
            type: integer
          description: GPIO pin number
      responses:
        200:
          description: ''
          content:
            application/json:
              schema:
                type: object
                properties:
                  result:
                    type: string
                  data:
                    type: integer
                  message:
                    type: string
                required:
                  - result
```

```
openapi: 3.0.0
info:
  title: Generated for BFC-TAS
  version: '0.2'
servers:
  - url: https://bfc.timesys.com
paths:
  /api/raspi4_gpio/gpio/write_mask/{gpio_pin_pattern}/{gpio_pattern_mask}:
    get:
      parameters:
        - in: path
          name: gpio_pin_pattern
          required: true
          schema:
            type: integer
          description: GPIO pin pattern
        - in: path
          name: gpio_pattern_mask
          required: true
          schema:
            type: integer
          description: GPIO mask
      responses:
        200:
          description: ''
          content:
            application/json:
              schema:
                type: object
                properties:
                  result:
                    type: string
                  data:
                    type: integer
                  message:
                    type: string
                required:
                  - result
```

**TO Be Defined**
- [ ] Error codes
- [ ] Error conditions and standardized error messages

## List of operations supported in ebf:

Following is a list of operations currently supported by ebf,
and their general meaning:

Here is a sample curl command from 'ebf':

```
OUTPUT=$(curl -s -k --location --request GET "$SERVER_URL/api/v0.2/devices/"  --header 'Authorization: token '$AUTH_TOKEN'')
DEVICE_LIST=( $(echo $OUTPUT|jq -r '.[].hostname') )
```

An authorization token is passed in the request header, and the data
from the response is stored in the OUTPUT shell variable.  Then
individual elements from the OUTPUT are parsed using 'jq'.  In this
case, the output is parsed into a list.  Other times, jq is used to
parse individual fields from the returned data, like the following:

```
RESULT=$(echo $OUTPUT|jq -r .result)
MESSAGE=$(echo $OUTPUT|jq -r .message)
```
The set of different operations currently supported by 'ebf' is listed
below, with redundant information removed:

#### Authentication:
 * POST api/v0.2/token/  --header 'Content-Type: application/json' --data-raw '{"username":"'"$USER_NAME"'" , "password":"'"$PASSWORD"'"}

#### Boards and reservations:
 * GET  api/v0.2/devices/
 * GET  api/v0.2/devices/mine/
 * GET  api/v0.2/devices/$DEVICE
 * GET  api/v0.2/devices/$DEVICE/assign
 * GET  api/v0.2/devices/$DEVICE/release
 * GET  api/v0.2/devices/$DEVICE/release/force

#### Power:
 * GET  api/v0.2/devices/$DEVICE/power
 * PUT  api/v0.2/devices/$DEVICE/power/on
 * PUT  api/v0.2/devices/$DEVICE/power/on-delay
 * PUT  api/v0.2/devices/$DEVICE/power/off
 * PUT  api/v0.2/devices/$DEVICE/power/off-delay
 * PUT  api/v0.2/devices/$DEVICE/power/reboot
 * PUT  api/v0.2/devices/$DEVICE/power/reboot-delay
 * PUT  api/v0.2/devices/$DEVICE/power/cancel-pending

#### Hotplug:
 * GET  api/v0.2/devices/$DEVICE/hotplug/${HOTPLUG_NUMBER}/
 * PUT  api/v0.2/devices/$DEVICE/hotplug/${HOTPLUG_NUMBER}/on/
 * PUT  api/v0.2/devices/$DEVICE/hotplug/${HOTPLUG_NUMBER}/off/
 * PUT  api/v0.2/devices/$DEVICE/hotplug/${HOTPLUG_NUMBER}/switch/

#### Execute and file transfers:
 * GET api/v0.2/devices/$DEVICE/run/serial/"  '' --data-raw '{ "command":"'"$DEVICE_COMMAND"'" }'
 * GET api/v0.2/devices/$DEVICE/run/ssh/"  '' --data-raw '{ "command": "'"$DEVICE_COMMAND"'"}'

 * GET api/v0.2/devices/$DEVICE/download/serial/$FILE_PATH/ --output ${FILE_PATH##*/}
 * POST api/v0.2/devices/$DEVICE/upload/serial/ --form 'file=@'$FILE_PATH'
 * GET  api/v0.2/devices/$DEVICE/downld/ssh?path=$SRC_FILE_PATH --output ${DST_FILE_PATH}

 * POST api/v0.2/devices/$DEVICE/upld/ssh/ --form 'file=@'$SRC_FILE_PATH'' --form 'path='$DST_FILE_PATH'

#### GPIO
 * GET  api/v0.2/devices/$DEVICE/gpio/$COMMAND/$GPIO_PATTERN/$GPIO_DATA

#### Console
 * GET  api/v0.2/devices/$DEVICE/console/serial/isactive/
 * GET  api/v0.2/devices/$DEVICE/console/serial/restart/
 * GET  api/v0.2/devices/$DEVICE/console/serial/isactive/

## TimeSys-specific APIs

Some APIS support operations which might be specific to a particular
lab's server implementation or lab configuration.  TimeSys board farms
support elements called "Zombies", which handle port forwarding
and other interactions with the boards in their lab.

Work is ongoing to identify non-neutral APIs and decide how to either
generalize or isolate them.

#### Zombie control and port forwarding:
 * GET  api/v0.2/devices/$DEVICE/portfw/nat/
 * GET  api/v0.2/devices/$DEVICE/portfw/ssh/

 * POST api/v0.2/zombies/$ZOMBIE_NAME/portforward/nat/"  '' --data-raw '{ "device_ip":"'"$DEVICE_IP"'", "dut_port":"'"$DUT_PORT"'", "zombie_port":"'"$ZOMBIE_PORT"'", "pcol":"'"$PROTOCOL"'" }'
 * POST api/v0.2/devices/$DEVICE/portfw/ssh/"  '' --data-raw '{ "dut_ip":"'"$DEVICE_IP"'", "username":"'"$USERNAME"'", "dut_pw":"'"$PASSWORD"'", "dut_port":"'"$DUT_PORT"'", "zombie_port":"'"$ZOMBIE_PORT"'" }'
 * DELETE /api/v0.2/devices/$DEVICE/portfw/nat/"  '' --data-raw '{ "device_ip":"'"$DEVICE_IP"'", "dut_port":"'"$DUT_PORT"'", "zombie_port":"'"$ZOMBIE_PORT"'", "pcol":"'"$PROTOCOL"'" }'
 * DELETE /api/v0.2/zombies/$ZOMBIE_NAME/portforward/ssh/?ports=$ZOMBIE_PORT/"

#### Miscellaneous
 * GET  api/v0.2/devices/$DEVICE/labcontrollers/

