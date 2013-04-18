/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicity call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        /*var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');
        */
        console.log('Received Event: ' + id);
        
        
        
        // add the mesh
        //SimStim.addMesh('base-female-nude.obj');
        //SimStim.addMesh('SA_LD_Male_Character.obj');//SA_LD_Male_Character
        SimStim.addMesh('Femal_Base_Mesh.obj');
        SimStim.addMesh('desert.obj');
        
        
        
        
        // set coords of camera
        $('body').append('<input type="range" min="-1.0" max="1.0" step="0.01" size=3 id="cx" value="0" /><input  type="range" min="-1.0" max="1.0" step="0.01" size=3 id="cy" value="0" /><input  type="range" min="0.0" max="2.0" step="0.01" size=3 id="cz" value="1.0" />');
        $('#cx,#cy,#cz').on('change', function(){
                SimStim.setCamCoords($('#cx').val(), $('#cy').val(), $('#cz').val());
        });
        
        
        // czmera rotate
        $('body').append('<br/><input type="range" min="-100" max="100" step="1" size=3 id="rx" value="0" /><input type="range" min="-100" max="100" step="1" size=3 id="ry" value="0" /><input type="range" min="-100" max="100" step="1" size=3 id="rz" value="0" />');
        $('#rx,#ry,#rz').on('change', function(){
            SimStim.setCamRotation($('#rx').val(), $('#ry').val(), $('#rz').val());
        });
        
        // select mesh
        $('body').append('<select id="objname">\
                         <option selected="selected" value="Femal_Base_Mesh.obj">Femal_Base_Mesh.obj</option>\
                         <option value="desert.obj">desert.obj</option>\
                         </select>');
        //rotate mesh
        $('body').append('<br/><input type="range" min="-200" max="200" step="1" size=3 id="mx" value="0" /><input type="range" min="-200" max="200" step="1" size=3 id="my" value="0" /><input type="range" min="-200" max="200" step="1" size=3 id="mz" value="0" />');
        $('#mx,#my,#mz').on('change', function(){
            SimStim.setMeshRotation($('#objname').val(), $('#mx').val(), $('#my').val(), $('#mz').val());
        });
        
        // move mesh
        $('body').append('<br/><input type="range" min="-1.0" max="1.0" step="0.005" size=3 id="tx" value="0" /><input type="range" min="-1.0" max="1.0" step="0.005" size=3 id="ty" value="0" /><input type="range" min="-1.0" max="1.0" step="0.005" size=3 id="tz" value="0" />');
        $('#tx,#ty,#tz').on('change', function(){
            SimStim.setMeshCoords($('#objname').val(), $('#tx').val(), $('#ty').val(), $('#tz').val());
        });
        
        // scale mesh (all coords)
        $('body').append('<br/><input type="range" min="-10" max="10" step="0.005" size=3 id="sa" value="0" />');
        $('#sa').on('change', function(){
            var sa = $('#sa').val();
            SimStim.setMeshScale($('#objname').val(), sa, sa, sa);
        });
        
        
        /*
        window.watchID =  navigator.accelerometer.watchAcceleration(function(res){
            SimStim.setCamRotation(res.x, res.y, res.z);
        }, function(){});
        */
        
        
    }
};


