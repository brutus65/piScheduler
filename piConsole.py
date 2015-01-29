#!/usr/bin/env python
'''
    Copyright (C) 2014 gWahl

    'piConsole' is used with 'piSchedule' a python extension for pilight.
      Installed on RaspberryPI together with pilight it supports time scheduled
      switching of devices 
      'piConsole.py' passes commands or the name of a file which contains
      commands to be processed by 'piSchedule'.

    'Calling'  ./piConsole.py [argument]

    'piSchedule.MD'  more details and descriptions
'''
# ----------------------------------------------------
from __future__ import print_function

import sys
from multiprocessing.connection import Client
import json

import piDiscover


if len(sys.argv) == 2:
    message = sys.argv[1]
else:
    message = 'piConsole : ' + str(datetime.datetime.now())


responses = piDiscover.piDiscover("urn:schemas-upnp-org:service:pilight:1");
prefs = responses[1]

_server  = responses[0].strip()
_port = int(prefs['port_pilight'])+1

#print("    piConsole   server:port :",_server, ":", _port)
address = (_server, _port)

conn = Client(address, authkey=piDiscover.authKey())
conn.send(message)

recv = conn.recv()  #.strip()
print("    piConsole  rv: ", recv)

conn.close()
