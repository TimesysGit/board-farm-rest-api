## EBF-CLI Commands

### login

For login into EBF Server, required only first time. If you want to change EBF-server or change the User-credentials then use the "ebf login" command and follow the instructions.

*From Command line terminal:*

```
$ ebf login
```

*Example:*

```
$ ebf login

Provide the EBF-Server IP and Credentials.
```

### list

#### config

Provide the details about the EBF-Server and User configured for EBF-CLI.

*From Command line terminal*:

```
$ ebf list config
```

*Example:*
```
$ ebf list config

 UserName:       admin
 BFC-SERVER:     https://172.16.30.143
 BFC AUTH-Token: rst33j46n50iusq06t3bj9w0mhq0uph8kadup3dybsunm8r54inqptbxror
```

#### devices

Provide the list of all the active devices in EBF-server.

*From Command line terminal*:

```
$ ebf list devices
```

*Example:*
```
$ ebf list devices

1 TestServer_AppZombie-93
2 android-rpi001
3 bbb02
```

### mydevices

Provide the list of devices assigned to the current User.

*From Command line terminal*:

```
$ ebf mydevices
```

*Example:*
```
$ ebf mydevices

1 android-rpi001
2 bbb02
```

### fmanager

#### ls

List the content of the EBF-FileManager Directory or sub-directory.

*From Command line terminal*:

```
$ ebf fmanager ls <Directory PATH [Optional]>
```

*Example:*
```
$ ebf fmanager ls

admin                          Directory  lavaserver   4.0K     Dec 10, 2020 05:44:15 AM
ankit                          Directory  lavaserver   4.0K     Dec 15, 2020 05:03:03 PM
ankit.gupta                    Directory  lavaserver   4.0K     Dec 14, 2020 05:16:03 PM
```


#### mkdir

Create a directory inside the EBF-FileManager directory or sub-directory.

*From Command line terminal*:

```
$ ebf fmanager mkdir <directory-name>
```

*Example:*
```
$ ebf fmanager mkdir tmp

Successfully Folder Created
```

#### rm

Delete a directory inside the EBF-FileManager directory or sub-directory.

*From Command line terminal*:

```
$ ebf fmanager rm <Directory PATH>
```

*Example:*
```
$ ebf fmanager rm tmp

Successfully Content deleted
```

#### upload

Copy files to EBF-FileManager directory or sub-directory.

*From Command line terminal*:

```
$ ebf fmanager upload [SRC_FILE_PATH] [DST_FILE_PATH]
```

*Example:*
```
$ ebf fmanager upload /home/tmp/file1.txt tmp/

Successfully File Uploaded.
```

#### download

Download a file from EBF-FileManager Directory to a local machine.

*From Command line terminal*:

```
$ ebf fmanager upload [SRC_FILE_PATH] [DST_FILE_PATH]
```

*Example:*
```
$ ebf fmanager download tmp/file1.txt /home/tmp/

Successfully Downloaded "tmp/file1.txt" into "/home/tmp/file1.txt"
```

### version

To see the Current version of EBF-CLI installed.

*From Command line terminal*:

```
$ ebf version
```

*Example:*
```
$ ebf version

1.0.1
```

### Device-Management

#### status

Provide device allocation details, currently assigned to someone or free.

*From Command line terminal*:

```
$ ebf <device-name> status
```

*Example:*

```
$ ebf bbb02 status

Device "bbb02" is assigned to user "admin"
```

#### allocate

Allocate a device to the current User.

*From Command line terminal*:

```
$ ebf <device-name> allocate
```

*Example:*

```
$ ebf bbb02 allocate

Device is assigned to user "admin"
```

#### release

Release a device assigned to the current User.

*From Command line terminal*:

```
$ ebf <device-name> release
```

*Example:*

```
$ ebf bbb02 release

Device "bbb02" is Released and available to Use.
```

##### force

Release a device assigned to Other Users.

*From Command line terminal*:

```
$ ebf <device-name> release force
```

*Example:*

```
$ ebf bbb02 release force

Device "bbb02" is Released and available to Use.
```

#### info

Provides information of a Device like Zombie's, Power port, Power commands, TFTP, NFS dir, etc.

*From Command line terminal*:

```
$ ebf <device-name> info
```

*Example:*

```
$ ebf bbb02 info

            ************************  
            *  Device Information  *  
            ************************  
 
 Hostname:                 bbb02
 Device Port:              1
 IOCX Status:              false
 Zombie Name:              Zombie1
 Zombie IP:                172.16.30.93
 ZOMBIE_URL:               http://172.16.30.93/
 Powe Switch:              Ankit-Home-Power-Switch
 Power Switch Port:        4
 Power Switch Commands:    on off reboot My-CMD
 TFTP DIR:                 upload/DUT1
 NFS DIR:                  /var/lib/lava/dispatcher/tmp/nfs/DUT1/tmp
```

#### power

##### status

Provides the current power status of a device.

*From Command line terminal*:

```
$ ebf <device-name> power status
```

*Example:*

```
$ ebf bbb02 power status

Device "bbb02" is Powered "ON"
```


##### on

Power ON the device

*From Command line terminal*:

```
$ ebf <device-name> power on
```

*Example:*

```
$ ebf bbb02 power on

Device "bbb02" is Powered "on"
```


##### off

Power OFF the device

*From Command line terminal*:

```
$ ebf <device-name> power off
```

*Example:*

```
$ ebf bbb02 power off

Device "bbb02" is Powered "off"
```


##### reboot

Power REBOOT the device

*From Command line terminal*:

```
$ ebf <device-name> power reboot
```

*Example:*

```
$ ebf bbb02 power reboot

Device "bbb02" is Powered "reboot"
```


##### user-defined-command

Any other Power supported user-defined command

*From Command line terminal*:

```
$ ebf <device-name> power <user-deined-command>
```

*Example:*

```
$ ebf bbb02 power my-cmd
```


#### hotplug

##### status

Provides the current Hotplug status whether it is connected to the device side or Not.

*From Command line terminal*:

```
$ ebf <device name> hotplug [1-4] status
```

*Example:*

```
$ ebf bbb02 hotplug 1 status

Device "bbb02" Hotplug port "1" is currently "off"
```

##### on

Connect hotplug to the Device side.

*From Command line terminal*:

```
$ ebf <device name> hotplug [1-4] on
```

*Example:*

```
$ ebf bbb02 hotplug 1 on

Device "bbb02" Hotplug port "1" is switched "on"
```

##### off

Disconnect hotplug from Device.

*From Command line terminal*:

```
$ ebf <device name> hotplug [1-4] off
```

*Example:*

```
$ ebf bbb02 hotplug 1 off

Device "bbb02" Hotplug port "1" is currently "off"
```

##### switch

Toggle the current state of a particular hotplug.

*From Command line terminal*:

```
$ ebf <device name> hotplug [1-4] switch
```

*Example:*

```
$ ebf bbb02 hotplug 1 switch

Device "bbb02" Hotplug port "1" is currently "on"
```

#### portfw

##### list

Provides a list of all the IP rules forwarded on a Zombie.

*From Command line terminal*:

```
$ ebf <device name> portfw list
```

*Example:*

```
$ ebf bbb02 portfw list

Rule 1
 Device IP: 192.168.111.10
 Zombie Protocol: tcp
 Zombie Port: 8022  -->  Device Port: 22

Rule 2
 Device IP: 192.168.111.10
 Zombie Protocol: tcp
 Zombie Port: 8023  -->  Device Port: 23

Rule 3
 Device IP: 192.168.111.10
 Zombie Protocol: tcp
 Zombie Port: 8024  -->  Device Port: 24
```

##### add

To add a new port forward rule.

*From Command line terminal*:

```
$ ebf <device name> portfw add <device-ip> <dut-port> <zombie-port> <protocol>
```

*Example:*

```
$ ebf bbb02 portfw add 192.168.111.10 22 8022 tcp

Successfully Forwarded the port
```

##### remove

To Delete a new port forward rule.

*From Command line terminal*:

```
$ ebf <device name> portfw remove <device-ip> <dut-port> <zombie-port> <protocol>
```

*Example:*

```
$ ebf bbb02 portfw remove 192.168.111.10 22 8022 tcp

Successfully Deleted the port forwarded rule
```

#### serial

##### run

Run a command on a device and Display its OUTPUT using the serial console.

*From Command line terminal*:

```
$ ebf <device name> serial run [COMMAND]
```

*Example:*

```
$ ebf bbb02 serial run "ls -la /"
```

##### download

Download a file to a local system from a device using the serial console.

*From Command line terminal*:

```
$ ebf <device name> serial download "<file-or-dir-path-at-device>" "<destination-path>"
```

*Example:*

```
$ ebf bbb02 serial download /tmp/test.txt ./
```

##### upload

Upload a local file to a device using the serial console.

*From Command line terminal*:

```
$ ebf <device name> serial upload "<src-file-or-dir>" "<upload-path-at-device>"
```

*Example:*

```
$ ebf bbb02 serial upload test.txt /tmp/
```

#### ssh

##### run

Run a command on a device and Display its OUTPUT using ssh.

*From Command line terminal*:

```
$ ebf <device name> ssh run [COMMAND]
```

*Example:*

```
$ ebf bbb02 ssh run "date"

Thu Jan 1 00:18:17 UTC 1970
```

##### download

Download a file to a local system from a device using SSH.

*From Command line terminal*:

```
$ ebf <device name> ssh download "<file-or-dir-path-at-device>" "<destination-path>"
```

*Example:*

```
$ ebf bbb02 ssh download /tmp/test.txt ./

Successfully Downloaded "/tmp/test.txt" into "./"
```


##### upload

Upload a local file to a device using SSH.

*From Command line terminal*:

```
$ ebf <device name> ssh upload "<src-file-or-dir>" "<upload-path-at-device>"
```

*Example:*

```
$ ebf bbb02 ssh upload test.txt /tmp/

Successfully File Uploaded.
```

##### import-key

To import Zombie ssh-key into Zombie for password-less operations.

*From Command line terminal*:

```
$ ebf <device name> ssh import-key <device-ip> <username> <password>
```

*Example:*

```
$ ebf bbb02 ssh import-key 192.168.111.10 root root

Successfully Zombie SSH-KEY Imported to "bbb02"
```

#### console

Provides access to device serial console.

*From Command line terminal*:

```
$ ebf <device name> console
```

*Example:*

```
$ ebf bbb02 console

Press 'Ctrl + ]' to Escape from Serial Console Session  0:telnet*
```


#### gpio

##### read_mask

*From Command line terminal*:

```
$ ebf <device name> gpio [COMMANDS] [GPIO PIN PATTERN] [GPIO_PIN_DATA/OPTIONAL]

Commands             GPIO Pin Pattern       GPIO Pin Data
  set_mode_mask          1-255                  0-255
  get_mode_mask          1-255
  write_mask             1-255                  0-255
  read_mask              1-255
  set_mode               1-8                    {read,write}
  get_mode               1-8
  read                   1-8
  write                  1-8                    0-1
```


##### get_mode

*From Command line terminal*:

```
$ ebf <device name> gpio [COMMANDS] [GPIO PIN PATTERN] [GPIO_PIN_DATA/OPTIONAL]

Commands             GPIO Pin Pattern       GPIO Pin Data
  set_mode_mask          1-255                  0-255
  get_mode_mask          1-255
  write_mask             1-255                  0-255
  read_mask              1-255
  set_mode               1-8                    {read,write}
  get_mode               1-8
  read                   1-8
  write                  1-8                    0-1
```

##### get_mode_mask

*From Command line terminal*:

```
$ ebf <device name> gpio [COMMANDS] [GPIO PIN PATTERN] [GPIO_PIN_DATA/OPTIONAL]

Commands             GPIO Pin Pattern       GPIO Pin Data
  set_mode_mask          1-255                  0-255
  get_mode_mask          1-255
  write_mask             1-255                  0-255
  read_mask              1-255
  set_mode               1-8                    {read,write}
  get_mode               1-8
  read                   1-8
  write                  1-8                    0-1
```

##### read

*From Command line terminal*:

```
$ ebf <device name> gpio [COMMANDS] [GPIO PIN PATTERN] [GPIO_PIN_DATA/OPTIONAL]

Commands             GPIO Pin Pattern       GPIO Pin Data
  set_mode_mask          1-255                  0-255
  get_mode_mask          1-255
  write_mask             1-255                  0-255
  read_mask              1-255
  set_mode               1-8                    {read,write}
  get_mode               1-8
  read                   1-8
  write                  1-8                    0-1
```

##### set_mode_mask

*From Command line terminal*:

```
$ ebf <device name> gpio [COMMANDS] [GPIO PIN PATTERN] [GPIO_PIN_DATA/OPTIONAL]

Commands             GPIO Pin Pattern       GPIO Pin Data
  set_mode_mask          1-255                  0-255
  get_mode_mask          1-255
  write_mask             1-255                  0-255
  read_mask              1-255
  set_mode               1-8                    {read,write}
  get_mode               1-8
  read                   1-8
  write                  1-8                    0-1
```

##### write_mask

*From Command line terminal*:

```
$ ebf <device name> gpio [COMMANDS] [GPIO PIN PATTERN] [GPIO_PIN_DATA/OPTIONAL]

Commands             GPIO Pin Pattern       GPIO Pin Data
  set_mode_mask          1-255                  0-255
  get_mode_mask          1-255
  write_mask             1-255                  0-255
  read_mask              1-255
  set_mode               1-8                    {read,write}
  get_mode               1-8
  read                   1-8
  write                  1-8                    0-1
```

##### set_mode

*From Command line terminal*:

```
$ ebf <device name> gpio [COMMANDS] [GPIO PIN PATTERN] [GPIO_PIN_DATA/OPTIONAL]

Commands             GPIO Pin Pattern       GPIO Pin Data
  set_mode_mask          1-255                  0-255
  get_mode_mask          1-255
  write_mask             1-255                  0-255
  read_mask              1-255
  set_mode               1-8                    {read,write}
  get_mode               1-8
  read                   1-8
  write                  1-8                    0-1
```

##### write

*From Command line terminal*:

```
$ ebf <device name> gpio [COMMANDS] [GPIO PIN PATTERN] [GPIO_PIN_DATA/OPTIONAL]

Commands             GPIO Pin Pattern       GPIO Pin Data
  set_mode_mask          1-255                  0-255
  get_mode_mask          1-255
  write_mask             1-255                  0-255
  read_mask              1-255
  set_mode               1-8                    {read,write}
  get_mode               1-8
  read                   1-8
  write                  1-8                    0-1
```

#### list

##### labcontrollers

List all the lab controllers assigned to a device.

*From Command line terminal*:

```
$ ebf <device name> list labcontrollers
```

*Example:*

```
$ ebf bbb02 list labcontrollers

Controller : 1
 ID              : Zombie1
 Controller Type : gpio_controller
```

#### netboot

##### ls

List the content of Network Boot Directory, by default it shows the content of Network-boot directory assigned to that device e.g. if the device is connected to port-1 then it will show the content of NFS-directory "DUT1". You can also provide a directory or sub-directory inside the DUT1 folder.


*From Command line terminal*:

```
$ ebf <device name> netboot ls [DIR_NAME_OPTIONAL]
```

*Example:*

```
$ ebf bbb02 netboot ls

  mrootfs                        Directory  root         4.0K     Nov 24, 2020 08:43:26 PM
```

##### mkdir

Create a directory inside Network Boot Directory, by default it will create a directory inside the Network-boot directory assigned to that device e.g. if the device is connected to port-1 then it will create a directory inside the NFS-directory "DUT1". You can also create a directory or sub-directory inside a folder.

*From Command line terminal*:

```
$ ebf <device name> netboot mkdir [DIR_NAME]
```

*Example:*
```
$ ebf bbb02 netboot mkdir tmp

Successfully Directory "tmp" created
```

##### rm

Delete a directory inside Network Boot Directory, by default it will delete the directory inside the Network-boot directory assigned to that device e.g. if the device is connected to port-1 then it will delete the directory inside the NFS-directory "DUT1". You can also delete a directory or sub-directory inside a folder.


*From Command line terminal*:

```
$ ebf <device name> netboot mkdir [DIR_NAME]
```

*Example:*
```
$ ebf bbb02 netboot rm tmp

Successfully Directory "tmp" deleted
```


##### transfer

*From Command line terminal*:

```
$ ebf <device name> netboot transfer [local|server|status|remove] [OPTIONS]

Description
   local|server     Extract or copy a File/Dir from local system or EBF-Server
                    into a Network-Boot Directory or sub-directory.
   status [JOB-ID]  it will provide the status off all the transfer jobs in running or queue state
                    You can also check the status of a single job using transfer Job-ID.
   remove [Job-ID]  It will cancel the jobs and remove it from the list

Option Includes:
  *   -f | --file          - path of a local file or EBF-Server
      -t | --tool          - provide tool from [tar, cp, unzip] to transfer a file
      -d | --dir           - Name of a directory in which you want to extract rootfs default is "fsroot"
      -a | --cmd-args      - any arguments you want to provide with transfer tool selected
      -r | --remove-after  - This will delete file from EBF-Server after transferring value should be "on/off"

  *  Indicates Mandatory Arguments
```

*Example:*
```
1. ebf bbb01 netboot transfer local -f /tmp/hello.txt
2. ebf bbb01 netboot transfer local -f /tmp/hello.txt -d fsroot
3. ebf bbb01 netboot transfer local -f /tmp/rootfs.tar.gz -d my-rootfs -t tar -a xz -r on
4. ebf bbb01 netboot transfer server -f rootfs.tar.gz -d my-rootfs -t tar -a xz -r on
5. ebf bbb01 netboot transfer status
6. ebf bbb01 netboot transfer status 04366c6a-fde2-424d-9aea-1174cb24650d
7. ebf bbb01 netboot upload remove 04366c6a-fde2-424d-9aea-1174cb24650d
```

##### download

Download a file from Network Boot Directory to the local machine.

*From Command line terminal*:

```
$ ebf <device name> netboot download <src-file-path> <dst-file-path>
```

*Example:*

```
$ ebf bbb02 netboot download tmp/file1.txt /home/tmp/

Successfully Downloaded "tmp/file1.txt" into "/home/tmp/file1.txt"
```


##### upload

Upload a file from Local Machine to Network Boot Directory.

*From Command line terminal*:

```
$ ebf <device-name> netboot upload [SRC_FILE_PATH] [DST_FILE_PATH]
```

*Example:*

```
$ ebf bbb02 netboot upload /tmp/file1.txt fsroot/

Successfully Uploaded file "/tmp/file1.txt" into "fsroot/file1.txt"
```

##### symlink

To get the status of the current symlink directory or to create a symlink to a new directory.

*From Command line terminal*:

```
$ ebf <device name> netboot symlink [DIR Name]
```

*Example-1:*

```
$ ebf bbb02 netboot symlink

Current SYMLINK_DIR : fsroot 
```

*Example-2:*

```
$ ebf bbb02 netboot symlink mrootfs

Successfully created symlink to directory mrootfs 
```

#### sdcard

##### info

Provides the SDCard information on its size, partition, etc.

*From Command line terminal*:

```
$ ebf <device name> sdcard info
```

*Example:*

```
$ ebf bbb02 sdcard info

SD CRAD Information

sdb: 59.5G
sdb1: 2G (vfat)
sdb2: 57.5G (ext4)
```

##### side

Provides whether the SDCard is connected to the Zombie side or the Device side.

*From Command line terminal*:

```
$ ebf <device name> sdcard side
```

*Example:*

```
$ ebf bbb02 sdcard side

SDCard is connected to "device" side
```

##### switch

It will connect the sdcard to the Device side or Zombie side or Switch from the current side.

*From Command line terminal*:

```
$ ebf <device name> sdcard switch [device|zombie|side]
```

*Example:*

```
$ ebf bbb02 sdcard switch zombie

SDCard is switched to "zombie" side
```

##### ls

List the content of SDCard, by default it shows the partitions of SDCard and you can provide that partition or directory inside that partition It will show the content of that directory.

*From Command line terminal*:

```
$ ebf <device name> sdcard ls [DIR_NAME_OPTIONAL]
```

*Example:*

```
$ ebf bbb02 sdcard ls sdb1

beaglebone_black.dtb           File       root         36K      Dec 17, 2020 08:20:14 PM
MLO                            File       root         108K     Dec 16, 2020 10:43:48 AM
powernet426.mib                File       root         2.5M     Dec 24, 2020 10:38:04 AM
uboot.env                      File       root         128K     Jan 01, 1980 05:30:00 AM
u-boot.img                     File       root         633K     Dec 16, 2020 05:21:22 PM
uImage-4.14-ts-armv7l          File       root         5.0M     Dec 17, 2020 08:20:08 PM
```

##### mkdir

Create a directory inside an SDCard partition, directory name is mandatory.

*From Command line terminal*:

```
$ ebf <device name> sdcard mkdir [DIR_NAME]
```

*Example:*

```
$ ebf bbb02 sdcard mkdir sdb1/tmp

Successfully Directory sdb1/tmp created
```

##### rm

Delete a directory/file inside a sdcard partition, directory, or file name is mandatory.

*From Command line terminal*:

```
$ ebf <device name> sdcard rm [DIR_NAME/FileName]
```

*Example:*

```
$ ebf bbb02 sdcard rm sdb1/tmp

Successfully Directory sdb1/tmp deleted
```

##### format

Format an SDcard partition. The format partition information should be provided in the form of "," separated of "PARTITION, PARTITION_TYPE". The below example will format Partition sda1 into vfat and sda2 into ext4.

*From Command line terminal*:

```
$ ebf <device name> sdcard format partition,partition-type
```

*Example:*

```
$ ebf bbb02 sdcard format sda1,vfat sda2,ext4

Successfully format the partitions
```

##### partition

Create and format an SDcard partition. The partition information should be provided "," separated in the form of LABEL, SIZE(MB), PARTITION_TYPE, BOOTABLE(True/FALSE). The below example will create Partition A of size 1000 MB and type Vfat and the bootable flag is set to "True" and Partition B of size 8000 MB and type ext4

*From Command line terminal*:

```
$ ebf <device name> sdcard partiion label,size,partition-type,bootable(optional)
```

*Example:*

```
$ ebf bbb01 sdcard partition A,1000,vfat,True B,8000,ext4

Successfully created the partitions
```

##### backup

Create a backup of SDCard, you can also check the progress status of a backup job and also delete a backup job.

*From Command line terminal*:

```
$ ebf <device name> sdcard backup [status|remove] [ARGS]

Description
   status [JOB-ID]  it will provide the status off all the backup jobs in running or queue state
                    You can also check the status of a single job using backup Job-ID.
   remove [Job-ID]  It will cancel the backup jobs and remove them from the list
```

*Example:*

```
1. ebf bbb01 sdcard backup (To start a SDcard Backup)
2. ebf bbb01 sdcard backup status (To see the Backup Job Queue)
3. ebf bbb01 sdcard backup status 04366c6a-fde2-424d-9aea-1174cb24650d (To check the progress status of a backup job)
4. ebf bbb01 sdcard backup remove 04366c6a-fde2-424d-9aea-1174cb24650d (To remove a backup job from the queue)
```

##### flash

Upload/Extract/Copy/Flash a rootfs/file/image to a sdcard or it's partition.

*From Command line terminal*:

```
$ ebf <device name> sdcard flash [local|server|status|remove] [OPTIONS]

Description
   local|server     Extract or copy a File/Dir from the local system or EBF-Server
                    into an SDCrad Partition or Directory.
   status [JOB-ID]  it will provide the status off all the flashing jobs in running or queue state
                    You can also check the status of a single job using upload Job-ID.
   remove [Job-ID]  It will cancel the jobs and remove them from the list

Option Includes:
  *   -f | --file            - path of a local file or EBF-Server
  *   -p | --partition       - partition in which you want to copy/flash image
      -t | --tool            - provide tool from [tar, cp, unzip, dd, zcat_dd, bmaptool] to upload/flash a file/image
      -b | --backup          - Backup SDCard befor flashing an image, valid options are [on/off]
      -m | --mkfs            - Format sdcard before flashing an image, valid options are [on/off]
      -a | --cmd-args        - any arguments you want to provide with upload tool selected
      -r | --remove-after    - This will delete file from EBF-Server after image flashing, valid options are [on/off]
   -bmap | --bmap-file       - Path of any bmap file

  *  Indicates Mandatory Arguments 
```

*Example:*

```
1. ebf bbb01 sdcard flash local -f /tmp/hello.txt -p sda1
2. ebf bbb01 sdcard flash local -f /tmp/rootfs.tar.gz -p sda2 -t tar -a xz -m on
3. ebf bbb01 sdcard flash server -f rootfs.tar.gz -p sda2 -t tar -a xz -m on -r on
4. ebf bbb01 sdcard flash server -f rootfs.tar.gz -p sda2 -t tar -a xz -m on -r on -b on
5. ebf bbb01 sdcard flash status
6. ebf bbb01 sdcard flash status 04366c6a-fde2-424d-9aea-1174cb24650d
7. ebf bbb01 sdcard flash remove 04366c6a-fde2-424d-9aea-1174cb24650d
```


##### download

Download a file from an SDCard Partition to a local machine.

*From Command line terminal*:

```
$ ebf <device name> sdcard download <src-file-path> <dst-file-path>
```

*Example:*

```
$ ebf bbb02 sdcard download tmp/file1.txt /home/tmp/

Successfully Downloaded "tmp/file1.txt" into "/home/tmp/file1.txt"
```

##### upload

Upload a file from Local Machine to an SDCard Partition.

*From Command line terminal*:

```
$ ebf <device-name> sdcard upload [SRC_FILE_PATH] [DST_FILE_PATH]
```

*Example:*

```
$ ebf bbb02 netboot sdcard /tmp/file1.txt fsroot/

Successfully Uploaded file "/tmp/file1.txt" into "fsroot/file1.txt"
```

#### usb

##### info

Provides the USB information on its size, partition, etc.

*From Command line terminal*:

```
$ ebf <device name> usb info
```

*Example:*

```
$ ebf bbb02 usb info

USB Information

sdb: 59.5G
sdb1: 2G (vfat)
sdb2: 57.5G (ext4)
```

##### side

Provides whether the USB is connected to the Zombie side or the Device side.

*From Command line terminal*:

```
$ ebf <device name> usb side
```

*Example:*

```
$ ebf bbb02 usb side

USB is connected to "device" side
```


##### switch

It will connect the USB to the Device side or Zombie side or Switch from the current side.

*From Command line terminal*:

```
$ ebf <device name> usb switch [device|zombie|side]
```

*Example:*

```
$ ebf bbb02 usb switch zombie

USB is switched to "zombie" side
```

##### ls

List the content of USB, by default it shows the partitions of USB and you can provide that partition or directory inside that partition, and It will show you the content of that directory.

*From Command line terminal*:

```
$ ebf <device name> usb ls [DIR_NAME_OPTIONAL]
```

*Example:*

```
$ ebf bbb02 usb ls sdb1

beaglebone_black.dtb           File       root         36K      Dec 17, 2020 08:20:14 PM
MLO                            File       root         108K     Dec 16, 2020 10:43:48 AM
powernet426.mib                File       root         2.5M     Dec 24, 2020 10:38:04 AM
uboot.env                      File       root         128K     Jan 01, 1980 05:30:00 AM
u-boot.img                     File       root         633K     Dec 16, 2020 05:21:22 PM
uImage-4.14-ts-armv7l          File       root         5.0M     Dec 17, 2020 08:20:08 PM
```

##### mkdir

Create a directory inside a USB partition, directory name is mandatory.

*From Command line terminal*:

```
$ ebf <device name> usb mkdir [DIR_NAME]
```

*Example:*

```
$ ebf bbb02 usb mkdir sdb1/tmp

Successfully Directory sdb1/tmp created
```

##### rm

Delete a directory/file inside a USB partition, directory, or file name is mandatory.

*From Command line terminal*:

```
$ ebf <device name> usb rm [DIR_NAME/FileName]
```

*Example:*

```
$ebf bbb02 usb rm sdb1/tmp

Successfully Directory sdb1/tmp deleted
```

##### format

Format a USB partition. The format partition information should be provided in the form of "," separated of "PARTITION, PARTITION_TYPE". The below example will format Partition sda1 into vfat and sda2 into ext4.

*From Command line terminal*:

```
$ ebf <device name> usb format partition,partition-type
```

*Example:*

```
$ ebf bbb02 usb format sda1,vfat sda2,ext4

Successfully format the partitions
```

##### partition

Create and format USB partition. The partition information should be provided "," separated in the form of LABEL, SIZE(MB), PARTITION_TYPE, BOOTABLE(True/FALSE). The below example will create Partition A of size 1000 MB and type Vfat and the bootable flag is set to "True" and Partition B of size 8000 MB and type ext4

*From Command line terminal*:

```
$ ebf <device name> usb partiion label,size,partition-type,bootable(optional)
```

*Example:*

```
$ ebf bbb01 usb partition A,1000,vfat,True B,8000,ext4

Successfully created the partitions
```

##### backup

Create a backup of USB, you can also check the progress status of a backup job and also delete a backup job.

*From Command line terminal*:

```
$ ebf <device name> usb backup [status|remove] [ARGS]

Description
   status [JOB-ID]  it will provide the status off all the backup jobs in running or queue state
                    You can also check the status of a single job using backup Job-ID.
   remove [Job-ID]  It will cancel the backup jobs and remove them from the list
```

*Example:*

```
1. ebf bbb01 usb backup (To start a USB Backup)
2. ebf bbb01 usb backup status (To see the Backup Job Queue)
3. ebf bbb01 usb backup status 04366c6a-fde2-424d-9aea-1174cb24650d (To check the progress status of a backup job)
4. ebf bbb01 usb backup remove 04366c6a-fde2-424d-9aea-1174cb24650d (To remove a backup job from the queue)
```

##### flash

Upload/Extract/Copy/Flash a rootfs/file/image to a USB or it's partition
*From Command line terminal*:

```
$ ebf <device name> usb flash [local|server|status|remove] [OPTIONS]

Description
   local|server     Extract or copy a File/Dir from local system or EBF-Server
                    into a USB Partition or Directory.
   status [JOB-ID]  it will provide the status off all the flashing jobs in running or queue state
                    You can also check the status of a single job using upload Job-ID.
   remove [Job-ID]  It will cancel the jobs and remove it from the list

Option Includes:
  *   -f | --file            - path of a local file or EBF-Server
  *   -p | --partition       - partition in which you want to copy/flash image
      -t | --tool            - provide tool from [tar, cp, unzip, dd, zcat_dd, bmaptool] to upload/flash a file/image
      -b | --backup          - Backup USB befor flashing an image, valid options are [on/off]
      -m | --mkfs            - Format USB before flashing an image, valid options are [on/off]
      -a | --cmd-args        - any arguments you want to provide with upload tool selected
      -r | --remove-after    - This will delete file from EBF-Server after image flashing, valid options are [on/off]
   -bmap | --bmap-file       - Path of any bmap file

  *  Indicates Mandatory Arguments
```

*Example:*

```
1. ebf bbb01 usb flash local -f /tmp/hello.txt -p sda1
2. ebf bbb01 usb flash local -f /tmp/rootfs.tar.gz -p sda2 -t tar -a xz -m on
3. ebf bbb01 usb flash server -f rootfs.tar.gz -p sda2 -t tar -a xz -m on -r on
4. ebf bbb01 usb flash server -f rootfs.tar.gz -p sda2 -t tar -a xz -m on -r on -b on
5. ebf bbb01 usb flash status
6. ebf bbb01 usb flash status 04366c6a-fde2-424d-9aea-1174cb24650d
7. ebf bbb01 usb flash remove 04366c6a-fde2-424d-9aea-1174cb24650d
```

##### download

Download a file from a USB Partition to a local machine.

*From Command line terminal*:

```
$ ebf <device name> usb download <src-file-path> <dst-file-path>
```

*Example:*

```
$ ebf bbb02 usb download tmp/file1.txt /home/tmp/

Successfully Downloaded "tmp/file1.txt" into "/home/tmp/file1.txt"
```


##### upload

Upload a file from Local Machine to a USB Partition.

*From Command line terminal*:

```
$ ebf <device-name> usb upload [SRC_FILE_PATH] [DST_FILE_PATH]
```

*Example:*

```
$ ebf bbb02 netboot usb /tmp/file1.txt fsroot/

Successfully Uploaded file "/tmp/file1.txt" into "fsroot/file1.txt"
```

#### uboot

##### flash

Flash a u-boot from local machine to a device using serial connection through Xmodem/Ymodem/Zmodem

*From Command line terminal*:

```
$ ebf <device name> uboot flash -f <uboot file path> -p<xmodem/ymodem/zmodem>
```

*Example:*

```
$ ebf bbb01 uboot flash -f /home/user/u-boot-spl.bin-cmm-2019.01+gitAUTOINC+4fa6070cdd-r32 -p ymodem
```
