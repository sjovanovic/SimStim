// simstim
var SimStim = {
    'cb':function(cb){
        if(cb){
            return cb;
        }else{
            return function(){};
        }
    },
    'addMesh':function(filename, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "addMesh", [filename]);
    },
    'setCamCoords':function(x, y, z, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "setCamCoords", [x, y, z]);
    },
    'setCamRotation':function(x, y, z, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "setCamRotation", [x, y, z]);
    },
    'setMeshRotation':function(meshName, x, y, z, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "setMeshRotation", [meshName, x, y, z]);
    },
    'setMeshCoords':function(meshName, x, y, z, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "setMeshCoords", [meshName, x, y, z]);
    },
    'setMeshScale':function(meshName, x, y, z, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "setMeshScale", [meshName, x, y, z]);
    },
    /*
     * structures = position (4), normals (3), texcoord (2) - e.g. "0.1,0.2,0.3,1.0,0.4,0.5,0.6,1.0,0.0" ...
     * indices e.g. "1,2,3" ...
     * 
    */
    'createMesh':function(meshName, structures, indices, vertexShader, fragmentShader, textureImg, cb1, cb2){
        vertexShader = vertexShader?vertexShader:"";
        fragmentShader = fragmentShader?fragmentShader:"";
        textureImg = textureImg?textureImg:"";
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "createMesh", [meshName, structures, indices, vertexShader, fragmentShader, textureImg]);
    },
    'setMeshTexture':function(meshName, textureImg, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "setMeshTexture", [meshName, textureImg]);
    },
    'setMeshShaders':function(meshName, vertexShader, fragmentShader, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "setMeshShaders", [meshName, vertexShader, fragmentShader]);
    },
    'getMeshCoords':function(meshName, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "getMeshCoords", [meshName]);
    },
    'getCamCoords':function(cb1, cb2){
        cordova.exec(this.cb(function(res){
            res = res.split(',');
            cb1.call(this, {'x':res[0], 'y':res[1], 'z':res[2]});
        }), this.cb(cb2), "SimStimGL", "getCamCoords", []);
    },
    'moveTo':function(meshName, x, y, z, duration, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "moveTo", [meshName, x, y, z, duration]);
    },
    'moveCamTo':function(x, y, z, duration, cb1, cb2){
        cordova.exec(this.cb(cb1), this.cb(cb2), "SimStimGL", "moveCamTo", [x, y, z, duration]);
    }
};