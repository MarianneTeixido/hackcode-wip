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

a = Synth(\ejemplo, [\freq, 500, \vol, 1, \pan, 1]);
a.set(\freq, 200);
a.free;


//Ejemplo 2

SynthDef ("tonos_diferentes",{
	arg freq = 440;
	var onda;
	onda = SinOsc.ar(freq)*0.1;
	Out.ar(0, out)
}).play

a = Synth("tonos_diferentes", ["freq", 64.midicps]);
b = Synth("tonos_diferentes", [\freq, 67.midicps]);
c = Synth("tonos_diferentes", ["freq", 72.midicps]);

a.set("freq", 60.midicps);
c.set("freq", 71.midicps);

a.free;
b.free;
c.free;

//Ejemplo 3

(
SynthDef ("tono2",{
	arg freq = 440;
	var onda, mod;
	mod = SinOsc.ar(freq*1.1) *0.1;
	onda = SinOsc.ar(freq)*0.1;
	Out.ar(0, onda + mod)
}).add
)

//Mini ejercicio:
// Crea diferentes instancias del anterior SynthDef usando más de dos varibles
// Si reutilizas a, b, c, no olvides liberarla las anteriores.




















s.quit


SuperDirt.start //Conectar con tidal


// A continuación trabajaremos con SynthDef y muestras.
//En la siguiente lineas carga la ruta de los sonidos que quieres usar.

a = Buffer.read(s, "/home/unyxt/muestras/808/kick__0_.wav"); // Cargar el buffer, lo guardamos en b. Importante: liberarlo más adelante
b = Buffer.read(s, "/home/unyxt/muestras/808/clap__0_.wav"); // Cargar el buffer, lo guardamos en b. Importante: liberarlo más adelante
c = Buffer.read(s, "/home/unyxt/muestras/ua/08monk.wav");

a.bufnum;
b.bufnum;
a.free
b.free
c.free

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

(
SynthDef(\playKick, { |bufnum, envbuf|
	var buf;
	buf = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*0.5, 1, 0, 0);
	Out.ar([0,1], buf)
}).add;
)

d = Synth(\playKick, [\bufnum, a]);
d.free

(
SynthDef(\playClap, { |bufnum, envbuf|
	var buf;
	buf = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), 1, 0, 0);
	Out.ar([0, 1], buf)
}).add;
)

d = Synth(\playKick, [\bufnum, b]);


(
SynthDef(\warp, { |bufnum, envbuf|

	var  warp, pointer, pitch;

	pointer = MouseX.kr(0, 1);
    pitch = MouseY.kr(0.5, 2);

    warp = Warp1.ar(1, bufnum, pointer, pitch, 0.1, envbuf, 8, 0.1, 2);



	Out.ar([0, 1], warp)
}).add;

)

d = Synth(\warp, [\bufnum, c, \envbuf, -1])
d.free


// Rutinas
// Abajo verás un ejemplo de una rutina.

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
	})

}.play;
)





