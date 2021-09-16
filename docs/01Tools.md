# Tools: Scripting y Docker

??? abstract "Duración y criterios de evaluación"

    **Duración estimada: 9 sesiones (2h por sesión)**

    <hr />

    Resultado de aprendizaje:

    1. Utiliza lenguajes de guiones en sistemas operativos, describiendo su aplicación y administrando servicios del sistema operativo.

    Criterios de evaluación:

    1. Se han utilizado y combinado las estructuras del lenguaje para crear guiones.
    2. Se han utilizado herramientas para depurar errores sintácticos y de ejecución.
    3. Se han interpretado guiones de configuración del sistema operativo.
    4. Se han realizado cambios y adaptaciones de guiones del sistema.
    5. Se han creado y probado guiones de administración de servicios.
    6. Se han creado y probado guiones de automatización de tareas.
    7. Se han implantado guiones en sistemas libres y propietarios.
    8. Se han consultado y utilizado librerías de funciones.
    9. Se han documentado los guiones creados.

## Introducción Linux

### Breve Historia

* **1969** La empresa AT&T desarrolla el sistema operativo UNIX y vendido posteriormente a Novell.
* **1983** Richard Stallman comienza el proyecto GNU (GNU is Not Unix) para crear un sistema operativo tipo UNIX pero de software libre.
    * Software libre: Aquel software, que una vez adquirido (no tiene porque ser gratuito), puede ser usado, copiado, modificado y redistribuido.
* **1985** Microsoft publica Windows, un sistema operativo con interfaz gráfica de usuario (GUI) para su propio sistema operativo MS-DOS.
* **1991** Linus Torvald comienza a programar el sistema operativo Linux (Linus + UNIX). El código era totalmente nuevo, pero emulaba el funcionamiento del sistema operativo MINIX (Tanenbaum), que era un clon de UNIX.
* **1992** Se juntan el proyecto Linux y GNU → GNU/Linux.
* **2001** Se lanza el primer sistema operativo MAC (MAC OS X) con interfaz de escritorio. MAC está basado en UNIX.

### Principales Autores
<figure>
  <img src="imagenes/01/HistoriaLinux.png" />
  <figcaption>Principales Autores GNU/Linux</figcaption>
</figure>

### Características

* Software Libre → Cualquiera puede usarlo o descargarlo.
    * Licencias GPL (General Public License) de GNU.
* Código Abierto → Cualquiera puede ver y modificar el código.

### Distribuciones

* Gratuitas:
    * Ubuntu, CentOS, Mint, Fedora, Knoppix, OpenSUSE.
    * En el caso de Ubuntu sacan distribuciones LTS que tienen mayor tiempo de actualizaciones. 
    * Las versiones indican el año y el mes en que se saca dicha versión.
        * Por ejemplo 17.04 (Año 2017, Abril).
* Pago: RedHat o SUSE.
    * Se paga por el soporte, no por el software en sí.
    * Las distribuciones de pago también suelen tener sus versiones gratuitas.

### Principales distribuciones
<figure>
  <img src="imagenes/01/distribuciones.png" />
  <figcaption>Algunas Distribuciones de Linux</figcaption>
</figure>

### Terminal de comandos

 * En un terminal (Shell) es posible crear cualquier comando que el usuario necesite, incluso para las tareas más específicas. 
 * Es buena práctica que el administrador del sistema tenga conocimientos en el manejo del terminal así como en la programación de scripts.

<figure style="float: right;">
    <img src="imagenes/01/CaseSensitive.png" width="250">
    <figcaption></figcaption>
    </figure>

 En general, el formato de las órdenes de GNU/Linux es el siguiente:

* **Comando**, que indica la acción que se va a ejecutar.
* **Modificadores**, que cambian el comportamiento estándar del comando para adaptarlo a las necesidades.
* **Argumentos**, elementos necesarios para realizar la acción del comando.

## Scripts de Linux. (bash)

* Linux dispone de varios Shell diferentes *csh*, *bash*, *sh*, *ksh*, *zsh*, etc... 
* En este tema utilizaremos el Shell bash. 
* En Linux los procedimientos de comandos se conocen como scripts (guiones).
* Un programa escrito en shell se denomina shellscript, programa shell o simplemente un shell.
* un shellscript es un archivo de texto que contiene una serie de comandos que, ordenados de alguna forma específica, realizan la tarea para la que fueron diseñados. 
* Para crear un script utilizaremos cualquiera de los editores de texto plano como vi,vim ,nano,joe,etc. 