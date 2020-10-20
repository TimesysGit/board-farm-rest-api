# Board Farm REST API

## Project
For years, designers of automated testing systems have used ad-hoc designs for the interfaces between a test, the test framework and board farm software, and the device under test. This has resulted in a situation where hardware tests cannot be reused from one lab to another.

This project is to create standard APIs between automated tests and board farm management software. The idea is to allow a test to query the farm about available bus connections, attached hardware and monitors, and other test installation infrastructure. The test can then allocate and use that hardware, in a lab-independent fashion. The proposal calls for a dual REST/command-line API, with support for discovery, control and operation - of hardware and network resources. It is hoped that establishing a standard in this area will allow for the creation of an ecosystem of shareable hardware tests and board farm software.

## Problem Statement
* There are many tests but no standardized way of running tests on physical devices
* There are many different Test Frameworks
* There are a few Board Farm frameworks but there is no standardized way to use different Test Frameworks or run tests
* Every farm implements test infrastructure differently
  * Many labs use ad-hoc infrastructure
  * Tests written for one lab do not work in another lab
* Nobody can share tests

## Solution
* Creating a standard method to access a Board Farm allows:
  * Board farms infrastructure technologies can evolve separately from the interface to the farm
  * Tests can be written that work in more than one lab
  * Test Frameworks can work with more than one lab

## REST APIs

### GPIO API

**Endpoint URI**
```
http(s)//bfc.timesys.com/api/{DeviceName}/gpio/{gpio_command}/{gpio_pin_pattern(location)}/{gpio_pin_data}
```

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
