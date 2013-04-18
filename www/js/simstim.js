//thumbs.0.5.2.min.js - http://mwbrooks.github.io/thumbs.js/
(function(b){try{document.createEvent("TouchEvent");return}catch(d){}var c={mousedown:"touchstart",mouseup:"touchend",mousemove:"touchmove"};b.addEventListener("load",function(){for(var e in c){document.body.addEventListener(e,function(h){var g=a(c[h.type],h);h.target.dispatchEvent(g);var f=h.target["on"+c[h.type]];if(typeof f==="function"){f(h)}},false)}},false);var a=function(f,h){var g=document.createEvent("MouseEvents");g.initMouseEvent(f,h.bubbles,h.cancelable,h.view,h.detail,h.screenX,h.screenY,h.clientX,h.clientY,h.ctrlKey,h.altKey,h.shiftKey,h.metaKey,h.button,h.relatedTarget);return g}})(window);

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
    'onMesh':function(meshName, evtName, f){
        window.document.addEventListener('');
    }
};