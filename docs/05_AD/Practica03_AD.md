# Configuración Básica Windows Server II

## Puntos de guía

1. ¿Cómo harías para filtrar en el visor de eventos todos los eventos críticos de seguridad?
2. ¿Cómo cambiarías las propiedades de un evento para que?
   1. Aumente la capacidad máxima del registro a 50MB.
   2. No sobrescribiese cuando el log alcanzará la capacidad máximo, es decir, que archive el log.
   3. Indica cual es la ruta y el nombre del log seleccionado.
   4. ¿Qué sucede si vas a dicha carpeta y abres con doble click el log seleccionado?
3. Genera un informe de tu sistema.
4. Crea un Segundo adaptador de red en tu máquina virtual de Windows Server 2019.
5. Crea un equipo de NIC y muestra el proceso mediante un vídeo o mediante capturas de pantalla.
6. Configura una IP fija en tu NIC virtual.

**Visor de Eventos.**

Esta herramienta nos mostrará la información del estado de las aplicaciones y servicios de nuestro servidor.

Debemos habituarnos a ver el visor de eventos de forma regular para confirmar que nuestros servicios no están fallando o a punto de fallar.  El visor de eventos  también resulta útil para sacar la información en caso de que un servicio esté fallando.

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/001.png" width="900"/>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/002.png" width="900"/>
  <figcaption>Visor de Eventos Windows Server.</figcaption>
</figure>



Podemos **filtrar los eventos** por tiempo (últimas 24h, 1h, 30 min, …), por aplicación que ha generado el evento, usuarios, etc…

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/003.png" width="900"/>
  <figcaption>Filtrar Eventos por tiempos.</figcaption>
</figure>

Una cosa importante es la política de eventos con las aplicaciones, especialmente aquellas que ofrecen un servicio y son más propicias a ser atacadas o más críticas. Se asigna una cantidad de memoria que pueden usar los registros (logs), pasado esta capacidad se debe decidir **si sobrescribir o no sobrescribir** los logs. Lo habitual sería no sobrescribir, pero debemos estar atentos a la capacidad total que van acumulando para ir eliminándolos manualmente o mediante un script cada cierto tiempo.

Con el icono **vaciar registro** podemos borrar los eventos de la aplicación seleccionada.

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/004.png" width="900"/>
  <figcaption>Borrar Eventos de la aplicación.</figcaption>
</figure>

En caso de tener un **error** del sistema podemos visualizarlos en la pestaña de “Sistema”, cada error registrado del sistema tiene un **identificador (ID)** que será el que usemos en caso de querer buscar información del error en Internet.

Es recomendable, mirar todos los días el registro de eventos del sistema.

Importante diferenciar entre un “Error” y un “Warning / Aviso”, el primero es que ya ha habido un problema grave que debe ser resuelto, el segundo es una alerta de algo que debería revisarse, pero que no ha ocasionado un problema crítico.

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/005.png" width="900"/>
  <figcaption>Comprobar errores del sistema.</figcaption>
</figure>

Al igual que con las aplicaciones podemos decidir qué hacer con los registros de eventos referidos al sistema:

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/005.png" width="900"/>
  <figcaption>Registros de Eventos del sistema.</figcaption>
</figure>

**Monitor de recursos.**

El monitor de recursos nos da información sobre la memoria libre, el rendimiento de la cpu, lecturas en disco, etc. Esto nos puede dar información si fuera necesario ampliar o mejorar algún componente hardware de nuestro servidor.

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/006.png" width="900"/>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/007.png" width="900"/>
</figure>

Si queremos analizar o monitorizar valores más específicos debemos ir al monitor de rendimiento y añadir a la gráfica los datos que deseamos.

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/008.png" width="900"/>
  <figcaption>Estadísticas de datos seleccionados.</figcaption>
</figure>

Podemos generar un resumen/**informe** de todo el sistema, referente al rendimiento de éste:

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/009.png" width="600"/>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/010.png" width="900"/>
  <figcaption>Generación informe I.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/011.png" width="900"/>
  <figcaption>Generación informe II.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/012.png" width="900"/>
  <figcaption>Generación informe III.</figcaption>
</figure>

**Podemos exportar a algún fichero el resumen de todo el informe del rendimiento del sistema.**

<figure>
  <img src="./imagenes/02/PracticasAD/confBas3/013.png" width="400"/>
  <figcaption>Generación informe IV.</figcaption>
</figure>

## NIC redundante

Una NIC (Network Interface Controller) no es más que un adaptador de red o tarjeta de red. Con una NIC redundante queremos decir que uno o más adaptadores de red trabajan como uno, pudiendo mejorar el ancho de banda total que puede cursar y dotando al sistema de una mayor disponibilidad, pues si uno de los adaptadores de red fallara, tendríamos otros y no se cortaría la conexión.

!!! Tip
    Es muy habitual en todos los servidores tener más de un adaptador de red.

* **En el siguiente vídeo puedes encontrar una ayuda para realizar un NIC redundante**

[PINCHA AQUÍ para video de Configuración NIC Redundante](https://youtu.be/nA1jYIvBFBU)


