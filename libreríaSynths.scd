SuperDirt.start

// A continuación tienes 5 SythDef, prueba conectándolos con Tidal.
// Evalúa cada uno de ellxs y dirígete al archivo, syth.tidal para modificarlos.

///////////____1

(
SynthDef(\cqde, {|freq = 40|
	var saw, env, line;
	line= Line.kr(0,1,1);
	env = EnvGen.kr(Env.asr(1,1,4),line,doneAction:2);
	saw = Saw.ar(freq)* env;
    Out.ar(0,saw*env)}).add;
)

a = Synth(\cqde, [\freq,40]);
a.set(\freq, 0)


///////////____2

(
SynthDef(\praxis, {
    | out, sustain=1, freq=440, speed=1, begin=0, end=1, pan, accelerate, offset|
    var env    = Line.ar(1, 0, sustain, doneAction: Done.freeSelf);
    var osc    = SinOsc.ar(freq);
    var output = osc * env;
    Out.ar(out, Pan2.ar(in: output, pos: pan));
}).add;
)


///////////____3

(
SynthDef(\looping, {
    | out, sustain=1, freq=440, speed=1, begin=0, end=1, pan, accelerate, offset, volume|
    var env    = Line.ar(1, 0, sustain, doneAction: Done.freeSelf);
    var osc    = RLPF.ar(in: SawDPW.ar([freq, freq/2]), freq: SinOsc.ar(pan).range(200,2000));
    Out.ar(out,DirtPan.ar(osc, ~dirt.numChannels, pan, env))
}).add;
)


///////////____4

(
SynthDef(\hw, { | dustVar = 0  |
	var saw, pulse, dust, lftri;
	saw = Saw.ar(460,0.3);
	dust = Dust.kr(dustVar);
	pulse = Pulse.ar(462,0.8,0.5);
    lftri = LFTri.ar(80,3,1);
    Out.ar(0,saw+pulse*dust+lftri)}).add;
)

a = Synth(\hw, [\dustVar, 1]!2)

a.set(\dustVar, 10)


///////////____5

(
SynthDef(\make, {|freq ,amp , gate = 1|
	var pulse, env;
	env = EnvGen.kr(Env.asr(0.01,1,3),gate,doneAction:2);
	pulse = Saw.ar(freq,amp)* env;
Out.ar(1,pulse)}).add;
)

a = Synth(\make, [\freq, 40,\amp, 0.5,\gate, 1]!2) // Lo prenden
a.set(\gate, 0) // Lo apagan


///////////____6

{Pulse.ar(MouseX.kr(5,20))*(SinOsc.ar(10000,0,0.6)+SinOsc.ar(90,0,0.6))}.scope


(SynthDef(\way, {| fq1 = 10000, fq2 = 90, mn=5,mx = 20, gate =1|
	var pulse, sin1,sin2, env;
	pulse = Pulse.ar(MouseX.kr(mn,mx));
	sin1 = SinOsc.ar(fq1,0,0.6);
	sin2 = SinOsc.ar(fq2,0,0.6);
	env = EnvGen.kr(Env.adsr(0.03,0.3,0.5,1.0),gate);
	Out.ar(0,Pan2.ar(pulse*(sin1+sin2)*env));

}).add)

a = Synth(\way , [\gate, 1]);
a.set(\fq1, 10000, \fq2,200);
a.set(\mn,2,\mx, 30);
a.set(\gate,0);
a.free





