#!/usr/bin/python

import os, sys
import common as plib

measurements = {}
print "Reading current values from " + plib.TEST_LOG +"\n"
with open(plib.TEST_LOG,'r') as testlog:
    lines = testlog.readlines()

# ACME power data comes back as a wall of text, separated by " ",
# with each entry being a CSV entry of timestamp,voltage,current

# find max_power
max_power=-1.0
in_power_data=False
# ignore data outside of the marked block
for line in lines:
    if not in_power_data:
        if "START_POWER_DATA" in line:
            in_power_data = True
        continue

    if in_power_data:
        if "END_POWER_DATA" in line:
            break

    entries = line.split(" ")
    for entry in entries:
        # each entry is "something,volts,amps"
        if not entry.strip():
            continue

        try:
            timestamp, millivolts, milliamps = entry.split(",", 2)
        except ValueError:
            print "Invalid entry '%s' encountered in power data" % entry
            continue
        # skip the header
        if timestamp.strip() == "timestamp":
            continue
        try:
            power = (float(millivolts) * float(milliamps))/1000000
            if power > max_power:
                max_power = power
        except ValueError:
            print "Invalid entry '%s' encountered in power data" % entry
            continue

print("Max power=%s watts" % max_power)

# measurements[<testcase_name>] = array of measures
# each measure has name and measure
measurements["stress_workload"] = [{"name": "max_power", "measure": max_power}]

sys.exit(plib.process(measurements))
