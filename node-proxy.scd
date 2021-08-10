
//Hackcode. Composición Algorítmica en tiempo real.
//Agosto, 2020
//Festival Sur Aural
//Licencia GNU General Public License v3.0


_______________________________________________________________________________________
_______________________________________________________________________________________


                           TERCERA SESIÓN

                            PRIMERA PARTE

                        PROGRAMACIÓN AL VUELO

                            CON NODE PROXY
_______________________________________________________________________________________
_______________________________________________________________________________________




__________________________

       NODE PROXY
__________________________


NodeProxy



Generalmente, un proxy es un espacio que puede almacenar algo. Un node proxy es un espacio contenedor para una señal de audio almacenada y reproducida en el server.

Los objetos NodeProxy se pueden reemplazar y recombinar mientras se reproducen.
También se pueden usar para construir una estructura más grande que se usa y se modifica más adelante.

NodeProxy puede ser usado internamente en ProxySpace y también es una super clase de Ndef. Ambas son estructuras de código que nos permiten generar fuentes de sonido (síntesis, muestras, input externos de audio, etc) recombinables al momento.


           -    Ndef

Ndef utiliza tags para registrar en la memoria del server, señales de audio. La señal puede ser modificada bajo el nombre o tag con el que lo registramos y modificada o sustituída por otra mientras tocamos.
Un sinte puede reemplazar a otro automáticamente, las transiciones también pueden ser cuantificadas. //quant(4)

Ejemplo:


s.boot
Ndef(\prueba, {Pan2.ar(SinOsc.ar([60].midicps,0,0.5)}).play

Ndef(\prueba).clear(20)


Ejercicio:
	- Revisa la documentación de Ndef y haz sonar los ejemplos.
	- Pasa o reescribe tus SynthDef a Ndef.



__________________________

    JITLib
	   -
	ProxySpace
__________________________




JITLib, o biblioteca Just in Time, es un sistema que permite a las personas escribir Ugen Graphs (procesamiento de señales en el servidor SC) y reescribirlos en tiempo real. Esto es ideal para codificación en vivo, enseñanza, experimentación y todo tipo de trabajo de composición.

Proxy Space funciona con la librería: JITLib

Cuando se accede, ProxySpace devuelve un NodeProxy. Para utilizar la librería JIT, crea un ProxySpace que se convierte en el entorno o espacio de referencia para los sintetizadores que habitarán ahí.


	s.quit

Para prender el servidor en el entorno de ProxySpace declaramos:



//________________PRENDER PROXY

p = ProxySpace.push(s.boot); //Inicializa el servidor con NodeProxy


________________

ALGUNOS MÉTODOS
________________


.fadeTime = 3; // fadeTime indica la canditad de segundos para hacer fundido cruzado.

.play; //devuelve un nodo que reproduce sonido en esa variable.

.quant =  4 //cuantiza todos los sintes a un compás de 4/4.

.free //Libera un nodo o grupo de nodos. Libera más no detiene la reproducción.

.stop //Detiene la reproducción de los monitores no de los sintes.

.end //Detiene y libera todos los proxys.

.clear //Borra el proxy de nodo y lo elimina del entorno, esto libera a todos los buses. Si se da un fadeTime, primero se desvanece y luego se borra.


_________________

EJEMPLOS DE CONCATENACIÓN
_________________


p = ProxySpace.push(s.boot);

~out.play;

~out = { SinOsc.ar([400, 407] * 0.9, 0, 0.2) };

~out = { SinOsc.ar([400, 437] * 0.9, 0, 0.2) * LFPulse.kr([1, 1.3]) };

~out = { SinOsc.ar([400, 437] * 0.9, 0, 0.2) * ~x.kr(2) };

~x = { LFPulse.kr([1, 1.3] * MouseX.kr(1, 30, 1)) };

//lag suaviza transformaciones en el tiempo.
~out = { SinOsc.ar([400, 437] * Lag.kr(0.1 + ~x, 0.3), 0, 0.2) * ~x };

p.fadeTime = 5;

~out = { SinOsc.ar([400, 437] * 1.1, 0, 0.2) * ~x.kr(2) };

p.clear(8); //termina y limpia en 8 segundos



_________________

EJEMPLOS SECUENCIAS USANDO DEMAND

_________________


//En este punto les sugiero matar el servidor y recompilar.
p = ProxySpace.push(s.boot); // use ProxySpace as current environment.

~out.play;

//Secuenciación de notas.

s.meter
s.scope

//Acorde

p.quant = 4


~out = ~acorde;

~acorde = { Pan2.ar(SinOsc.ar([60,64,67].midicps,0,0.5))};

//Arpegio, secuencias de notas con Demand.

~out.free

~out = ~arpegio;

~arpegio = { Pan2.ar(SinOsc.ar(~seqArpegio,0,0.5))};

~seqArpegio = { Demand.kr(Impulse.kr(8),0,Dseq([60,64,67].midicps,inf)) }

/*Ejercicio sugerido. Probar con otras formas de onda*/


//Creación de un kick, usando Decay como envolvente y Demand como secuenciador.

~out = ~kick;

~kick = { Pan2.ar(SinOsc.ar(90)*Decay.kr(Demand.kr(Impulse.kr(6),0,Dseq([1,1,1,1],inf))*Impulse.kr(6),0.2))};



//Anidación de demands para controlar la velocidad de los beats.

~out = ~kick;

~kick = { Pan2.ar(SinOsc.ar(90)*Decay.kr(Demand.kr(Impulse.kr(~demaK),0,Dseq([1,1,1,1],inf))*Impulse.kr(~demaK),0.2))};

~demaK = {Demand.kr(Impulse.kr(1),0,Dseq([6,4,2,1],inf))};

~out.free

/*Anidar demands dentro del kick para secuenciar la frecuencia*/



// Secuencia con ruido.

~out.free

(
~out = ~kick + ~hh;

~hh = {WhiteNoise.ar(0.3)*Decay.kr(Demand.kr(Impulse.kr(1),0,Dseq([1,1,1,1],inf))*Impulse.kr(1),0.09)*3};

~kick = { Pan2.ar(SinOsc.ar(90)*Decay.kr(Demand.kr(Impulse.kr(6),0,Dseq([1,1,1,1],inf))*Impulse.kr(6),0.2))};

)

/*A partir de aquí, ¿qué podemos hacer?*/

//Una opción, cuantizar.

p.makeTempoClock(200/120);
p.quant = 4;

~out.free

(
~out = ~kick + ~hh;

~hh = {WhiteNoise.ar(0.3)*Decay.kr(Demand.kr(Impulse.kr(~tempo),0,Dseq([1,1,1,1],inf))*Impulse.kr(~tempo),0.09)*3};

~kick = { Pan2.ar(SinOsc.ar(90)*Decay.kr(Demand.kr(Impulse.kr(~tempo*6),0,Dseq([1,1,1,1],inf))*Impulse.kr(~tempo*6),0.2))};
)

//_____________________________________________
/*
Para compilar un conjunto de expresiones:
1.- Colocar entre paréntesis.
2.- Compilar con CTRL + ENTER

Agrupar expresiones nos puede permitir escribir escenas que se compilan y cuantizan.
*/
//______________________________________________



c = Buffer.read(s, "/home/unyxt/muestras/ua/08monk.wav");

~out = ~buffer
~out.free

~buffer = {Pan2.ar(PlayBuf.ar(2, c, BufRateScale.kr(c)* 1,Impulse.kr(~tempo*(Demand.kr(Impulse.kr(~tempo),0,Dseq([0.5],inf)))), BufFrames.kr(c)*(Demand.kr(Impulse.kr(~tempo),0,Dseq([0.01],inf))),1)).flat * 1};

//Ejercicio, desenrredar el código.
