s.boot //Prender el server para usar solo en SuperCollider

//SynthDef

//Ejemplo 1

(
SynthDef(\ejemplo, { arg freq = 440, pan = 0, vol = 0;
	var onda;
	onda = SinOsc.ar(freq);
	Out.ar(0, Pan2.ar(onda, pan, vol));
}).send(s);
)

a = Synth(\ejemplo, [\freq, 500, \vol, 1, \pan, 0]);
a.set(\freq, 200);
a.free;

s.scro


//Ejemplo 2
(
SynthDef ("tonos_diferentes",{
	arg freq = 440;
	var onda;
	onda = SinOsc.ar(freq)*0.1;
	Out.ar([0,1], onda)
}).add
)
~morado = Synth("tonos_diferentes", ["freq", 64.midicps]);
~taza = Synth("tonos_diferentes", [\freq, 67.midicps]);
~red = Synth("tonos_diferentes", ["freq", 72.midicps]);

~morado.set("freq", 60.midicps);
~taza.set("freq", 66.midicps);
~red.set("freq", 71.midicps);

~morado.free;
~taza.free;
~red.free;

//Ejemplo 3

(
SynthDef ("tono2",{
	arg freq = 440;
	var onda, mod, pulse;
	pulse = Pulse.ar(freq*0.999);
	mod = SinOsc.ar(freq*1.1) *0.1;
	onda = SinOsc.ar(freq)*0.1;
	Out.ar([0,1], onda + mod*pulse)
}).add


//Mini ejercicio:
// Crea diferentes instancias del anterior SynthDef usando más de dos varibles
// Si reutilizas a, b, c, no olvides liberarla las anteriores.



















s.quit




s.boot

// Samples

a = Buffer.read(s, "/home/unyxt/muestras/808/kick__0_.wav");
b = Buffer.read(s, "/home/unyxt/muestras/808/clap__0_.wav");
c = Buffer.read(s, "/home/unyxt/muestras/ua/08monk.wav");

t = Buffer.read(s,"/home/unyxt/Music/Audio-Database/abstract90/Abstract/Abstract90-04.wav");

a.bufnum;
b.bufnum;
a.free;
b.free;

/*
Explicacioń PlayBuf

PlayBuf.ar(1, //número de canales del reproductor, tiene que corresponder con la muestra
	bufnum,   //identificador de bufer que cargamos antes
	BufRateScale.kr(bufnum), //velocidad de reproducción
	1, //detonador de la reproducción de la muestra
	0, //loop
	doneAction:0  //acción realizada por el sintetizador cuando termina de reproducirse
);

*/

s.scope

(
SynthDef(\playKick, { arg bufnum;
	var buf;
	buf = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*0.5, 1, 0, 0);
	Out.ar([0,1], buf)
}).add
)

d = Synth(\playKick, [\bufnum, a]);
d.free


(
SynthDef(\playClap, { |bufnum|
	var buf;
	buf = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), 1, 0, 0);
	Out.ar([0, 1], buf)
}).add;
)

f = Synth(\playClap, [\bufnum, t]);


Warp1.ar(1,
	bufnum,
	pointer,
	pitch,
	0.1,
	envbuf,
	8,
	0.1,
	2);

(
SynthDef(\arena, { |bufnum,envbuf, overLaps|

	var  warp, pointer, pitch;

	pointer = MouseX.kr(0, 1);
    pitch = MouseY.kr(0.5, 2);

    warp = Warp1.ar(2, bufnum, pointer, pitch, 0.1, envbuf, overLaps, 0.1, 2);
	Out.ar([0, 1], warp)
}).add;

)

~grano = Synth(\arena, ["bufnum", t, "envbuf", -1, "overLaps", 8])
~grano.set("overLaps", 0.3)
~grano.free


// Rutinas
// Abajo verás un ejemplo de una rutina.



(
r = Routine{
	3.do({
	2.do({
	x = {SinOsc.ar(60.midicps,0,0.5)}.play;
	"ondas de sabor y sonido".postln;
	3.wait;
	x.release;
	});
	1.wait;

	y = {Pulse.ar(200,0.2,0.3)}.play;
	"caminos y vertientes".postln;
	1.wait;
	y.release;
	z = {PinkNoise.ar(0.1)}.play;
	"el ruido es todo lo que no es".postln;
	4.wait;
	z.release;

	});
}
)

r.play
r.free






(
r = Routine{
	a = {SinOsc.ar(550,0,0.3)}.play;
	2.wait;
	a.release;
	b = {PinkNoise.ar(0.3)}.play(fadeTime: 4);
	2.wait;
	b.release(2);

}
)


r.stop;
r.play;


//Acá una rutina con los sintes que contienen muestras.

(
r = Routine {

	2.do({

		8.do({
			"kick secuencia continua".postln;
			Synth(\playKick, [\bufnum, a]);
			0.5.wait;
			"clap secuencia continua".postln;
			Synth(\playClap, [\bufnum, b]);
			0.5.wait;
		});

		0.25.wait;

		8.do({
			"kick secuencia errática".postln;
			Synth(\playKick, [\bufnum, a]);
			[0.125, 0.25, 0.5].choose.wait;
			"clap secuencia errática".postln;
			Synth(\playClap, [\bufnum, b]);
			[0.125, 0.25, 0.5].choose.wait;
		});

		0.25.wait;

		2.do({
			"prueba".postln;
			g = Synth(\arena, [\bufnum, t, "envbuf", -1, "overLaps", 8]);
			g.release;

		});
	})

}.play;
)


~grano = Synth(\arena, ["bufnum", t, "envbuf", -1, "overLaps", 8])



