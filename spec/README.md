# REST APIs

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

**OpenAPI specification**

```
openapi: 3.0.0
info:
  title: Generated for BFC-TAS
  version: '0.2'
paths:
  https://bfc.timesys.com/api/rpi4_gpio/gpio/write_mask/255/255:
    get:
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
```

**TO Be Defined**
- [ ] Error codes
- [ ] Error conditions and standardized error messages

