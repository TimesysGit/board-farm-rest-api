## Content

 * Overview
 * Jenkins plugins required
   * Build pipeline plugin
   * JUnit plugin
 * Jenkins pipeline for webapp deployment and tests execution
   * Allocate device
   * Transfer webapp to device
   * Execute UI(Selenium) tests and publish results
   * Release the device
 * Configuring jenkins pipeline


## Overview
This document describes how we can set up a Jenkins pipeline 
for CI/CD integration, that will download the webapp from a link, 
deploy and run the application on a device connected to the Timesys BoardFarm, 
executes the tests and publish the result.


## Jenkins plugins required
The below two plugins are required in order to build Jenkins pipeline, you can
install plugins from "Manage Jenkins -> Manage Plugins".

### Build pipeline plugin
This plugin provides a Build Pipeline View of upstream and downstream connected
jobs that typically form a build pipeline.

https://plugins.jenkins.io/build-pipeline-plugin/


### JUnit plugin
The JUnit plugin provides a publisher that consumes XML test reports generated 
during the builds and provides some graphical visualization of the historical test results.

https://plugins.jenkins.io/junit/



## Jenkins pipeline for webapp deployment and tests execution
For creating a jenkins job select  Jenkins -> New Item -> "jenkins Joab name" ->Freestyle Project
and after that select "execute shell" from "Build section", In execute shell we write the
actual commands and the below section describes the "execute shell" section of
each jenkins job.

### Allocate device
This Job will allocate a device on Timesys Boardfarm in which we are going to transfer and execute tests.

#### Execute shell
```
$ ebf allocate rp4
```


### Transfer webapp to device
This Job will download the web-app from a download link or you can integrate it with another Jenkins job that will build your application.


#### Execute shell
```
DEVICE="<device-name>"
EBF_USER="<username>"
EBF_PASSWORD="<password>"
ARTIFACT_URL="<webapp-download-URL>"
ZOMBIE_IP=<Zombie-IP>
DEVICE_IP=<Device-IP>
DEVICE_USERNAME=<Device Username>
DEVICE_PASSWORD=<Device Password>

## Download Web App to be tested ##
wget $ARTIFACT_URL

##" Reboot the device"
ebf $DEVICE power reboot

## Import Zombie ssh key to device so that can copy the data using SSH
ebf $DEVICE ssh import-key $DEVICE_IP $DEVICE_USERNAME $DEVICE_PASSWORD

## Transfer Web APP ##
ebf $DEVICE ssh upload $WORKSPACE/tmp/addressbook.tar.gz /tmp/
ebf $DEVICE ssh run "tar -xf /tmp/addressbook.tar.gz -C /tmp/"
```

### Execute UI(Selenium) tests and publish results
This Jenkins job first run the application on device and then execute tests on browser using selenium configured on Jenkins node.

a. Start the Web-Application

#### Execute shell
```
DEVICE="<Device-Name>"
DEVICE_IP=<Device-IP>
DEVICE_APP_PORT=<APP Running Port>
ZOMBIE_FORWARD_PORT_APP=<Zombie Port>


##### Starting the APPlication ######
ebf raspbian ssh run "sudo nohup python /tmp/addressbook/server.py &>/dev/null & disown"
ebf $DEVICE portfw add $DEVICE_IP $DEVICE_APP_PORT $ZOMBIE_FORWARD_PORT_APP tcp

```

b. Execute Tests Using Selenium

#### Execute shell
```
ZOMBIE_FORWARD_PORT_APP=<Zombie Port>
ZOMBIE_IP=<Zombie IP>

export DISPLAY=:1
export IPADDR=$ZOMBIE_IP
export PORT=$ZOMBIE_FORWARD_PORT_APP

####Cleanup the Old Test Reports #####

mkdir -p $WORKSPACE/tmp
rm -rf $WORKSPACE/tmp/* > /dev/null


#### Starting Test Execution ####
pytest --junit-xml=tmp/report.xml
```

c. Publish XML reports using Junit
1. Select "Publish Junit Test Report" under "Post Build Actions"
2. In "Test Report XML's" section enter the path of generated XML report "tmp/report.xml"

### Release the device
After Successfully tests execution this job will delete the app and release the device so that other users can use it.

#### Execute shell
```
DEVICE="<Device-name>"
DEVICE_IP=<Device-IP>
DEVICE_APP_PORT=<Device Running Port>
ZOMBIE_FORWARD_PORT_APP=<Zombie Forward Port>


### Delete Application Forward Port ####
ebf $DEVICE portfw delete $DEVICE_IP $DEVICE_APP_PORT $ZOMBIE_FORWARD_PORT_APP tcp


#### Cleanup The Application From DUT ####
APP_PID=$(ebf $DEVICE ssh run "pidof python")
ebf $DEVICE ssh run "sudo kill -9 $APP_PID"
ebf $DEVICE ssh run "rm -rf /tmp/addressbook*"


#### Power OFF & Release the Device ####
ebf $DEVICE power off
ebf $DEVICE release
```


## Configure jenkins pipeline

This jenkins pipeline consist of four jobs that will allocate a device
on Timesys boardfarm, transfer the application to device, execute tests using 
seleninum and publish the results and finally release the device so that 
the other users can use it.

1. From Jenkins Home, select "+" options in "ALL" sections.
2. Select "Build Pipeline View" option and provide a name.
3. Enter the name of first test Job "Allocate Device" in "Pipeline Flow -> layouts -> Based on upstream/downstream relationship -> Initial Job -> Allocate device".
4. Save the pipeline and on Jenkins Home page you will see the newly created pipeline.


