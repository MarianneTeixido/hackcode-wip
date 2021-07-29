Taller Código y resistencia hackfeminista
Julio 22, 2021
WIP Arte Digital
Licencia Feminista de Producción de Pares [F2F]
https://labekka.red/licencia-f2f/


////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////  S E S I O N    3  ///////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////




//____________________ V A R I A B L E S

//Las variables son espacios virtuales de memoria que sirven para guardar información.
//-El concepto de variable es inherente a los lenguajes de programación.
//-Las variables facilitan la organización del código, permitiendo una clara y legible escritura.
//-Son identificadas por medio de un nombre que generalmente se relaciona con el objeto al cual queremos igualarlo. Este nombre lo definimos nosotrxs.
//-No tenemos un número determindo de variables, podemos declarar cuantas nos sean necesarias.
//-No deben usarse palabras o letras que ya estén reservadas por el sistema como s (server)

//Pasos para definir variables:
// 1. Escribimos var (abreviatura de variable)
// 2. dejamos un espacio
// 3. declaramos las variables
// 4. Al finalizar la declaración usamos un ;


//Ejemplo:
//Compila el código y observa la post.


//bien
(
var gato, dos;
gato=1;
dos=2;
gato+dos
)

//mal, observa que contesta la post
(
gato=1;
dos=2;
gato+dos
)

//Las variables que tengan un sólo caracter no necesitan ser declaradas. La letra s ya está reservada para el servidor, así que es mejor no usarla. Recuerda que las variables deben comenzar con minúscula.

//Ejemplo de variables de un solo caracter

(
a=1;
x=2;
a+x
)

//Ejemplo en donde incluimos la operación con las variables dentro de un array.

(
var gato, dos;
gato=1;
dos=2;
[gato+dos,'dos variables']
)

//Tambien podemos darle valor a la variables en el lugar donde la declaramos.

(
var gato=1,dos=2;
gato+dos
)

//Para escribir nombres largos y estrafalarios.
//utilizamos el guión bajo en lugar del espacio.
//Tambien se pueden usar mayusculas.

(
var un_numero_mayor_a_diez=15,un_numero_mayor_a_20=43; un_numero_mayor_a_diez + un_numero_mayor_a_20
)

(
var unNumeroMayorADiez=15,unNumeroMayorA20=43; unNumeroMayorADiez + unNumeroMayorA20
)


//Ahora con señales de audio
(
{var ruido,senoide;
ruido=WhiteNoise.ar(0.2);
senoide=SinOsc.ar(1000,0,0.3);
ruido+senoide
!2}.scope )


(
{
var ruido, env, senoide;
ruido=WhiteNoise.ar(0.5);
senoide=SinOsc.ar(10,0,0.3);
env=EnvGen.kr(Env.perc(0,0.2),Impulse.kr(8));
senoide*ruido*env
}.scope )


//En Macintosh, usando cmd+f (f de find) podremos encontrar con mucha facilidad palabras o símbolos dentro de un código. Una vez encontrados pueden ser sustituidas de una sola vez. (Ver en Windows y Linux que onda)


(
{
var oscilador, envolvente, impulso;
impulso = Impulse.kr(MouseX.kr(1, 10));
oscilador = LFTri.ar(200*[1, MouseY.kr(0.98, 1.0124)],0 , 0.53); envolvente = EnvGen.kr(Env.perc(0.01, 1), impulso);
oscilador * envolvente;
}.scope )

//Lo mismo pero sin sin variables...
//Para mi éste método es más inmediato :B
{EnvGen.kr(Env.perc(0.01,1),Impulse.kr(MouseX.kr(1,10)) )*LFTri.ar(200*[1,MouseY.kr(0.98,1.0124)],0,0.53)}.scope

//Ejercicio
{BPF.ar(Dust.ar(MouseY.kr(10,300)),MouseX.kr(100,2000), 0.2)*EnvGen.kr(Env.asr(2,1,4),Line.kr(1,0,8),doneAction:2)}.scope


//Ahora escríbelo usando variables.







//____________________ S y n t h D e f

//Es una definición de sonido (creado por nosotrxs) o una definición de síntesis que puede ser invocado y manipulado independientemente de otros. Un SynthDef es el método por el cual creamos nuestros sonidos en SuperCollider.

//SuperCollider utiliza la definición de Synth 'SynthDef' como un template para la creación de synth node que es una unidad productora de sonido en el servidor.

//Un SynthDef tiene una sintáxis específica que comprende dos partes fundamentales:

//el nombre del SynthDef que se escribe como un string o un símbolo (ej :"prueba" o \prueba) por el cual podremos manipular el synth independientemente de otros synth
//y un UgenGraphFunc = una función en donde se especifíca la intercomunicación entre variables y argumentos.

//Retomaremos un ejemplo anterior:

(
SynthDef("prueba", {|gate,frecuencia=15| Out.ar(0,Pulse.ar(frecuencia)*EnvGen.kr(Env.asr(0.01,1,3),gate,doneAction:2))}).send(s) )

a=Synth("prueba",[\gate,1])
a.set(\gate,0)



//_________Sintáxis SynthDef
//comienza con el objeto SynthDef

(
SynthDef("prueba", //el SynthDef debe de llevar un tag (nombre) que lo identifique, en este caso "prueba".

{|gate| //argumento, es el lugar destinado para los parámetros que queremos interpretar
//los argumentos son también espacios virtuales de memoria que sirven para guardar información pero esta, a diferencia de las variables es creada para ser modificada.

Out.ar(0, //canal de salida, 0 y 1
Pulse.ar(15)*EnvGen.kr(Env.asr(0.01,1,3),gate,doneAction:2)) //salida
}).send(s) //se envia el Synth al servidor designado por default con la letra 's'
)

//El mismo


(
SynthDef("prueba", {|gate=1|
var sen,env;
sen = Pulse.ar(15, 0.2, 0.1);
env = EnvGen.kr(Env.asr(0.01, 1, 3),gate, doneAction:2); Out.ar(0, sen * env)
}).send(s)
)

(
SynthDef("prueba",{arg gate=1;
       var sen,env;
           sen=Pulse.ar(15,0.2,0.1);
	       env=EnvGen.kr(Env.asr(0.01,1,3),gate,doneAction:2);
	Out.ar(0,sen*env)}).send(s)
)

(
{
var sen,env;
sen = Pulse.ar(15, 0.2, 0.5);
env = EnvGen.kr(Env.perc(0, 0.1),Impulse.kr(2)); sen * env
}.play
)
Synth("prueba")


//Una vez creada la estructura del SynthDef es necesario invocarlo para que suene, el SynthDef no suena por si solo. Para esto tenemos dos manera de hacerlo, una de ella es la llamada Object Style.

//________ Object Style


Synth(nombre, [\argumento1, valor1, ... \argumentoN, valorN], target, addAction)


(
 Synth(      // Utilizamos el método new de la clase Synth

	"prueba", // Un string que especifique el nombre del SynthDef a utilizar para crear el nuevo synth.


	[\gate, 1, \frecuencia, 20], // Un Array opcional que especifique los valores iniciales para los argumentos del SynthDef estos valores son mandados en parejas, el nombre del argumento como symbol y su valor:[\nombre1, valor1, \nombre2, valor2]


	s,  // El target: el grupo donde será creado el nodo de este synth. Si especificamos al servidor como target, nuestro synth será creado en el grupo default del servidor, que es el 1



    \addToTail  // el addAction: especificamos en qué lugar del grupo será creado nuestro synth

	) )



//Para facilitar la invocación del SynthDef podemos utilizar las instrucciones más básicas dejando por default el target y la addAction:
//Ejemplo
a = Synth("prueba")
a = Synth("prueba")
a = Synth("prueba", [\gate, 1]) // Lo prenden
a.set("gate", 0) // Lo apagan

//Como notaran igualando a la variable 'a' un SynthDef que se llama "prueba" para luego modificar sus argumentos por el método .set.

//Los argumentos a los que nos referimos son los que creamos en el SynthDef y esta es la manera en la que cambiamos su valor.
//Hay ciertos componentes de esta estrucutura de los SynthDef que pueden escribirse de otro modo:

(
SynthDef(\prueba, //el tag cambia de comilla a diagonal (cambia de string a symbol)
	{arg gate; // los argumentos pueden enumerarse después de la palabra arg y concluye con punto y coma(;).similar a las variables

	Out.ar(0, //canal de salida, 0 y 1

    Pulse.ar(15)*EnvGen.kr(Env.asr(0.01,1,3),gate,doneAction:2)) //salida

}).send(s) //se envia el synth al servidor designado por default con la letra s
)


a=Synth(\prueba, [\gate, 1]) // las comillas se cambian por diagonales
a.set(\gate, 0) // Lo apagan


(
SynthDef(\mi_primer_synth,{|frecuencia, amplitud|
var sen, env, trig;
trig = Impulse.kr(2);
sen = Saw.ar(frecuencia * [0.988889, 1.011], amplitud); env = EnvGen.kr(Env.perc(0.01, 0.5), trig);
Out.ar(0, sen * env)
}).send(s)
)

a=Synth(\mi_primer_synth)
a=Synth(\mi_primer_synth,[\frecuencia,200,\amplitud,0.3])
a.set(\frecuencia,12)
a.free


//SynthDef con envolvente percusiva más un argumento para el triger

( SynthDef(\mi_primer_synth,{|frecuencia=100,amplitud=0.6,frecuenciatrig=2|
var sen, env, trig;
trig = Impulse.kr(frecuenciatrig);
sen = Saw.ar(frecuencia * [0.988889, 1.011], amplitud); env = EnvGen.kr(Env.perc(0.01, 0.5), trig);
Out.ar(0, sen * env)
}).send(s) )

a = Synth(\mi_primer_synth)
a.set(\frecuenciatrig, 1)
a.set(\frecuenciatrig,5.rrand(10),\frecuencia,101.rrand(1820))
a.free

//SynthDef con envolvente asr

(
SynthDef(\mi_segundo_synth,{|frecuencia=100, amplitud=0.6, gate=1|
var sen,env,trig; sen=Saw.ar(frecuencia*[0.988889,1.011],amplitud); env=EnvGen.kr(Env.asr(3.6,1,4.5),gate,doneAction:2); Out.ar(0,sen*env)
}).send(s)
)
a=Synth(\mi_segundo_synth)
a.set(\frecuencia,10)
a.set(\gate,0)


//En este ejemplo vemos como podemos crear diferentes Synth a partir de un SynthDef.
(
SynthDef(\hola,{|frec=430,amp=0.2,gate=1,trig=10|
var sen,env; sen=SinOsc.ar(frec*[1,1.01],0,amp); env=EnvGen.kr(Env.perc(0,0.1),Impulse.kr(trig)); Out.ar(0,sen*env)
}).send(s)
)

a=Synth(\hola)
a.set(\frec,1700)
a.free

b=Synth(\hola,[\frec,1240])
b.set(\frec,800)
b.free

c=Synth(\hola,[\frec,900])
c.free

//Cuando copilamos la línea de código: a = Synth (\hola) La post nos devuelve: Synth("hola" :1000)
//Esta línea nos dice el nombre del SynthDef utilizado por el Synth y el nodo en donde éste último se encuentra (1000). El número de nodo (nodeID) fue seleccionado automáticamente por la clase Synth, ésta simplemente buscó un número de nodo que estuviese libre.

//Nodo: un objeto con el que se puede establecer comunicación, se encuentra en un árbol de nodos manejado por el servidor de síntesis. El árbol define el orden de ejecución de todos los Synths. Hay dos tipos de nodos: groups y synths. Todos los nodos llevan un número entero por nombre ( nodeID ).

//_______ Ejercicio

/* 1 */
( SynthDef(\----,{|---,---,---|
var ----,----;
----=SinOsc.ar(----,0,----); ---=EnvGen.kr(Env.perc(0,---),doneAction:2); ---.ar(----,----*----)
}).----(s) )



/* 2 */
( ------(\----,{|---,---,---,----|
var ----,----,----; ---=----.ar(Saw.ar(----,----),-----,0.2); ---=EnvGen.kr(Env.perc(0,----),doneAction:2); Out.ar(----,----*----)
}).----(s)
)