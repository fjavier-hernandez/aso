# Introducción

Para administrar sistemas operativos es crucial manejar y dominar las interfaces (terminales) disponibles que nos permiten gestionarlos, entre dichas interfaces destacan los siguientes tipos:

* De líneas texto (**CLI**, Command-Line Interface, interfaz de línea de comandos),
* Gráficos (**GUI**, Graphical User Interface, interfaz gráfica de usuario),
* De lenguaje natural (**NUI**, Natural User Interface, interfaz natural de usuario, ejemplo SIRI en IOS).

Este tema se centra en Sistemas basados en código libre del tipo UNIX, debido a su amplio despliegue en empresas para implementar servicios, más en concreto de distribuciones **Linux/GNU**.

El CLI de las distribuciones de **Linux/GNU** es conocido como Shell o terminal, con esta interfaz es posible crear cualquier comando que el usuario necesite, incluso para las tareas más específicas, **debido a estar directamente conectado al Kernel a diferencia de las aplicaciones como se puede observar en la siguiente figura**.

<figure>
  <img src="imagenes/01/EstructuraLinux.png" width="475"/>
  <figcaption>Estructura de Linux</figcaption>
</figure>

!!! tip "**NOTA**"
    * Por lo tanto, es buena práctica que el administrador del sistemas tenga conocimientos en el manejo y gestión del terminal Shell, así como en la programación de scripts.

## Shell

* En informática, el **shell o intérprete de comandos**, es el programa informático que permite a los usuarios interactuar con el sistema, procesando las órdenes que se le indican; además provee una interfaz de usuario para acceder a los servicios del sistema operativo.
* Los comandos ejecutables desde el shell pueden clasificarse en *internos* (corresponden en realidad a órdenes interpretadas por el propio shell) y *externos* (corresponden a ficheros ejecutables externos al shell, conocidos como guiones o scripts).

!!! info "**IMPORTANTE:**"
    * Linux dispone de varios Shell diferentes *csh*, *bash*, *sh*, *ksh*, *zsh*, etc... A destacar:
    * **sh (Bourne Shell)**: este shell fue usado desde las primeras versiones de Unix (Unix Versión 7). Recibe ese nombre por su desarrollador, *Stephen Bourne*, de los Laboratorios *Bell de AT&T*.
    * **bash**: fue desarrollado para ser un superconjunto de la funcionalidad del Bourne Shell, siendo el intérprete de comandos asignado por defecto a los usuarios en las distribuciones de Linux, por lo que es el shell empleado en la mayoría de las consolas de comandos de Linux. Se caracteriza por una gran funcionalidad adicional a la del Bourne Shell.
    * Para intentar homogeneizar esta diversidad de shells, el **IEEE** definió un estándar de «intérprete de comandos» bajo la especificación **POSIX 1003.2** (también recogida como **ISO 9945.2**). La creación de dicho estándar se basó en la sintaxis que presentaban múltiples shells de la familia Bourne shell.
    * **bash** respeta completamente el estándar POSIX, sobre el que añade un número considerable de extensiones (estructura select, arrays, mayor número de operadores,…). En este tema utilizaremos el Shell de **bash**.

### Formato comandos

 En general, el formato de las órdenes de GNU/Linux es el siguiente:

* **Comando**, que indica la acción que se va a ejecutar.
* **Modificadores**, que cambian el comportamiento estándar del comando para adaptarlo a las necesidades.
* **Argumentos**, elementos necesarios para realizar la acción del comando.

!!! Warning
    * Un dato a tener en cuenta cuando se trabaja con un terminal, es que GNU/Linux distingue entre mayúsculas y nimúsculas, es decir, la ejecución de comandos en el CLI de Linux es **CASE SENSITIVE**.


### Principales comandos

| Comando      | Acción                               | Comando      | Acción                                  |
| ------------ | ------------------------------------ | ------------ | --------------------------------------- |
| `ls `      | muestra el contenido de una carpeta  | `uname`    | muestra información del sistema         |
| `df`       | muestra estado del disco             | `cd`       | cambiar de directorio                   |
| `fsck`     | comprueba integridad de discos       | `mkdir`    | crear directorios                       |
| `mount`    | monta particiones y volúmenes        | `shutdown` | apaga el equipo (*restart* o *reboot*)  |
| `unmount`  | desmonta particiones y volúmenes     | `clear`    | limpia la pantalla                      |
| `fdisk`    | administra particiones               | `date/cal` | muestra hora/calendario del sistema     |
| `echo`     | imprime por pantalla                 | `who`      | muestra quien está conectado            |

## Shell Script en GNU/Linux

* Un Shell script (guión) es un archivo de texto que contiene una serie de comandos que, ordenados de forma específica, realizan la tarea para la que fueron diseñados, es decir, es un programa escrito de comandos Shell para ser ejecutados de forma secuencial.
* De esta forma se pueden automatizar tareas repetitivas ahorrando tiempo al administrador.
* Un programa escrito en shell se denomina shellscript, programa shell o simplemente un shell.

### Estructura general

* En su forma más básica, un shell-script puede ser un simple fichero de texto que contenga uno o varios comandos. 
* Para ayudar a la identificación del contenido a partir del nombre del archivo, es habitual que los shell scripts tengan la extensión «.sh»,
* Se seguirá este criterio pero hay que tener en cuenta que es informativo y opcional.

``` yaml
#!/bin/bash
#*********************************
#Este es mi primer script
#*********************************
echo Hola Mundo
#Esto es un comentario, soy muy útil.
```

### Creación Shell scripts

* Para crear un script utilizaremos cualquiera de los editores de texto plano como *vi*, *vim* , *nano*.
* Después de crear el archivo hay que dotarlo de permisos de lectura y ejecución. 

``` yaml
chmod ugo=rx script.sh
```

* Para ejecutar el archivo: (ubicados en la carpeta que contiene el archivo), se pueden utilizar el siguiente archivo:

    ``` yaml
    ./script.sh
    ```

* Además se puede utilizar otro método que consiste en definir la carpeta dentro de la variable de entorno **PATH** (editando el fichero **.bashrc**.) Una vez realizado ya se podría ejecutar directamente el fichero con el nombre del script.

    ``` yaml
    mkdir /home/administrador/scripts
    PATH=$PATH:/home/administrador/scripts
    export PATH
    ```

!!! info "**NOTA**"        
    * La primera forma ejecutará el contenido del shell script en un subshell o hilo del terminal original. El programa se ejecuta hasta que se terminan las órdenes del archivo, se recibe una señal de finalización, se encuentra un error sintáctico o se llega a una orden **exit**. Cuando el programa termina, el subshell muere y el terminal original toma el control del sistema. 
    * Esto no ocurre si se usa la opción de **PATH**, la cual ejecuta el contenido del shell script en el mismo terminal donde fue invocado.

### El primer Shellscript

* Crea un ejemplo llamado *listar.sh*, se aconseja ejecutar los siguientes comandos de forma secuencial.

``` yaml
cd ~
mkdir scripts
cd scripts
touch listar.sh
nano listar.sh
```

* Genera, guarda y prueba el siguiente código.

``` yaml
#! /bin/bash
clear
ls -la
echo “Listado realizado el “$(date)
```

### Comentarios 

* Para realizar un comentario se usa el carácter **#**
* Cuando el terminal encuentra una línea que comienza con este carácter, ignora todo lo que existe desde él hasta el final de línea.
* A esta regla existe una excepción:

``` yaml
    #!/bin/bash
```

!!! info
    * Es el "Shebang" Indica el terminal que será utilizado por el shell script, no un comentario.
    * Esta línea debe ser la primera del fichero que, aún siendo opcional, indica el tipo de lenguaje en el que ha sido escrito el programa.
    * Si la versión de GNU/Linux dispone de el terminal especificado en esta línea, ejecutará el código con él, si no es así, utilizará el que por defecto tenga asignado el usuario que lo ejecuta.

## Depuración

Esta tarea no es sencilla en ShellScripting, aun así se recomienda los siguientes métodos de depuración, apoyados en los siguientes argumentos a la hora de ejecutar el script:

* `-x` &#8594 Expande cada orden simple, e imprime por pantalla la orden con sus argumentos, y a continuación su salida.
* `-v` &#8594 Imprime en pantalla cada elemento completo del script (estructura de control, …) y a continuación su salida.

Además en el propio Script se pueden utilizar los siguientes comandos:

| Comando      | Acción                               | 
| ------------ | ------------------------------------ | 
| `set -x` `set –xv`      | Activa las trazas/verbose. Se debe ubicar justo antes del trozo del script que se desea depurar.  | 
| `set +x` `set +xv`      | Desactiva las trazas/verbose. Ubicarlo justo después del trozo del script que se desea depurar.| 

## Actividades

!!! note
    Escribe el código de los scripts en **ShellScript** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.

101. Crea un shell script que muestre por pantalla el mensaje “**¡Hola Mundo!**”.

102. Realiza un script que guarde en un fichero el listado de archivos y directorios de la carpeta *etc*, a posteriori que imprima por pantalla dicho listado.

103. Modifica el script anterior para que además muestre por pantalla el número de líneas del archivo y el número de palabras.

104. Depura los ejercicios anteriores utilizando los argumentos `-x` y `-v`.