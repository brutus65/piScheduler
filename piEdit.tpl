<html lang="de">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">

      <title>piScheduler Edit</title>

      <!-- optional: Einbinden der jQuery-Bibliothek -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

      <!-- Latest compiled and minified CSS -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

      <!-- Optional theme -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">

      <!-- Latest compiled and minified JavaScript -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

      <script>
         $.valHooks.textarea = {
            get : function(elem) {
               return elem.value.replace(/\n/g, "|").replace(/#/g, "%23");
            }
         };

      </script>

   </head>

   <body>

      <section class="container">

         <h3 style="cursor:pointer;height:32px" id="main" title="Go to Main Menu" >
             <i> piSchedule </i><small> -- Preferences and Jobs</small>
             <button class="btn btn-default btn-sm dropdown-toggle glyphicon glyphicon-home pull-right" type="button">
             </button>
         </h3>

         <p></p>
         <table class="table table-striped table-bordered">
            <tbody>
               <tr>
                  <td><b>{{Location}}</b></td>
                  <td><b>Date / actual time</b></td>
                  <td>{{sunrise[:10]}} / &&datetime&&</td>
               </tr>
               <tr>
                  <td><b>Latitude </b> {{Latitude}}</td>
                  <td><b>Sunrise</b></td>
                  <td>{{sunrise[10:16]}}</td>
               </tr>
               <tr>
                  <td><b>Longitude </b> {{Longitude}}</td>
                  <td><b>Sunset</b></td>
                  <td>{{sunset[10:16]}}</td>
               </tr>
            </tbody>
         </table>

         <span id="jobDefTitleEdit" style="&&jobDefEdit&&">
            <h4><b>Job Definition</b>&nbsp;&nbsp;&nbsp;<small><i>Create/Add 'Day Schedule' Jobs; Edit and Remove Jobs</i></small></h4>
         </span>
         <span id="jobDefTitleExec" style="&&jobDefExec&&">
            <h4><b>Job Definition</b>&nbsp;&nbsp;&nbsp;<small><i>Create Job and add to Day Schedule</i></small></h4>
         </span>

         <!-- edit /create / delete Job definitions  etc  -->
         <div class="jumbotron" style="padding:10px">
            <div class="btn-group">
               <button class="btn btn-default btn-sm dropdown-toggle" type="button"
                  id="device" noItem
                  data-toggle="dropdown" aria-expanded="false">
                  Device &nbsp; -- &nbsp;&nbsp;&nbsp;<span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu">
                  <li role="presentation">
                     <a role="menuitem" noItem onclick="changeDevice(this)">Device&nbsp; -- &nbsp;</a>
                     &&deviceList&&
        <!--
                     <a role="menuitem" onclick="changeDevice(this)">Haustuer</a>
        -->
                  </li>
               </ul>
            </div>   <!-- device -->

            <div class="btn-group">  <!-- ON -->
               <button class="btn btn-default btn-sm dropdown-toggle" type="button"
                  id="ON"
                  data-toggle="dropdown" aria-expanded="false">
                  ON &nbsp; -- &nbsp;&nbsp;&nbsp;<span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu">
                  <li role="presentation">
                     <a role="menuitem" noItem onclick="changeTime(this,'ON')">&nbsp; -- &nbsp;</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'ON')">Time</a>
                     <a role="menuitem" sun onclick="changeTime(this,'ON')">Sunrise</a>
                     <a role="menuitem" sun onclick="changeTime(this,'ON')">Sunset</a>
                  </li>
               </ul>
            </div>   <!-- ON -->

            <div class="btn-group">   <!-- ONoffset -->
               <button class="btn btn-default btn-sm dropdown-toggle" type="button"
                  id="ONoffset"
                  data-toggle="dropdown" aria-expanded="false">
                  ONoffset &nbsp; -- &nbsp;&nbsp;&nbsp;<span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu">
                  <li role="presentation">
                     <a role="menuitem" noItem onclick="changeTime(this,'ONoffset')">&nbsp; -- &nbsp;</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'ONoffset')">+</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'ONoffset')">-</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'ONoffset')">random</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'ONoffset')">random minus</a>
                  </li>
               </ul>
            </div>   <!-- ONoffset -->

            <div class="btn-group">   <!-- OFF -->
               <button class="btn btn-default btn-sm dropdown-toggle" type="button"
                  id="OFF"
                  data-toggle="dropdown" aria-expanded="false">
                  OFF &nbsp; -- &nbsp;&nbsp;&nbsp;<span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu">
                  <li role="presentation">
                     <a role="menuitem" noItem onclick="changeTime(this,'OFF')">&nbsp; -- &nbsp;</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'OFF')">+</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'OFF')">Time</a>
                     <a role="menuitem" sun onclick="changeTime(this,'OFF')">Sunrise</a>
                     <a role="menuitem" sun onclick="changeTime(this,'OFF')">Sunset</a>
                  </li>
               </ul>
            </div>   <!-- OFF -->

            <div class="btn-group">   <!-- OFFoffset -->
               <button class="btn btn-default btn-sm dropdown-toggle" type="button"
                  id="OFFoffset"
                  data-toggle="dropdown" aria-expanded="false">
                  OFFoffset &nbsp; -- &nbsp;&nbsp;&nbsp;<span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu">
                  <li role="presentation">
                     <a role="menuitem" noItem onclick="changeTime(this,'OFFoffset')">&nbsp; -- &nbsp;</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'OFFoffset')">+</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'OFFoffset')">-</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'OFFoffset')">random</a>
                     <a role="menuitem" tControl onclick="changeTime(this,'OFFoffset')">random minus</a>
                  </li>
               </ul>
            </div>  <!-- OFFoffset -->


            <div class="btn-group pull-right">   <!--  edit Job button  -->
               <button class="btn btn-default btn-sm dropdown-toggle glyphicon glyphicon-pencil" type="button"
                  id="jobAction" title="Edit 'Job' Definition "
                  data-toggle="dropdown" aria-expanded="false"> <span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu">
                  <li role="presentation">
                     <a role="menuitem" style="cursor:pointer;" onclick="jobAction(this,'clear')">&nbsp; Clear 'Job' Definition &nbsp;</a>

                     <a role="menuitem" id="jobAdd"  style="cursor:pointer;&&jobAdd&&"  onclick="jobAction(this,'add')">&nbsp; Add 'Job' to 'Day Schedule' &nbsp;</a>
                     <a role="menuitem" id="jobExec" style="cursor:pointer;&&jobExec&&" onclick="controlGET()"  >&nbsp; Exececute 'Job' &nbsp;</a>

                     <a role="menuitem" style="cursor:pointer;" onclick="openHelp('Job')">&nbsp; 'Job' Help/Docu &nbsp;</a>
                  </li>

               </ul>
            </div>


            <!--  row with jobNo and current Job text -->
            <div style="margin-left:20px;margin-top:5px">
                <textbox id="jobNo" class="col-md-1">#</textbox></span>
                <i><textbox id="currentJob">---</textbox></i>
                <small><textbox class="pull-right" id="controlStatus">-s-</textbox></i></small>
            </div>
         </div>   <!-- edit /create / delete Job definitions  etc  -->

         <!-- Set Time   -->
         <div class="row" id="setTime" style="display:none;" >
            <div class="col-xs-1"></div>
            <div class="col-xs-6 bg-info" >

               <span placeholder=".col-xs-6" class="bg-info container">
                  <button class="btn btn-default" id="inkrementTime1" onclick="editTime(this)"> ++ </button>
                  <button class="btn btn-default" id="inkrementTime" onclick="editTime(this)"> + </button>

                  <a class="bg-info" style="color:blue;font-size:120%;" onclick="editTime(this)" status="false" id="HH">12</a> :
                  <a class="bg-info" style="color:blue;font-size:120%;" onclick="editTime(this)" status="false" id="MIN">02</a>
                  <a class="bg-info" style="color:blue;font-size:120%;" onclick="editTime(this)" status="false" id="SEC">:00</a>

                  <button class="btn btn-default" id="dekrementTime" onclick="editTime(this)"> - </button>
                  <button class="btn btn-default" id="dekrementTime1" onclick="editTime(this)"> -- </button>
                  <button class="btn btn-default" id="_setTime" onclick="changeTime(this)">
                     Set
                  </button> </span>
            </div>
         </div> <!--  Set Time -->



        <span id="daySchedule" style="&&displaySchedule&&">
        <h4><b>Day Schedule </b><small><i> &nbsp; &nbsp; Collection and Storage of Job Definitions &nbsp;&nbsp;</i></small></h4>

              <div class="jumbotron" style="padding:10px">
                 <div class="input-group pull-right" >
                    <span class="input-group-addon"><b>Schedule File</b></span>
                    <input class="form-control" id="fileName" placeholder="&&FILE&&" style="width:350px" type="text"/>
                    <button class="btn btn-default btn-sm dropdown-toggle glyphicon glyphicon-pencil pull-right " type="button" id="jobAction" title="Edit 'Day Schedule'" data-toggle="dropdown" aria-expanded="false"> <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                       <li role="presentation">
                           <a role="menuitem" id="saveDaySchedule" onclick="saveIt()" disabled="disabled">&nbsp; Save this 'Day Schedule'</a>
                           <a role="menuitem" onclick="deleteIt()">&nbsp; Delete this 'Day Schedule'</a>
                           <hr/>
                           <a role="menuitem" onclick="jobAction(this,'read')">&nbsp; Edit selected 'Job' &nbsp;</a>
                           <a role="menuitem" onclick="jobAction(this,'delete')">&nbsp; Delete selected 'Job' &nbsp;</a>
                           <a role="menuitem" onclick="jobAction(this,'up')">&nbsp; Shift up the selected 'Job'  &nbsp;</a>
                           <a role="menuitem" onclick="jobAction(this,'down')">&nbsp; Shift down the selected 'Job' &nbsp;</a>
                           <a>  </a>
                          <a role="menuitem" onclick="openHelp('editSchedule')">&nbsp; 'Edit Job/Schedule' Help/Docu &nbsp;</a>

                        </li>
                    </ul>
                </div><!-- /input-group -->

              <!--   List of ini entries -->
              <select id="jobsList"  class="form-control" size="10">
                  &&JOBS&&
              </select>
           </div><!-- jumbotron-->
        </span>  <!-- daySchedule -->

     </section>


     <script>

        function controlGET() {
           $.get('/control', $('#currentJob').text(), function(data, status) {
              $('#controlStatus').html(status)
           });
        };

        function openHelp(name) {
           var main = "https://dl.dropboxusercontent.com/u/35444930/piScheduler_doc_0.3/"

           switch (name) {
              case 'Job':  window.open(main + "piScheduleFeatures.md.html",'_blank');break;
              case 'DaySchedule':  window.open(main + "piScheduleOverview.md.html",'_blank');break;
              case 'editSchedule':  window.open(main + "piScheduleEdit.md.html",'_blank');break;
           }
        }


        function clearButton(name, title) {
           var button = $('#' + name )
           button.removeAttr('value')
           button.html(title + ' &nbsp; -- &nbsp;&nbsp;&nbsp;<span class="caret"></span>')
        }

        function checkButton(button) {
           return !($('#' + button)[0].attributes.value == null)
        }


        /**
         *  write a 'job' line to Job Definition  and parse it for buttons
        **/
        function jobSetup (job, jobNo) {
           $('#currentJob').html(job)
           $('#jobNo').html('#' + jobNo)

           //parse job to get: device/on/onOffset/off/offOffset
           var sArray = job.split(";")

           if (sArray.length > 0) {
               // first item can't be 'on' or 'off'
               if ((sArray[0].substring(0,2).toLowerCase() == 'on') 
                    || (sArray[0].substring(0,3).toLowerCase() == 'off')){
                  alert ('Schedule Job definition Error: No Device!\n' + sArray[0])
                  return
               }
               var device = sArray[0].trim()
               var onOff="", onTime="", onOffset="", offTime="", offOffset="";

               for (var i = 1; i < sArray.length; i++) {
                   var cItem = sArray[i].trim()
                   var aItems = cItem.split(",")

                   if (aItems.length > 0) {
                      for (var j=0; j < aItems.length; j++) {
                         var arg = aItems[j].trim()
                         if ((arg == 'on') || (arg == 'off')) onOff = arg

                         if (onOff == 'on') {
                            if ((arg == 'sunrise') || (arg == 'sunset')) onTime = arg
                            else if ((arg[0] == '+') || (arg[0] == '-') || (arg[0] == '~')) {
                               onOffset = arg
                            } else {
                               onTime = arg
                            } 
                         }

                         if (onOff == 'off') {
                            if ((arg == 'sunrise') || (arg == 'sunset')) offTime = arg

                            else if ((offTime == "") && (arg[0] == '+')) {
                                   offTime = arg
                                }
                                else if ((offTime != "") && ((arg[0] == '+') || (arg[0] == '-') || (arg[0] == '~'))) {
                                   offOffset = arg
                                } else {
                                   offTime = (arg == 'off')? "" : arg
                                }
                             }
                          }
                       }
               }

               //set the buttons
               $('#device').html('<b>' + device + ' &nbsp;&nbsp;</b><span class="caret"></span>')
               $('#device').attr('value', device)

               $('#ON').html('<b>ON ' + ' &nbsp;'+ onTime + '&nbsp;</b><span class="caret"></span>')
               $('#ON').attr('value', onTime)

               $('#ONoffset').html('<b>ONoffset ' + ' &nbsp;'+ onOffset+ '&nbsp;</b><span class="caret"></span>')
               $('#ONoffset').attr('value', onOffset)

               $('#OFF').html('<b>OFF ' + ' &nbsp;'+ offTime + '&nbsp;</b><span class="caret"></span>')
               $('#OFF').attr('value', offTime)

               $('#OFFoffset').html('<b>OFFoffset ' + ' &nbsp;'+ offOffset + '&nbsp;</b><span class="caret"></span>')
               $('#OFFoffset').attr('value', offOffset)
           }
        }


        /**
         *  get the button settings and build the 'job'
         *  @param  setJob:  if passed write to text line 
        **/ 
        function buildJob(setJob) {

           // get the ON time and offset setting
           var ON = $('#ON')[0].getAttribute('value')
           ONoffset = ""
           if (!!ON && (ON.search(' -- ') == -1)) {
               ON = ";on," + ON.toLowerCase()
               var ONoffset = $('#ONoffset')[0].getAttribute('value')
               ONoffset = (!!ONoffset) ? "," + ONoffset.toLowerCase().replace('random minus','~-').replace('random','~') : ""
           } else {
               ON = ""
           }

           // get the OFF time and offset setting
           var OFF = $('#OFF')[0].getAttribute('value')
           OFFoffset = ""
           if (!!OFF && (OFF.search(' -- ') == -1)) {
               OFF = ";off," + OFF.toLowerCase()
               var OFFoffset = $('#OFFoffset')[0].getAttribute('value')
               OFFoffset = (!!OFFoffset) ? "," + OFFoffset.toLowerCase().replace('random minus','~-').replace('random','~') : ""
           } else {
               OFF = ""
           }
           var device  = $('#device')[0].textContent.trim()

           var job = device + ON + ONoffset + OFF + OFFoffset
           if (setJob != null) {
              $('#currentJob').html(job)
              $('#controlStatus').html(' -- ') 
           }
           return job
        }


        /**
        *    actions for 'Job' on Job Definition section
        *   @param  {object} eThis 
        *           {string} info: controls action,
        *              'build'  build job from buttons
        *              'read'   read from Day Schedule active line
        *              'add'    add the current job before active line
        *              'delete' delete active entry from Day Schedule
        **/
        function jobAction(eThis, info){

           if (info == 'clear') {
              clearButton('device', 'Device')
              clearButton('ON', 'ON')
              clearButton('ONoffset', 'ONoffset')
              clearButton('OFF', 'OFF')
              clearButton('OFFoffset', 'OFFoffset')

              $('#currentJob').html(' --- ')
              $('#controlStatus').html(' -- ')
              $('#jobNo').html('#')
              $('#setTime').attr('style', 'display:none')
              return
           }

           if (info == 'build') {
              var check = $('#device' )
              var device  = check[0].textContent.trim()
              if(!!check[0].attributes.noItem) {
                 alert("No device selected!")
                 return
              }
              var rv = buildJob()
       //       alert ("[jobAction]  " + info + "  >>" + rv + '<<')
              return;
           }


           // check Day Schedule if a 'job' is selected
           var jobsList = $('#jobsList')
           var jobNo = jobsList[0].selectedIndex

           if (jobNo == -1) {
               if (info == 'add') {
                   alert ("[jobAction]  " + "Select a row on 'Day Schedule' \nA new 'Job' will be inserted before that row!")
               } else {
                   alert ("[jobAction]  " + "First select a 'Job' on 'Day Schedule' for Edit / Delete!")
               }
               return;
           }

           var job = jobsList[0].selectedOptions[0].text


           // read activated job on Day Schedule and place it to Job Definition
           if (info == 'read') {
       //       alert ("[jobAction]  " + info + "  >>" + job + '<<')

              jobSetup(job, jobNo)
              return;
           }


           // add the 'Job' on job definition line to the jobsList
           if (info == 'add') {
              var cJob = $('#currentJob')[0].textContent

              //  if no Device selected, terminate
              if (checkButton('device') == false) {
                 alert (" 'Device' not defined!")
                 return;
              }

              if ((checkButton('ON') == false) && ((checkButton('OFF') == false))) {
                 alert (" Define 'ON' or 'OFF' time!")
                 return
              }
              // insert in 'Day Schedule' before activated line
              var option = document.createElement("option");
              option.text = cJob;
              document.getElementById("jobsList").add(option, jobNo);

              // jobList has changed !  ==> set "changed"
              changed = true;
           }


           if (info == 'delete') {
              //TODO   ask user if OK to delete !
              var a = jobsList
              jobsList[0][jobNo].remove()

              // jobList has changed !  ==> set "changed"
              changed = true;
           }


           //shift activate 'job' on jobsList
           if (info == 'up') {
              if (jobNo == 0) 
                 return

              var a = jobsList[0][jobNo]
              jobsList[0][jobNo].remove()
              document.getElementById("jobsList").add(a, jobNo-1);

              // jobList has changed !  ==> set "changed"
              changed = true;
           }


           //shift activate 'job' on jobsList
           if (info == 'down') {
              if (jobNo == jobsList.length-1) 
                 return

              var a = jobsList[0][jobNo]
              jobsList[0][jobNo].remove()
              document.getElementById("jobsList").add(a, jobNo+1);

              // jobList has changed !  ==> set "changed"
              changed = true;
           }

           if (changed == true) 
              $("#saveDaySchedule").removeAttr('disabled');
        }


        $('#main').on('click', function(event) {
           if (changed == true) {
              alert("This page is asking you to confirm that you want to leave - data you have entered may not be saved.")
              return
           }
           location.replace('/')
        });



        /**
           Global parameters
        **/
        var changed = false

        var fTime, offsetTyp;

        //default time values
        var ONhh = '11'
        var ONmin = '00'
        var ONsec = '00'

        var OFFhh = '12'
        var OFFmin = '00'
        var OFFsec = '00'

        var OFFSEThh = '00'
        var OFFSETmin = '25'
        var OFFSETsec = '00'


        function editTime(eThis) {
           var action = eThis.id

           function setHM(action) {
              if ((action == "HH") || (action == "MIN") || (action == "SEC")) {
                 
                 $('#HH' ).attr('style', "color:blue;font-size:120%;background-color:#D9EDF7")
                 $('#MIN').attr('style', "color:blue;font-size:120%;background-color:#D9EDF7")
                 if ((fTime != 'ON') && (fTime != 'OFF'))
                      $('#SEC').attr('style', "color:blue;font-size:120%;background-color:#D9EDF7")
                 $('#HH' ).attr('status', 'false')
                 $('#MIN').attr('status', 'false')
                 $('#SEC').attr('status', 'false')

                 $('#' + action).attr('style', "color:red;font-size:120%;background-color:#F2F5A9")
                 $('#' + action).attr('status', 'true')
              }
           }

           setHM(action);

           var aHH  = ($('#HH').attr('status') == 'true')
           var aMin = ($('#MIN').attr('status') == 'true')
           var aSec = ($('#SEC').attr('status') == 'true')

           var elem = $('#HH')
           var max = 24
           if (aMin) {
              var max = 60
              elem = $('#MIN')
           }
           if (aSec) {
              var max = 60
              var elem = $('#SEC')
           }
           var d = (max == 60)? 10 : 3

           if ((action == "inkrementTime")||(action == "inkrementTime1")) {
              if (!aHH && !aMin && !aSec)
                 setHM('HH')

              d = (action == "inkrementTime1")? d : 1
              var v = +elem[0].textContent.replace(':','') + d
              if (v > max)
                 v = 0;
              if (aSec) elem.html(':' + two(v)) 
              else  elem.html(two(v));
           }

           if ((action == "dekrementTime")||(action == "dekrementTime1")) {
              if (!aHH && !aMin && !aSec)
                 setHM('HH')

              d = (action == "dekrementTime1")? d : 1 
              var v = +elem[0].textContent.replace(':','') - d
              if (v < 0)
                 v = max - 1;
              if (aSec) elem.html(':' + two(v))
              else  elem.html(two(v));
           }

        }

        function two(num) {
           if (num < 10)
              num = '0' + num
           return num
        }


        function changeDevice(eThis) {
            var device = eThis.textContent
         //  alert(" .... change Device ... :" + device)
            $('#device').html('<b>' + device + '&nbsp;&nbsp;&nbsp;</b><span class="caret"></span>')
            if (eThis.getAttribute('noitem') == "") {
                $('#device').removeAttr('value')
            } else {
                $('#device').attr('value',device)
            }
            buildJob(true)
        }


        function setValue(eThis, which, val){
            if ((eThis.id == '_setTime') || (val == 'Sunrise') ||(val == 'Sunset')){
               var bold = '<b>'; var bold1 = '</b>'
            } else {
               var bold = ''; var bold1 = ''
            }

           if (eThis.getAttribute('noitem') == "") {
                $('#' + which).removeAttr('value')
           } else {
                $('#' + which).attr('value',val)
           }
           val = (val == 'Time')? "" : val
           $('#' + which).html(bold + which + '&nbsp;&nbsp;' + val + '&nbsp;&nbsp;&nbsp;' + bold1 
                 + '<span class="caret"></span>')
        }


        function changeTime(eThis, which) {
           if (which == null) which = fTime
           else {
              fTime = which
              offsetTyp = eThis.textContent
           }
           var sTime = eThis.textContent

           $('#setTime').attr('style', 'display:none')
           if (eThis.attributes.tControl) {
              $('#setTime').attr('style', 'display:block')
           }

           if (which == 'ON'){
               if (eThis.id == '_setTime') {
                  sTime = $('#HH')[0].textContent + ':' + $('#MIN')[0].textContent
               } else {
                  if (sTime == 'Time'){
                     $('#HH').html(ONhh)
                     $('#MIN').html(ONmin)
                  }
                  if ($('#ON')[0].value != ""){ // the 'button' has a value already
                     //TODO   make sure it's right format !!!
                     var tDetails =  $('#ON')[0].value.split(':')

                     if (sTime == 'Time') {
                        var t = new Date()
                        ONhh = t.getHours()
                     } else {
                        ONhh = tDetails[0]
                     }
                     ONmin = tDetails[1]
                     $('#HH').html(ONhh)
                     $('#MIN').html(ONmin)
                  }
               }
               $('#SEC').attr('style', 'color:blue;font-size:0%')  //don't show sec
               setValue(eThis, which, sTime)
           }

           if (which == 'ONoffset'){
               if (eThis.id == '_setTime') {
                  sTime = offsetTyp + "  " +$('#HH')[0].textContent + ':' + $('#MIN')[0].textContent 
                     + $('#SEC')[0].textContent
               } else {
                   $('#HH').html(OFFSEThh)
                   $('#MIN').html(OFFSETmin) 
                   $('#SEC').html(':'+ OFFSETsec)

                   if ($('#ONoffset')[0].value.trim() != "") {
                      var offset = $('#ONoffset')[0].value.trim()
                      if ((offset[0] == '+') || (offset[0] == '-')) {
                         offset = offset.substring(1).trim()
                      } 
                      if (offset.search('random minus') == 0) {
                         offset = offset.substring(12).trim()
                      }
                      if (offset.search('random') == 0) {
                         offset = offset.substring(6).trim()
                      }

                     //TODO   make sure 'offset' has the right format !!!  hh:mm:ss
                     var aOffset = offset.split(':') // 
                     OFFSEThh = aOffset[0];  $('#HH').html(OFFSEThh)
                     OFFSETmin = aOffset[1];  $('#MIN').html(OFFSETmin) 
                     OFFSETsec = aOffset[2];  $('#SEC').html(':'+ OFFSETsec) 
                  }
               }

               $('#SEC').attr('style', 'color:blue;font-size:120%;')
               setValue(eThis, which, sTime)
           }

           if (which == 'OFF'){
              if (eThis.id == '_setTime') {
                 sTime = $('#HH')[0].textContent + ':' + $('#MIN')[0].textContent
                 if (offsetTyp == "+") sTime = "+" + sTime
              } else {
                 $('#HH').html(OFFhh)
                 $('#MIN').html(OFFmin)

                 if ($('#OFF')[0].value.trim() != "") {
                    var Off = $('#OFF')[0].value.trim()

                    if (Off[0] == '+') {
                       Off = Off.substring(1).trim()
                    }
                    var aOff = Off.split(':')
                    if (sTime == 'Time') { 
                        var t = new Date()
                        ONhh = t.getHours()
                    } else {
                        $('#HH').html(aOff[0])
                    }
                    $('#MIN').html(aOff[1])
                 }
              }

              $('#SEC').attr('style', 'color:blue;font-size:0%')  // don't show sec
              setValue(eThis, which, sTime)
           }

           if (which == 'OFFoffset'){
              if (eThis.id == '_setTime') {
                 sTime = offsetTyp + "  " +$('#HH')[0].textContent + ':' + $('#MIN')[0].textContent 
                   + $('#SEC')[0].textContent
              } else {
                  $('#HH').html(OFFSEThh)
                  $('#MIN').html(OFFSETmin) 
                  $('#SEC').html(':'+ OFFSETsec)

                  if ($('#OFFoffset')[0].value.trim() != "") {
                     var offset = $('#OFFoffset')[0].value.trim()
                     if ((offset[0] == '+') || (offset[0] == '-')) {
                        offset = offset.substring(1).trim()
                     } 
                     if (offset.search('random minus') == 0) {
                        offset = offset.substring(12).trim()
                     }
                     if (offset.search('random') == 0) {
                        offset = offset.substring(6).trim()
                     }

                    //TODO   make sure 'offset' has the right format !!!  hh:mm:ss
                    var aOffset = offset.split(':') // 
                    OFFSEThh  = aOffset[0];  $('#HH').html(OFFSEThh)
                    OFFSETmin = aOffset[1];  $('#MIN').html(OFFSETmin) 
                    OFFSETsec = aOffset[2];  $('#SEC').html(':'+ OFFSETsec) 
                 }
              }
              $('#SEC').attr('style', 'color:blue;font-size:120%;')
              setValue(eThis, which, sTime)
           }
           buildJob(true)
        }


        /**
          *  ini File functions
        */
        function deleteIt() {
           change = false;
           var fN = $('input#fileName').val()
           var fP = $('input#fileName').attr('placeholder')
           $.post('/fDelete?[{"fName":"' + fN + '"},{"pName":"' + fP + '"}]');
           setTimeout(function() {
              location.replace('/')
           }, 100)
        };


        function saveIt() {

           var jobsList = $('#jobsList')[0]
           var jobs = ""
           var len = jobsList.length
           for (var i = 0; i < len; i++) {
              jobs += (jobsList[i].value + ((i != len) ? "|" : ""))
           }

           var fN = $('input#fileName').val()
           var fP = $('input#fileName').attr('placeholder')
           $.post('/fSave?[{"fName":"' + fN + '"},{"pName":"' + fP + '"},{"jobs":"' + jobs + '"}]');
           changed = false;
           $("#saveDaySchedule").attr('disabled', 'disabled');
        };



        $(window).on('beforeunload', function(e) {
           if (changed == true) {
              return 'You have unsaved stuff. Are you sure to leave?';
           }
        });


     </script>


     <style type="text/css">
        h3 {
           background: silver;
        }
     </style>

   </body>
</html>


