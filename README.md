# Código y Resistencia Hackfeminista desde la Experimentación Sonora:  
## Live coding en SuperCollider y Tidalcycles
[Talleres WIP | Arte digital](https://wipartedigital.com/2021/06/21/codigo-y-resistencia-hackfeminista-desde-la-experimentacion-sonora/), 2021   
Licencia GNU General Public License v3.0  
  
  
![intro](https://media.giphy.com/media/3ohs7XjrVT0zuGynS0/giphy.gif)  


El live coding es una práctica artística que consiste en escribir código fuente para sintetizar, modificar y controlar sonido e imagen en un acto performático guiado por la improvisación.
Este taller busca vincular el código, texto e imagen para generar narrativas y contranarrativas disidentes que denuncie, visibilice y desestabilice estructuras jerárquicas hegemónicas de la colonialidad desde la práctica artística y sonora con tecnología. A partir de la exploración limítrofe entre el lenguaje natural y el lenguaje máquina como explotación sonoro, este taller busca ficciones y no ficciones que historien los intersticios de lo no contado desde la objetividad feminista y ciber-hackfeminista.

### Objetivo

El objetivo del taller es crear un micro-set incorporando síntesis de audio, patrones y muestras de audio para que lxs participantxs puedan expresar sonoramente reflexiones político-sensibles del contexto desde lo personal y/o colectivo. En este sentido, el taller adopta la forma de una plataforma temporal de colaboración para el encuentro y la circulación de prácticas con y de código abierto, extensible, remodulable y reapropiable.

### Destinatarixs

La propuesta está orientada a personas identificadas como mujeres o personas no binarias y público en general vinculadas (o con interés en explorar) al arte sonoro, música por computadora y el lenguaje de programación SuperCollider y Tidalcycles, desde una perspectiva crítica. 

### Requerimientos 

- Computadora personal (cualquier sistema operativo). 
- Audífonos. 

### Programa 

#### Sesión I

- Presentación  
Música, programación y ciberfeminismo en el live coding. 
- Live coding 
	- [Toplap](https://toplap.org/about/)
	- [Algorave](https://algorave.com/)
	- [Wikipedia](https://es.wikipedia.org/wiki/Live_coding)
- Ciberfeminismo
	- [Index](https://cyberfeminismindex.com/)
	- [Sisters with transistors](https://sisterswithtransistors.com/ALL)
	- [Mujeres programadoras](https://www.fullstackacademy.com/blog/remarkable-women-programmers)
	- [Feminismo y software libre](https://www.mujeresenred.net/software_libre/indexsl.html)
	- [Manifiesto xenofeminista](https://laboriacuboniks.net/manifesto/xenofeminism-a-politics-for-alienation/)
	- [MariaLab](https://www.marialab.org/)
	
- Texto, sonido e imagen. Código como posibilidad narrativa.
c. Ciber-hackfeminismo como experimentación sonora.
- Práctico
Instalación
	- [SuperCollider](https://supercollider.github.io/download) 
	- [Tidal](https://tidalcycles.org/docs/getting-started/linux_install)


#### Sesión II

- Introducción a SuperCollider
	- [Código SC](https://github.com/MarianneTeixido/hackcode-wip/blob/main/wip-1.scd)
- Debuggeo instalación Tidal
- Introducción a TidalCycles 
	
##### Tidal 
	
La siguiente información también la puedes consultar [acá](https://tidalcycles.org/docs/getting-started/tidal_start/)

Tidal Cycles no es un gran software monolítico. Sino que es una interconexión entre varios componentes:  
- Una biblioteca de patrones  
	- Tu editor de texto  
	- El intérprete (Haskell)
- Un motor de audio  
	- SuperDirt para recibir mensajes y convertirlos en sonido.
	- SuperCollider, generador de sonido. 

![tidal](https://github.com/MarianneTeixido/hackcode-wip/blob/main/img/tidal.png)  

Para iniciar Tidal:  
- Iniciar SuperCollider y SuperDirt. En el IDE de SC evalúa el siguiente comando:  
     
`SuperDirt.start`  


Evalúa presionando Ctrl / Cmd + Enter. Deberías ver en la postwindow el siguiente mensaje  
`SuperDirt: listening to Tidal on port 57120`  

- En Atom (o el editor de tu preferencia), crea un nuevo archivo y guárdalo con la extención .tidal.   
Ejemplo: wip.tidal  

Al guardar el archivo SuperCollider siempre arrancará SuperDirt tan pronto como se inicie el programa y estamos listxs para sonar con Tidal.   

**NOTA:** Existen varias formas de iniciar SuperDirt que nos permiten usar librerías de SC o hacer sonido multicanal, pero por el momento sólo usaremos el script anterior.   


Tidal Cycles no usa BPM (latidos por minuto) sino una medida específica llamada CPS: ciclos por segundo. Para Tidal, el tiempo es cíclico y no lineal. Significa que cuando termina un ciclo, seguirá uno nuevo. El tiempo se cuenta en decrementos cada vez más pequeños de ciclos por segundo (por ejemplo, 1/3 de un ciclo).   

![ciclos](https://github.com/MarianneTeixido/hackcode-wip/blob/main/img/ciclos.png)  

Tidal puede retroceder o avanzar rápidamente en el tiempo porque en realidad puedes predecir lo que sucederá en x ciclos o lo que sucedió hace x ciclos  

Acá te dejo el código para comenzar a hacer sonido!  

- [Codigo Tidal](https://github.com/MarianneTeixido/hackcode-wip/blob/main/wip-1.tidal)




