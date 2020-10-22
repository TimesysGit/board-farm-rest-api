# Board Farm REST API

## Project

For years, designers of automated testing systems have used ad-hoc
designs for the interfaces between a test, the test framework and board
farm software, and the device under test. This has resulted in a
situation where hardware tests cannot be reused from one lab to another.

This project exists to create standard APIs between automated tests
and board farm management software. The idea is to allow a test to query
the farm about available bus connections, attached hardware and
measurement devices, and other test installation infrastructure. The
test can then allocate and use that hardware, in a lab-independent
fashion. The proposal calls for a dual REST/command-line API, with
support for discovery, control and operation of hardware and network
resources. It is hoped that establishing a standard in this area will
allow for the creation of an ecosystem of shareable hardware tests and
board farm software.

## Problem Statement
* There are many tests but no standardized way of running tests on physical devices
* There are many different Test Frameworks
* There are a few Board Farm frameworks but there is no standardized way to use different Test Frameworks or run tests
* Every farm implements test infrastructure differently
  * Many labs use ad-hoc infrastructure
  * Tests written for one lab do not work in another lab
* Nobody can share tests

## Solution
* Create a standard method to access boards and resources in a Board Farm
* This allows for:
  * Tests can be written that work in more than one lab
  * Test Frameworks can work with more than one lab
  * Board farm infrastructure technologies can evolve separately from the interface to the farm

# How to get involved

There are a few different ways to get involved with the "board farm REST
API" project.  If you are reading this, then you have found our main
repository.  We are setting up a mailing list, and will put the
information about that list here when it is ready.  In the mean time
we intend to discuss the standard on the automated testing mailing list.
You can find information about this list here:
https://elinux.org/Automated_Testing#Mailing_list

Alternatively, you can contact two of the leaders of this project
by emailing them directly at the following (spam-resistant) e-mail
addresses:
 * Harish Bansal - email: harish (dot) bansal (at) timesys (dot) com
 * Tim Bird - email: tim (dot) bird (at) sony (dot) com

Project coordination is currently being tracked on a page on the elinux
wiki: https://elinux.org/Board_Farm_REST_API

## Tasks

We have produced a working demonstration of the concept.  What we
really need now are people who can:
 * give us feedback on the concept
 * give feedback on the design of the APIs
 * test the API
 * test the reference command line tool ('ebf')

If you develop tests or a test framework, or run a board farm, and are
interested in this project, please contact us.
