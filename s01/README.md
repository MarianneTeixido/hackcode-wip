	
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


