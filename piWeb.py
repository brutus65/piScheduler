#!/usr/bin/env python
# -*- coding: utf-8 -*-

import datetime

import os
import shutil
import signal
import json
import glob
import urllib2

from multiprocessing.connection import Client
from bottle import route, run, get, request, post, template

import piDiscover


#-- globals
responses = piDiscover.piDiscover("urn:schemas-upnp-org:service:pilight:1");

server = responses[0]
port = int(responses[1]['port_pilight'])+1
port0 = int(responses[1]['port_pilight'])
address = (server, port)



def getConfig():
# ---------------------------
   jConfig = '/etc/pilight/config.json'
   
   try:
      confFile = open(jConfig, 'r')

   except:
      msg ("  ***  pilight 'configure' file '", jConfig, 
        "' not found! (Check access rights!")
      print (msg)
      return msg

   return json.loads(confFile.read())



def getConfig1(typ):
# ---------------------------
    #  jConfig = '/etc/pilight/config.json'
    #  need to access the 'port' from global

    global server, port0

    message = 'config'
    url = ('http://' + server + ':' + port0 + '/'  + message)

    request = urllib2.Request(url)
    response = urllib2.urlopen(request).read()
    return  json.loads(urllib2.unquote(response))[typ]


def getConn(code):
    global address

    conn = Client(address, authkey=piDiscover.authKey())
    qString = request.query_string

    rv = {}
    rv['cn'] = conn
    rv['qStr'] = qString
    return rv


@route('/')
@post('/')
def login_check():
    message =  "-prefs"

    # build 'ini' file menu for edit
    fHtml = '<li role="presentation"><a href="/edit?&&fName&&">&&fName&&</a></li>'

    iniFiles =  sorted(glob.glob("*.ini"))
    print("&---- iniFiles:" +str(iniFiles))

    fileList = "<a role='menuitem' >&nbsp;&nbsp; Edit Schedule... </a>"
    for x in iniFiles:
       fileList += fHtml.replace('&&fName&&',x)

    fileList += "</li><li role='presentation'><a href='/edit?newSchedule'>New Schedule</a></li>"
    fileList += "<li class='divider'></li><li role='presentation'><a href='/edit?addJob'>Add 'Job' to Day Schedule</a></li>"

    rv = {'pilight':'http://'+str(server)+':'+str(port-1)}
    page = template('piMain', rv)
    page = page.replace('&&iniFileList&&',fileList)
    return page


@route('/LogID')
def logid():
    message =  "-prefs"

    conn = getConn(True)
    if type(conn) == type(str()):
        print (conn + " " + message)
        return conn
    conn['cn'].send(message)

    rv = conn['cn'].recv()
    return template('piLogin', rv)


@route('/prefs')
@post('/prefs')
def _prefs():

    message =  "-prefs"

    conn = getConn(None)
    if type(conn) == type(str()):
        print ("  piWeb - ", conn + " " + message)
        return conn
    conn['cn'].send(message)

    rv  = conn['cn'].recv()

    print ("&--- prefs ---:", str(rv))

    part1 = template('piPrefs', rv)

    hString = str(datetime.datetime.now())[10:19]
    part1 = part1.replace('&&datetime&&', hString)
    part1 = part1.replace('&&timeTable&&', jobs()).replace('\n','')
    return (part1)


@route('/close')
def close():
    message =  "-close"

    conn = getConn(None)
    if type(conn) == type(str()):
        print (conn + " " + message)
        return conn
    conn['cn'].send(message)

    rv  = conn['cn'].recv()
    msg = "  piWeb - Send to piSchedule!  message: " + rv

    os.kill(os.getpid(), signal.SIGTERM)
    #return msg


@route('/jobs')
def jobs():
    message =  "-jobs"    

    conn = getConn(None)
    qString = conn['qStr']
    print (" request :" + qString)

    if type(conn) == type(str()):
        print (conn + " " + message)
        return conn
    conn['cn'].send(message)

    rv  = conn['cn'].recv()
    rJobs = json.loads(rv)

    tablebody = '<table class="table table-striped table-bordered"><tbody>'

    n = 0
    output = []
    for n in (rJobs):
       jTime = rJobs[n]['jTime']
       jDetail = rJobs[n]['jDetail']
       #print ("&&--  piWeb  job : " + str(n) + str(jTime) + "  " + str(jDetail))

       output.append("<tr><td> " + str(jTime) + "</td><td> " + str(jDetail) + "</td></tr> ")

    output.sort()

    output = tablebody + str(output) + '</tbody></table>'
    jString = str(output).replace("', '","").replace("']","").replace("['","")
    return (jString)


@post('/logs')
def logs():

    now = datetime.datetime.now()
    today = now.strftime("%A")

    logList()
    rv = {'logList':'', 'today':today, 'selectedDay':''}
    return template('piLogs', rv)


@route('/logs')
@post('/logList')
def logList():

    conn = getConn(None)
    qString = conn['qStr']
    selectedDay = qString.strip()
 
    now = datetime.datetime.now()
    today = now.strftime("%A")
    if selectedDay == "":
        selectedDay = today

    fLog = '/home/pi/piScheduler/' + selectedDay +'.log'

    try:
       logs = open(fLog, 'r')

    except:
       msg = ("  ***  pilight 'log' file '", fLog,
        "' not found! (Check access rights!)")
       print (msg)
       return msg

    output = []

    for line in logs:
      output.append('<li>' + line.replace("\n","") + '</li>')

    output.sort(reverse=True)

    output = '<ul>' + str(output) + '</ul>'
    output = str(output).replace("', '","").replace("']","").replace("['","")

    now = datetime.datetime.now()
    today = now.strftime("%A")
 
    rv = {'logList':output,  'today':today,  'selectedDay': selectedDay}
    return template('piLogs', rv)


#----------------------------------------------
@route('/control')
def pilightControl():
    message =  "-control"

    conn = getConn(None)
    qString = conn['qStr']
    if type(conn) == type(str()):
        print (conn + " " + message)
        return conn
    conn['cn'].send(message + qString)

    rv  = conn['cn'].recv()
    return (str(rv))

#------------------------------------------------
@route('/edit')
@post('/edit')
def edit():
    message =  "-prefs"
    addJob = False

    conn = getConn(None)
    if type(conn) == type(str()):
        print ("  piWeb - ", conn + " " + message)
        return conn
    conn['cn'].send(message)

    rv  = conn['cn'].recv()
    fileName  = conn['qStr']

    page = template('piEdit', rv)


    if fileName == 'addJob':
       addJob = True    

    # build the html list of devices
    devices = getConfig1('devices')

    #<a role="menuitem" onclick="changeDevice(this)">Haustuer</a>
    deviceList = ""
    for d in devices:
       deviceList += '<a role="menuitem" onclick="changeDevice(this)">'+d+'</a>'
       #print ("&--- dev:", str(d))
    page = page.replace('&&deviceList&&', deviceList)


    # replace date/time string
    hString = str(datetime.datetime.now())[10:19]
    page = page.replace('&&datetime&&', hString)

    if addJob == True:
       page = page.replace('&&JOBS&&',"")
       page = page.replace('&&FILE&&',"")

       page = page.replace('&&jobDefEdit&&','display:none')
       page = page.replace('&&jobDefExec&&','display:block')

       page = page.replace('&&displaySchedule&&','display:none')

       page = page.replace('&&jobAdd&&','display:none')
       page = page.replace('&&jobExec&&','display:block')

    else:
       page = page.replace('&&jobDefEdit&&','display:block')
       page = page.replace('&&jobDefExec&&','display:none')

       page = page.replace('&&displaySchedule&&','display:block')

       page = page.replace('&&jobAdd&&','display:block')
       page = page.replace('&&jobExec&&','display:none')


       #  newSchedule
       if fileName == 'newSchedule':
           fileName = 'newDaySchedule.ini'
           f = open(fileName, 'w')
           f.write(' * Define new Schedule')
           f.close()

       if fileName == "" or fileName == None:
           fileName = 'piSchedule.ini'

       # read the selected 'ini' file to textbox
       jobList = jobs_read(fileName, 'piEdit')
       page = page.replace('&&JOBS&&',str(jobList))

       # set the 'ini' file name  
       page = page.replace('&&FILE&&',str(fileName))

    return (page)



@post('/fDelete')
def fDelete():
    qStr = request.query_string
    qString = json.loads(urllib2.unquote(qStr))

    fName = qString[0]['fName']
    pName = qString[1]['pName']
    if fName == "":
      fName = pName
    os.remove(fName)



@route('/fSave')
@post('/fSave')
def fSave():     
    qStr = request.query_string
    qString = json.loads(urllib2.unquote(qStr))

    fName = qString[0]['fName']
    pName = qString[1]['pName']
    if fName == "":
      fName = pName

    iniFiles =  glob.glob("*.ini")
    fileList = ""
    for x in iniFiles:
       if fName == x:
           shutil.copy2(fName, fName + '.bak')

    xjobs = qString[2]['jobs'].replace('|','\n')

    f = open(fName, 'w')
    f.write(xjobs)
    f.close()


def jobs_read(message, name):
#---------------------------------
    jobList = ""
    if message != None:

        if '.ini' in message:
           jobList =""
           jobFile = open(message, 'r')
           for cJobs in jobFile:
              #jobList = jobList + '<option onclick="editSchedule(this)">' + cJobs +'</option>'
              jobList = jobList + '<option>' + cJobs +'</option>'

    return jobList

