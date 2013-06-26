var NiceRobo = Class.extend({
  init: function(params){
    var inst = this;
    this.params = params;
    document.addEventListener('deviceready', function(){
        inst.genTerrain();
        inst.test();
        
        //inst.generateTerrain();
    }, false);
  },
  test:function(){
    var inst = this;
    // add the mesh
    //SimStim.addMesh('base-female-nude.obj');
    //SimStim.addMesh('SA_LD_Male_Character.obj');//SA_LD_Male_Character
    
    
    // cam coords z
    
    var ch = inst.terrain[Math.round(inst.terrain.length*0.5)][Math.round(inst.terrain[0].length*0.5)] + 0.5;
    inst.cground = ch;
    
    SimStim.setCamCoords(0.0, ch, 5.0, function(){
        SimStim.addMesh('Femal_Base_Mesh.obj', function(){
            //inst.physics();
        });
    });
    
    
    //SimStim.addMesh('desert.obj');
    
    
    
    
    
    // set coords of camera
    $('body').append('<input type="range" min="-1.0" max="1.0" step="0.01" size=3 id="cx" value="0" /><input  type="range" min="-1.0" max="1.0" step="0.01" size=3 id="cy" value="0" /><input  type="range" min="-2.0" max="4.0" step="0.01" size=3 id="cz" value="1.0" />');
    $('#cx,#cy,#cz').on('change', function(){
            SimStim.setCamCoords($('#cx').val(), $('#cy').val(), $('#cz').val());
    });
    
    // camera rotate
    $('body').append('<br/><input type="range" min="-200" max="200" step="1" size=3 id="rx" value="0" /><input type="range" min="-200" max="200" step="1" size=3 id="ry" value="0" /><input type="range" min="-200" max="200" step="1" size=3 id="rz" value="0" />');
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
    
    // test button
    $('body').append('<br/><input type="button" id="testb" name="testb" value="Test" />');
    $('#testb').on('click', function(){
        //console.log('Ovde??');
        //SimStim.setMeshCoords('Femal_Base_Mesh.obj', '0.0', '0.0', '10.0');
        //inst.sbody.position.set(0,0,3);
        /*SimStim.getCamCoords(function(coords){
            console.log(coords);
        });
        */
    
        function getRandomArbitary (min, max) {
            return Math.random() * (max - min) + min;
        }
        
        
        //inst.moveCamera(getRandomArbitary(-2, 2), getRandomArbitary(-2, 2));
        
        var c = {
            'x':getRandomArbitary(-2, 2),
            'z':getRandomArbitary(-2, 2),
        };
        c.y = inst.terrain[inst.cti(c.x)][inst.cti(c.z)]+0.5;
        
        SimStim.moveTo("Femal_Base_Mesh.obj", c.x, c.y, c.z, "2");
        
    });
    
    /*
    window.watchID =  navigator.accelerometer.watchAcceleration(function(res){
        SimStim.setCamRotation(res.x, res.y, res.z);
    }, function(){});
    */
    
  },
  moveCamera:function(x, y){
    var inst = this;
    // get current camera coords
    
    SimStim.getCamCoords(function(pos){
        // calculate path to new coords
        
        
        var path = inst.grid.find(inst.cti(pos.x), inst.cti(pos.z), inst.cti(x), inst.cti(y));
        // move to new coords
        for (var i in path) {
            var c = {
                'x':inst.itc(path[i].position.x),
                'y':inst.terrain[path[i].position.x][path[i].position.y]+0.5,
                'z':inst.itc(path[i].position.y)
            };
            
            if (i == path.length - 1) {
                console.log(c);
                SimStim.moveTo("Femal_Base_Mesh.obj", c.x, c.y, c.z, "2");
            }
            //SimStim.moveCamTo(c.x, c.y, c.z, "3");
            
        }
        
    });
  },
  itc:function(i){
    return parseFloat(i - 64)*0.5;
  },
  cti:function(c){
    return parseInt(c*2+64);
  },
  physics:function(){
    var inst = this;
    // Setup our world
    var world = new CANNON.World();
    world.gravity.set(0,0,-9.82);
    world.broadphase = new CANNON.NaiveBroadphase();
    
    // Create a sphere
    var mass = 5, radius = 1;
    var sphereShape = new CANNON.Sphere(radius);
    var sphereBody = new CANNON.RigidBody(mass,sphereShape);
    sphereBody.position.set(0,0,10);
    world.add(sphereBody);
    
    inst.sbody = sphereBody;
    
    // Create a plane
    var groundShape = new CANNON.Plane();
    var groundBody = new CANNON.RigidBody(0,groundShape);
    //groundBody.position.set(0,inst.cground,0);
    
    
    inst.ground = groundBody;
    
    world.add(groundBody);
    
    // Step the simulation
    setInterval(function(){
      world.step(1.0/60.0);
      //console.log("Sphere z position: " + sphereBody.position.z);
      SimStim.setMeshCoords("Femal_Base_Mesh.obj", sphereBody.position.x , sphereBody.position.z, sphereBody.position.y);
    }, 1000.0/60.0);
    
    
    
  },
  genTerrain:function(){
    var inst = this;
    
    
    // pathfinder
    inst.grid = new gamlib.AStarArray(128, 128);
    
    
    // generate fractal terrain
    inst.terrain = generateTerrain(128, 128, 0.5);
    var w = inst.terrain[0].length, h = inst.terrain.length;
    var x, y, z, he, idx, indices = [], structs = [], tot = w*h, i1, i2, i3, i4, i5, i6;
    var len = w;
    var hlen = w*0.5;
    for (var i in inst.terrain) {
        for (var j in inst.terrain[i]) {
            
            i = parseInt(i);
            j = parseInt(j);
            
            // get the coord
            x = parseFloat(j - hlen)*0.5;
            y = parseFloat(inst.terrain[i][j]);
            z = parseFloat(i - hlen)*0.5;
            
            // add to pathfinder
            
            he = Math.round((y+10000)*10000);
            inst.grid.setValue(j, i, he);
            
            // decode back
            //console.log(y+' '+he+' '+(he/10000-10000));
            //console.log(j+' '+x+' '+(x * 5 + hlen));
            
            
            
            // structures have only x,y and z
            structs.push(x);
            structs.push(y);
            structs.push(z);
            structs.push(1.0);
            structs.push(1.0);
            structs.push(1.0);
            structs.push(1.0);
            structs.push(1.0);
            structs.push(1.0);
            // generate indices
            idx = w*i+j;
            if (i+1 == h || j+1 == w) {
                continue;
            }else{
                i1 = idx;
                i2 = idx + w;
                i3 = i2 + 1;
                i4 = i3;
                i5 = idx + 1;
                i6 = idx;
                indices.push(i1);
                indices.push(i2);
                indices.push(i3);
                indices.push(i4);
                indices.push(i5);
                indices.push(i6);
            }
        }
    }
    // load shaders
    $.get('shaders/shader.vsh', function(vsh){
        $.get('shaders/shader.fsh', function(fsh){
            // crete terrain mesh with shaders and texture
            SimStim.createMesh('land', structs.join(','), indices.join(','), vsh, fsh, "www/img/CourseSand.jpg");
        });
    });
  },
  initPathFinding:function(heightmap){
    var inst = this;
    var grid = new gamlib.AStarArray(128, 128);
    
    // set our field, values less then 0 mean 'not walkable' whereas 0 or higher means walkable
    grid.setValue(0, 0, -1); // make upper left corner not walkable
    /*
    // now find our path from lower left (0, 19) to upper right (19, 0) corner
    var path = grid.find(0, 19, 19, 0);

    // output first step
    if (path.length) {
        console.log("First step: "+path[0].position.x+", "+path[0].position.y);
    }
    */
  },
  getTreeMesh:function(vertices, indices){
    var geom = new THREE.Geometry();
    for (var i=0; i<vertices.length; i = i + 3) {
        geom.vertices.push(new THREE.Vector3(vertices[i],vertices[i+1],vertices[i+2]));
    }
    for (var i=0; i<indices.length; i = i + 3) {
        geom.faces.push(new THREE.Face3(indices[i],indices[i+1],indices[i+2]));
    }
    geom.computeFaceNormals();
    //geom.computeVertexNormals();
    
    return geom;
    
    
    //console.log(geom);
    
    //var object = new THREE.Mesh( geom, new THREE.MeshNormalMaterial() );
    //scene.add(object);
  }
});





































