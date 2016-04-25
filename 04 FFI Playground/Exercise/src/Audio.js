// module App.Audio
"use strict";

// ^-- This, along with (at least) exports = {}, is the minimum required to satisfy "FFI Module".


//// Bogus examples. ////

// Some dummy examples that have nothing to do with audio,
// but just introduce the FFI.

// You can pull in libraries like you would with any Node / CommonJS module.
var leftPad = require('left-pad');

// For seamless interop, we manually need to provide curried functions in
// the JS half of the FFI.
exports.leftPad = function(string) {
  return function(paddingSize) {
    return function(withChar) {
      return leftPad(string, paddingSize, withChar);
    };
  };
};

// This is easier to define in the JS, but harder to consume in PS (see the other file).
exports.easierLeftPad = function(string, paddingSize, withChar) {
  return leftPad(string, paddingSize, withChar);
}


//// Audio Examples ////

// It's down to the PureScript side to dictate when this is actually allowed to
// be called. We're just Doing Stuff here, and the types in our PS app allow
// or disallow its use.
exports.createWindowAudioContext = function() {
  var AudioContext = window.AudioContext || window.webkitAudioContext;
  return new AudioContext();
};

exports.closeAudioContext = function(ctx) {
  // Why the extra function()? Eff requires a not-yet-evaluated function to run.
  // This represents an action that is then called when it's needed by "main" or any
  // of its descendents.
  return function() {
    ctx.close();
  };
};



// Tone-playing helper
exports.playFreq = function(ac) {
  return function(freq) {
    return function(endedCb) {
      return function() {
        var duration = 0.5;
        var attack   = 0.3;
        var release  = 0.1;
        var volume   = 1;

        /*
        var AudioContext = window.AudioContext || window.webkitAudioContext;
        var ac = new AudioContext();
        */

        var oscillator = ac.createOscillator();

        oscillator.frequency.value = freq;
        var gainNode = ac.createGain();
        gainNode.gain.linearRampToValueAtTime(volume, ac.currentTime + attack);
        gainNode.gain.setTargetAtTime(0, ac.currentTime + attack, release);

        // Connect
        oscillator.connect(gainNode);
        gainNode.connect(ac.destination);

        // Play
        oscillator.start(0);
        oscillator.stop(duration + 1);
        oscillator.onended = function(){
          // Disconnect
          oscillator.disconnect();
          //ac.close();
          endedCb(ac);
        };
      };
    };
  };
};

/*
exports.playHigh = function() {
  playFreq(391.99543598174995); // G3
};
exports.playMid = function() {
  playFreq(261.62556530059896); // C3
};
exports.playLow = function() {
  playFreq(164.81377845643513); // E2
};
*/
