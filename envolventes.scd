Taller Código y resistencia hackfeminista
Julio 22, 2021
WIP Arte Digital
Licencia Feminista de Producción de Pares [F2F]
https://labekka.red/licencia-f2f/


////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////  S E S I O N    3  ///////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////






//____________________                 E N V O L V E N T E S         _____________________________________//





//La envolvente es la manera en que se despliega un sonido en función del tiempo y la amplitud. Estamos hablando de qué tan fuerte suena nuestro timbre a medida que pasa el tiempo. Por ejemplo una envolvente percusiva es como la de un tambor o un piano, en donde el sonido comienza muy fuerte e inmediatamente se va escuchando mas quedito. Los elementos de la envolvente más comunmente identificados son:




ataque (attack); //que tan rápido alcanza nuestro sonido su punto de máxima amplitud.

decaimiento (decay); //que tan rápido alcanza nuestro sonido su punto de estabilidad o sostenimiento.

sostenimiento (sustain); //cuanto tiempo está nuestro sonido en el punto de estabilidad en el que no sube ni baja de amplitud.

liberación (release): //el tiempo que tarda el sonido en llegar del punto de sostenimiento a la amplitud cero.

magnitud de ataque (pekLeven)

//A las envolventes que tienen estos cuatro parámetros bien definidos se les conoce como envolventes ADSR. No todas las envolventes tienen estos mismos elementos, algunas tienen sólo dos: ataque y liberación, o sólo tres: ataque, sostenimiento y liberación.

//Para generar una envolvente en SuperCollider recurrimos a la clase EnvGen.


//Las envolventes pueden ser pensadas como una secuencia de números que se despliega en el tiempo.

//Esta secuencia puede ser usada para varios propósitos que pueden involucrar una forma de onda o una modulación.

//Por el momento nuestras envolventes no generarán sonido, sólo determinarán la manera en que su amplitud se desarrolla en el tiempo, asi que EnvGen trabajará con el rate (tasa) de control .kr.




//___________________________________EnvGen




//Genera una envolvente que puede dar forma a la amplitud de nuestro sonido.

EnvGen.kr (envolvente,gate,doneAction:2)

envolvente: //En el argumento envolvente colocamos alguna de los objetos de envolventes que posee SuperCollider en la clase EnvGen

gate: //detona la envolvente y el sonido transformado por la envolvente.

donoAction:2 //Indica la forma en que se comportará el sintetizador cuando el gate termine. En el caso de doneAction 2 libera el sintetizador que termina.

//Para más info de doneAction, revisar las acciones descritas en la documentación de;
Done //Posicionar el cursor sobre Done y presionar cmd +  d para acceder.




//________________Objetos de la clase EnvGen............................


//01
Env.adsr (ataque, decaimiento, sostenimiento, liberacion, peakLevel )
//Envolvente de duración indeterminada para sonidos sostenidos.

Env.adsr(0.05,0.8,0.5,0.2,1).plot




//02
Env.perc (ataque, liberación)
//Envolvente de ataque percusivo, argumentos en segundos. Duración determinada por la suma del attack más el release.

Env.perc (0.01,1).plot // Aquí el attack dura 0.01 segundos y el release 1 segundo 0.01 + 1 = 1.01. Observar que con el mensaje .plot podemos ver la gráfica de la envolvente




//03

Env.asr (ataque, volumen, decaimiento )
//Envolvente de duración indeterminada para sonidos sostenidos. El segundo argumento es de volumen, no de duración.

Env.asr(0.01,1,1).plot // Se tardará una centésima de segundo en alcanzar su amplitud máxima, que es 1 como lo indica el segundo argumento. Una vez alcanzada se quedará ahí hasta que nosotros le indiquemos cuando generar el release que se tardará 1 segundo en alcanzar el cero.

gate: 1 //abre la envolvente, 0 la cierra. Default 1. Las envolventes de duración determinada como Env.perc no necesitan cerrarse.

doneAction: //una acción que se realiza cuando la envolvente ha finalizado. doneAction: 2 elimina el Synth del servidor.



s.boot

//Ejemplo de Env.asr
(
SynthDef("prueba", {|gate|
	var pulse, env;
	env = EnvGen.kr(Env.asr(0.01,1,3),gate,doneAction:2);
	pulse = Pulse.ar(15)* env;
Out.ar(0,pulse*env*0.5)}).add;
)

a = Synth("prueba", ["gate", 1]!2) // Lo prenden
a.set("gate", 0) // Lo apagan

//Para aplicar la envolvente a un sonido multiplicamos la envolvente por el sonido.
//Ejemplos:

{Saw.ar(40)*EnvGen.kr(Env.perc(0.1,0.1),doneAction:2)!2}.scope

{Saw.ar(40)*EnvGen.kr(Env.asr(1,1,4),Line.kr(1,0,2),doneAction:2)!2}.scope


//Observen que en el argumento gate hemos colocado un UGen Line que genera una línea de números que va desde el 1 al 0 en 2 segundos. Esto nos abre y cierra la envolvente automáticamente (ver la ayuda de Line).






//______________________ C A N A L E S



//El sonido análogo o digital puede salir por uno o varios canales. Nosotros estamos acostumbrados a escuchar la música en dos canales que suenan en una bocina cada uno. Esto es conocido como estereofonía y es por eso que al aparato de sonido de nuestro auto o casa le llamamos "el estéreo".

//Existen aparatos que nos permiten sacar el sonido por más de dos canales. Estos aparatos son conocidos como tarjetas o interfaces de audio. Las hay de 2, 4 u 8 canales por lo menos. Además estas interfaces se pueden conectar entre sí sumando la cantidad de canales. En SuperCollider existen varias clases que nos ayudan a trabajar con los canales de audio por donde queremos que salga nuestro sonido. Aquí veremos 2: Out.ar y Pan2.ar.


//__________ Out.ar

Out.ar (canal,señal)
//Saca el sonido por un canal específico. Ese canal específico define un punto de partida u offset a partir del cual se va a distribuir el sonido.

canal: 0 = izq, 1 = der. 3, 4, 5,...multicanal
señal: //cualquier oscilador que puede estar multiplicado por una envolvente.

//Ejemplos:

{Out.ar(0,Saw.ar(40)*EnvGen.kr(Env.perc(0.01,1),doneAction:2))}.scope // izquierda

{Out.ar(1,Saw.ar(40)*EnvGen.kr(Env.perc(0.01,1),doneAction:2))}.scope // derecha




//__________ Pan2.ar

Pan.ar (señal,posición)
//Distribuye el sonido entre dos canales consecutivos conservando su potencia. Es decir, que no suena más fuerte cuando esta en los dos canales al mismo tiempo ni más quedito cuando está solo en uno o en otro. Si el Pan2 esta dentro de un Out los canales consecutivos en los que se distribuyen se cuentan a apartir del offset del Out.

señal: //cualquier oscilador o generador de sonido
posición: //-1 izquierda, 1 derecha y con todo el intervalo continuo extrapolando el sonido entre los dos canales o bocinas.

{Pan2.ar(Pulse.ar(100,0.01),MouseX.kr(-1,1))}.scope
{Pan2.ar(Pulse.ar(100,0.01),-0.7)}.scope {Pan2.ar(Pulse.ar(100,0.01),0)}.scope // En medio.
{Pan2.ar(Pulse.ar(100,0.01),0.3)}.scope {Pan2.ar(Pulse.ar(100,0.01),1)}.scope
{Out.ar(0,Pan2.ar(Dust.ar(1000),0))}.scope // distribuye la señal entre el canal 0 y 1
{Out.ar(1,Pan2.ar(Dust.ar(1000),0))}.scope // distribuye la señal entre el canal 1 y 2. Si no tenemos una interfase de audio que nos permita expandir los canales solo se va a escuchar al canal 1. Sólo tenemos 2 canales en nuestras computadoras que el Collider reconoce como el 0 y el 1.

{ LinPan2.ar(SinOsc.ar(440), Line.kr(-1, 1, 5))*0.5 }.play
{ Pan2.ar(SinOsc.ar(300), Line.kr(-1, 1, 5)) *0.5}.play
{ Pan2.ar(PinkNoise.ar(0.4), SinOsc.kr(0.2), 0.3) }.play;



//______________________ L E N G U A J E

.midicps // convierte un número de código MIDI a su equivalente en frecuencia en Hertz. .cpsmidi // convierte una frecuencia en Hertz a su equivalente en código MIDI.

//El código MIDI para designar las notas es:
60=Do (índice 5 o central) 61=Do # o Re b
62=Re
63=Re # o Mi b
64=Mi
65=Fa
66=Fa # o Sol b
67=Sol
68=Sol # o La b
69=La
70=La # o Si b
71=Si
72=Do //(índice 6. Una octava arriba del Do índice 5)


//Si queremos convertir el código MIDI 60 (Do) en frecuencia en Hertz lo hacemos mandándole el mensaje .midicps (cps=ciclos por segundo).

60.midicps
69.midicps

//Para el inverso aplicamos el mensaje cpsmidi
//Te permite cambiar de ciclos por segundo a notas midi.

261.6255653006.cpsmidi 440.cpsmidi


.midiratio // convierte intervalos en razones o quebrados


//Los intervalos para usar con el mensaje midiratio son expresados en cantidad de semitonos.
//Está relacionado con el método de Forte para los pitch class(altura de clase) sets:
0 = unísono
1 = segunda menor
2 = segunda mayor
3 = tercera menor
4 = tercera mayor


5 = cuarta justa
6 = tritono
7 = quinta justa
8 = sexta menor
9 = sexta mayor
10 = séptima menor
11 = séptima mayor
12 = octava

//Los números negativos denotan intervalos descendentes. Entonces para aplicar este mensaje mandamos el mensaje . midiratio al intervalo que deseamos obtener y lo multiplicamos por una frecuencia fundamemntal que nosotros damos. Ejemplo:

440 * 3.midiratio // nos da una tercera menor a partir de La.
440 * -5.midiratio // nos da una carta descendente a partir de La.


//____________ Arreglos


Array  //Un conjunto de elementos ordenados. Se escriben dentro de corchetes [ ] y se separan por comas.

['hola', 'hi', 'salud', 'hallo']
[0,1,2,3,4]
[0,1,2,3,4].choose
[60,62,64,65,67].midicps // Nota 1
[ 261.6255653006, 293.66476791741, 329.62755691287, 349.228231433, 391.99543598175 ].cpsmidi


//____________ Ejercicios

{----.ar(0,SinOsc.ar)}.scope;

{Pan2.ar(WhiteNoise.ar,----)}.scope;

{Out.ar(1,Saw.ar(100)*EnvGen.kr(--Env--.perc(0.01,2),doneAction:----2))}.scope;

{----.ar(WhiteNoise.ar, [100,200,400,1000,1500,5000].----,0.1)*EnvGen.kr(Env.perc(0.01,0.5),doneAction:2)}.play;

{Pan2.ar(SinOsc.ar([60,64,67,72].choose.----),[----,----].choose)}.play; {[LPF,HPF].----.ar(BrownNoise.ar,800)}.play;


//____________ Otros ejemplos
{LPF.ar(Pulse.ar(20,0.1,0.5)*SinOsc.ar(800,0,0.7),500,0.5)*EnvGen .kr(Env.asr(0.01,1,0.5),SinOsc.kr(1))!2}.play

{LPF.ar(Pulse.ar(20,0.1,0.5)*SinOsc.ar(800,0,0.7),500,0.5)*EnvGen .kr(Env.perc(0.01,0.1),SinOsc.kr(7))!2}.play

{LPF.ar(Pulse.ar(20,0.1,0.5)*SinOsc.ar(800,0,0.7),MouseY.kr(10000 ,70),0.5)*EnvGen.kr(Env.perc(0.01,0.1),SinOsc.kr(MouseX.kr(1,50)) )!2}.play






