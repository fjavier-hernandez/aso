---
title: Introducción - Introducción a Shellscripting
description: Realización de scripts mediante Shell.
subtitle: Introducción Shellscripting
# tags:
#     - Introducción Shellscripting
#     - RA7
---

# Shellscripting

El shell scripting es una técnica que permite crear scripts —archivos de texto con instrucciones— para automatizar tareas y procesos repetitivos mediante un intérprete de comandos, como Bash. Es especialmente útil en sistemas operativos basados en Unix y Linux, donde facilita la administración del sistema, la ejecución de rutinas y la integración de herramientas. 

Estos scripts no se compilan, sino que se ejecutan línea por línea por el shell, permitiendo realizar desde la manipulación de archivos hasta la ejecución automática de programas complejos. 


## Propuesta didáctica

En esta unidad vamos a comenzar a trabajar el **RA7 de ASO**:

> **RA7.** *Utiliza lenguajes de guiones en sistemas operativos, describiendo su aplicación y administrando servicios del sistema operativo.*

### Criterios de evaluación (RA7)

A lo largo de la unidad se trabajarán y evidenciarán los siguientes criterios:

- **CE7a**: Se han utilizado y combinado las estructuras del lenguaje para crear guiones.  
- **CE7b**: Se han utilizado herramientas para depurar errores sintácticos y de ejecución.  
- **CE7c**: Se han interpretado guiones de configuración del sistema operativo.  
- **CE7d**: Se han realizado cambios y adaptaciones de guiones del sistema.  
- **CE7e**: Se han creado y probado guiones de administración de servicios.  
- **CE7f**: Se han creado y probado guiones de automatización de tareas.  
- **CE7g**: Se han implantado guiones en **sistemas libres**.  
- **CE7h**: Se han consultado y utilizado librerías de funciones.  
- **CE7i**: Se han documentado los guiones creados.

## Contenidos

**Bloque 1 — Fundamentos del Shell (Sesión 1–2)**
- ¿Qué es un shell? CLI vs GUI.  
- Formato general de órdenes en GNU/Linux.  
- Comandos básicos de terminal.  
- Creación y ejecución de scripts: permisos y `$PATH`.  
- Comentarios y buenas prácticas.

**Bloque 2 — Elementos del lenguaje (Sesión 2–3)**
- Variables y parámetros (`$0`, `$1`, `$#`, `$*`, `$?`).  
- Entrada/salida con `echo` y `read`.  
- Operadores: aritméticos, relacionales y lógicos.  
- Cálculo con `let` y expansión aritmética `$(( ))`.

**Bloque 3 — Control de flujo (Sesión 3–4)**
- Estructuras condicionales: `if`, `elif`, `else`, `case`.  
- Bucles: `for`, `while`, `until`.  
- `break`, `continue`, `exit`.

**Bloque 4 — Estructuras y modularización (Sesión 4–5)**
- Vectores (arrays) y recorrido.  
- Funciones, parámetros y retorno.  
- `source` y organización del código.

!!! question "Actividades iniciales"
    1. Introduce el comando para mostrar tu ubicación actual en el sistema.
    1. Introduce el comando para listar los archivos y directorios en tu ubicación actual.
    1. Introduce el comando para crear un archivo vacío llamado `prueba.txt` en tu ubicación actual.
    1. Introduce el comando para cambiar al directorio raíz del sistema.
    1. Introduce el comando para crear un directorio llamado `nuevo_directorio` en tu ubicación actual.
    1. Introduce el comando para eliminar el directorio `nuevo_directorio` que creaste anteriormente.
    1. Introduce el comando para mostrar el contenido del archivo `/etc/passwd`.
    1. Introduce el comando para contar las líneas de un archivo llamado `prueba.txt`.
    1. Introduce el comando para buscar la palabra `"root"` en el archivo `/etc/passwd`.

### Programación de Aula (8h)

Esta unidad se imparte en la primera evaluación, con una duración estimada de 8 sesiones lectivas, durante la última quincena de septiembre:

#### Sesiones 1-3: Contenidos Fundamentales

| Sesión | Contenidos | Actividades | Criterios trabajados |
| --- | --- | --- | --- |
| 1  | Presentación de la UD y objetivos de sesión | Cuestionario inicial, AC101-AC103 | CE7a, CE7b, CE7g y CE7i |
| 2  | Variables, entrada/salida y operadores | AC104, AC105, AC106 | CE7a, CE7b, CE7f y CE7i |
| 3      | Control de flujo: condicionales y bucles   | AC108, AC109, AC110          | CE7a, CE7f, CE7i               |

#### Sesiones 4-5: Contenidos Avanzados

| Sesión | Contenidos | Actividades | Criterios trabajados |
| --- | --- | --- | --- |
| 4      | Vectores y funciones   | AC111-AC114          | CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h, CE7i               |
| 5      | Reto grupal - Desarrollo   | RETO GRUPAL (Sesión 1)          | CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h, CE7i               |

#### Sesiones 6-8: Reto Grupal

| Sesión | Contenidos | Actividades | Criterios trabajados |
| --- | --- | --- | --- |
| 6      | Reto grupal - Desarrollo   | RETO GRUPAL (Sesión 2)          | CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h, CE7i               |
| 7      | Reto grupal - Finalización   | RETO GRUPAL (Sesión 3)          | CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h, CE7i               |
| 8      | Presentación y evaluación   | DEMO GRUPAL, Evaluación          | CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h, CE7i               |

---

## Introducción

Para administrar sistemas operativos es crucial manejar y dominar las interfaces (terminales) disponibles que nos permiten gestionarlos. Entre dichas interfaces destacan los siguientes tipos:

* De líneas  de texto (**CLI**, Command-Line Interface, interfaz de línea de comandos),
* Gráficos/ventanas (**GUI**, Graphical User Interface, interfaz gráfica de usuario),
* De lenguaje natural (**NUI**, Natural User Interface, interfaz natural de usuario, ejemplo SIRI en IOS).

Este tema se centra en Sistemas basados en código libre del tipo UNIX, debido a su amplio despliegue en empresas para implementar servicios, más en concreto de distribuciones **Linux/GNU**.

El CLI de las distribuciones de **Linux/GNU** es conocido como Shell o terminal, con esta interfaz es posible crear cualquier comando que el usuario necesite, incluso para las tareas más específicas, **debido a estar directamente conectado al Kernel a diferencia de las aplicaciones como se puede observar en la siguiente figura**.

<figure>
  <img src="imagenes/01/EstructuraLinux.png" width="475"/>
  <figcaption>Estructura de Linux</figcaption>
</figure>

!!! tip "**NOTA**"
    * Por lo tanto, es buena práctica que el administrador del sistemas tenga conocimientos en el manejo y gestión del terminal Shell, **así como en la programación de scripts**.

## Shell

* En informática, el **shell o intérprete de comandos**, es el programa informático que permite a los usuarios interactuar con el sistema, procesando las órdenes que se le indican; además provee una interfaz de usuario para acceder a los servicios del sistema operativo.
* Los comandos ejecutables desde el shell pueden clasificarse en **internos** (corresponden en realidad a órdenes interpretadas por el propio shell) y **externos** (corresponden a ficheros ejecutables externos al shell, conocidos como guiones o scripts).

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
    * Un dato a tener en cuenta cuando se trabaja con un terminal, es que GNU/Linux distingue entre mayúsculas y minúsculas, es decir, la ejecución de comandos en el CLI de Linux es **CASE SENSITIVE**.


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

* Un Shell script (guion) es un archivo de texto que contiene una serie de comandos que, ordenados de forma específica, realizan la tarea para la que fueron diseñados, es decir, es un programa escrito de comandos Shell para ser ejecutados de forma secuencial.
* De esta forma se pueden automatizar tareas repetitivas ahorrando tiempo al administrador.
* Un programa escrito en shell se denomina shellscript, programa shell o simplemente un shell.

### Estructura general

* En su forma más básica, un shell-script puede ser un simple fichero de texto que contenga uno o varios comandos.
* Para ayudar a la identificación del contenido a partir del nombre del archivo, es habitual que los shell scripts tengan la extensión «.sh»,
* Se seguirá este criterio pero hay que tener en cuenta que es informativo y opcional.

``` bash
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

``` bash
chmod ugo=rx script.sh
```

* Para ejecutar el archivo: (ubicados en la carpeta que contiene el archivo), se pueden utilizar el siguiente archivo:

    ``` bash
    ./script.sh
    ```

* Además se puede utilizar otro método que consiste en definir la carpeta dentro de la variable de entorno **PATH** (editando el fichero **.bashrc**.) Una vez realizado ya se podría ejecutar directamente el fichero con el nombre del script.

    ``` bash
    mkdir /home/administrador/scripts
    PATH=$PATH:/home/administrador/scripts
    export PATH
    ```

!!! info "**NOTA**"        
    * La primera forma ejecutará el contenido del shell script en un subshell o hilo del terminal original. El programa se ejecuta hasta que se terminan las órdenes del archivo, se recibe una señal de finalización, se encuentra un error sintáctico o se llega a una orden **exit**. Cuando el programa termina, el subshell muere y el terminal original toma el control del sistema. 
    * Esto no ocurre si se usa la opción de **PATH**, la cual ejecuta el contenido del shell script en el mismo terminal donde fue invocado.

### El primer Shellscript

* Crea un ejemplo llamado *listar.sh*, se aconseja ejecutar los siguientes comandos de forma secuencial.

``` bash
cd ~
mkdir scripts
cd scripts
touch listar.sh
nano listar.sh
```

* Genera, guarda y prueba el siguiente código.

``` bash
#! /bin/bash
clear
ls -la
echo “Listado realizado el “$(date)
```

### Comentarios 

* Para realizar un comentario se usa el carácter **#**
* Cuando el terminal encuentra una línea que comienza con este carácter, ignora todo lo que existe desde él hasta el final de línea.
* A esta regla existe una excepción:

``` bash
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

---

## Sintaxis
### Argumentos o Parámetros

* Son especificaciones que se le hacen al programa al momento de llamarlo.
* Introducen un valor, cadena o variable dentro del script.
* Utilización de parámetros:

| Símbolo                           | Función                                                                                       |
| --------------------------------- | --------------------------------------------------------------------------------------------- |
| `$1`                            | representa el 1º parámetro pasado al script                                                   |
| `$2`                            | representa el 2º parámetro                                                                    |
| `$3 `                           | representa el 3º parámetro (podemos usar hasta $9)                                            |
| `$*`                            | representa todos los parámetros separados por espacio                                         |
| `$#`                            | representa el número de parámetros que se han pasado                                          |
| `$0 `                           | representa el parámetro 0, es decir, el nombre del script o el nombre de la función           |

* Ejemplo:

``` bash
#!/bin/bash
echo ‘El primer parámetro que se ha pasado es ‘ $1
echo ‘El tercer parámetro que se ha pasado es ‘ $3
echo ‘El conjunto de todos los parámetros : ‘ $*
echo ‘Me has pasado un total de ‘ $# ‘ parámetros’”
echo ‘El parámetro 0 es : ‘ $0
#Fin del script
```

* Si por ejemplo se enviasen los siguientes parámetros:

``` bash
./script.sh  Caballo  Perro  675 Nueva
```

* Se obtendría la siguiente salida:

``` bash
El primer parámetro que se ha pasado es Caballo
El tercer parámetro que se ha pasado es 675
El conjunto de todos los parámetros : Caballo Perro 675 Nueva
Me has pasado un total de 4 parámetros
El parámetro 0 es : ./script.sh
```

!!! info
    * Argumento especial `$?`
    * Contiene el valor que devuelve la ejecución de un comando. 
    * Puede tener dos valores: **cero** si se ha **ejecutado bien** y se interpreta como verdadero, o **distinto de cero** si se ha **ejecutado mal** y se interpreta como falso.
        * `0`  -> Si el último comando se ejecutó con éxito
        * `!0` -> Si el último comando no de ejecutó con éxito

### Variables

* Es un parámetro que cambia su valor durante la ejecución del programa.
* Se da un nombre para identificarla y recuperarla, antecedido por el carácter `$`.

!!! info
    * En shellscript **no se declaran y no importa el tipo**.
    * El nombre de la variable puede estar compuesto por **letras y números** y por el carácter subrayado “`_`”.

* Ejemplo:

``` bash
#! /bin/bash
#*********************************
#Este es mi segundo script
#*********************************
MIVARIABLE=‘Administración de Sistemas Operativos ASO’
echo $MIVARIABLE
```

!!! warning 
    * Deben empezar por **letra** o “`_`”
    * En ningún caso pueden empezar por un número, ya que esa nomenclatura está reservada a los parámetros.
    * El contenido de estas variables será siempre tomado como si fuesen cadenas alfanuméricas, es decir, serán tratadas como cadenas de texto. Por lo tanto se necesitan operandos o comandos específicos para realizar operaciones con valores numéricos de las variables. Explicado en el apartado de **Operadores Aritméticos**.

### Variables de entorno

* Cada terminal durante su ejecución tiene acceso a dos ámbitos de memoria:
    1. **Datos Locales** Una variable declarada en un terminal solo será accesible desde el terminal en el que declara.
    2. **Datos Global** Engloban a todos los terminales que se estén ejecutando. Son las denominadas **Variables de Entorno**.

Ejemplo de principales variables de entorno:

| Variable                          | Función                                               |
| --------------------------------- | ----------------------------------------------------- |
| `$BASH`                         | Ruta del programa Bash                                |
| `$HOME`                         | Ruta completa del home del usuario                    |
| `$PATH`                         | Lista los directorios de donde se buscan los programas    |
| `$RANDOM`                       | Devuelve un valor numérico aleatorio                  |

### Entrada y salida del Shell Script

* Para poder interactuar con un programa de terminal es necesario disponer de un mecanismo de entrada de datos.
* Para dinamizar el resultado de los shell scripts y un dispositivo de salida que mantenga informado al usuario en todo momento de los que está ocurriendo.
* Para la entrada de datos se utiliza el comando **read** y para la salida el comando **echo**.

#### echo
* Su tarea es la de mostrar información con mensajes de texto lanzados por pantalla

| Modificador | Función  |
| ------------| -------- |
| `-e`| para usar las opciones hay que utilizar este modificador  |
| `\c`  | Sirve para eliminar el salto de línea natural del comando **echo**.  |
| `\n`  | nueva línea.  |
| `\t`  | tabulador horizontal.  |
| `\v`  | tabulador vertical.  |


!!! info
    * Si se antepone el símbolo del dólar delante de una variable, mostrará su contenido.
    * Si es necesario mostrar frases con espacios, debe situarse entre comillas.
    
!!! warning
    * La orden echo permite expandir variables siempre que se usen las comillas dobles.

* Ejemplo:
``` bash
#!/bin/bash
NOMBRE=Javi
echo “hola $NOMBRE”
```
* El texto mostrado por pantalla será: **hola javi**

#### read
* Esta herramienta asigna el texto que el usuario ha escrito en el terminal a una o más variables.
* Lo que hace **read** es detener la ejecución del shell script y pasa el testigo al usuario.
* Hasta que éste no introduzca los datos, la ejecución del programa no avanzará.

* Ejemplo:
``` bash
#!/bin/bash
echo “Introduce tu nombre: ”
read NOMBRE
echo “Hola $NOMBRE”
```

!!! info
    Cuando se utiliza read con varios nombres de variables, el primer campo tecleado por el usuario se asigna a la primera variable, el segundo campo a la segunda y así sucesivamente

* Ejemplo:
``` bash
#!/bin/bash
read -p “Introduce tres números (separados por un espacio): ” num1 num2 num3
echo “Los número introducidos son $num1, $num2 y $num3”
```

!!! info
    En este ejemplo se ha usado el modificador **-p** el cual permite imprimir un mensaje antes de la recogida de los datos, prescindiendo de primer comando **echo** del ejemplo anterior.

### Operadores en shell script

* Todas las variables creadas en un terminal se tratan como cadenas de texto, incluso si su contenido es solo numérico.
* Este es el motivo por el cual si lanzamos el siguiente código, no se obtendrá el resultado esperado:

``` bash
#!/bin/bash
var1=15
var2=5
echo “$var1+$var2”
```
!!! warning
    * La salida de este programa no será un número **20**, sino la cadena de caracteres **15+5**. 
    * Esto es así porque la suma de cadenas de texto, son esas cadenas de texto unidas de forma consecutiva.

* Existen tres tipos de operadores según el trabajo que realicen: **aritméticos, relacionales** y **lógicos**

#### Aritméticos

* Los operadores aritméticos realizan operaciones matemáticas, como sumas o restas con operandos.
* "Manipulan" datos numéricos, tanto enteros como reales.

| Símbolo                           | Función                  |
| :---------------------------------: | ------------------------ |
| `+`                             | suma                     |
| `-`                             | resta                    |
| `*`                                 | multiplicación           |
| `/`                             | división                 |
| `%`                             | modulo (resto)           |
| `=`                             | asignación               |

* Ejemplo:

``` bash
#!/bin/bash
#*********************************
#Esto es mi tercer script
#*********************************

NUMERO=4
let SUMA=NUMERO+3
echo $SUMA
NUMERO=5
let SUMA=NUMERO+5
echo $SUMA
NUMERO=10
let SUMA=NUMERO-10
```    

#### Relacionales

* Este tipo de operadores tan sólo devuelven dos posibles valores; **verdadero o falso**.
* Existen subtipos según se comparen cadenas o números.

    **1.** **Operadores relacionales para números**

    | Operador | Acción |  
    |:-----:|------------------------------------------------|
    | `-eq` | Comprueba si dos números son iguales.          |
    | `-ne`| Detecta si dos números son diferentes.         |   
    | `-gt` | Revisa si la izquierda es mayor que derecha.   |  
    | `-lt` | Verifica si la izquierda es menor que derecha. | 
    | `-ge` | Coteja si la izquierda es mayor o igual que derecha.   |  
    | `-le` | Constata si la izquierda es menor o igual que derecha. |

    **2.** **Operadores relacionales para cadenas de texto o de cuerda**

    | Operador | Acción |  
    |:-----:|------------------------------------------------|
    | `-z` | Comprueba si la longitud de la cadena es cero.          |
    | `-n` | Evalúa si la longitud de la cadena no es cero.         |   
    | `=` | Verifica si las cadenas son iguales.   |  
    | `!=` | Coteja si las cadenas son diferentes. | 
    | `cadena` | Revisa si la cadena es nula.   |  
    
    **3.** **Operadores relacionales para archivos y directorios**

    | Operador | Acción |  
    |:-----:|------------------------------------------------|
    | `-a` | Comprueba si existe el archivo.           |
    | `-r` | Evalúa si el archivo esta vacío.         |   
    | `-w` | Confirma si existe el archivo y tiene permisos de escritura.  |  
    | `-x` | Constata si existe el archivo y tiene permisos de ejecución.  | 
    | `-f` | Escruta si existe y es un archivo de tipo regular.    |  
    | `-d` | Escruta si existe y es un archivo de tipo directorio.    |  
    | `-h` | Coteja si existe y es un enlace.     |  
    | `-s` | Revisa si existe el archivo y su tamaño es mayor a cero.   |  

#### Lógicos

* Se utilizan para evaluar condiciones, no elementos.
* Comprueba el resultado de dos operandos y devuelve verdadero o falso en función del valor que arrojen los operandos.
* Los tipos son:

 | Operador | Acción |  
    |:-----:|------------------------------------------------|
    | `&&` | `AND`, devuelve verdadero si todas condiciones que evalúa son verdaderas. Se puede representar: `-a` o `&&`.|
    | `||` | `OR`, da como resultado verdadero si alguna de las condiciones que evalúa es verdadera. Se representar: `-o` o `||`.|   
    | `!` | `negación`, invierte el significado del operando. de verdadero a falso, y viceversa. Con `!` o `not`.  |  

!!! info
    Para realizar cálculos aritméticos es necesario utilizar expresiones como **expr**, **let** o los **expansores**.

#### expr

* Este comando toma los argumentos dados como expresiones numéricas, los evalúa e imprime el resultado.
* Cada término de la expresión debe ir separado por espacios en blanco.
* Soporta diferentes operaciones: sumar, restar, multiplicar y dividir enteros utilizando los **operadores aritméticos** para el cálculo del módulo.

!!! tip
    * **MEJOR NO UTILIZAR** 
    * Desafortunadamente, **expr** es difícil de utilizar debido a las colisiones entre su sintaxis y la propia terminal.
    * Puesto que `*` es el símbolo comodín, deberá ir precedido por una barra invertida para que el terminal lo interprete literalmente como un asterisco.
    * Además, es muy incómodo de trabajar ya que los espacios entre los elementos de una expresión son críticos.

* Ejemplo:
``` bash
#!/bin/bash
var=5
resultado=`expr $1 + $var + 1
echo $resultado`
```

#### let

* Facilita la sintaxis de estas operaciones aritméticas reduciéndolas a la mínima expresión.
* No es necesario incluir el símbolo del dólar que precede a las variables.
* Se configura como un comando más cómodo de ejecutar.

* Ejemplo:
``` bash
#!/bin/bash
var=5
let resultado=$1+var+1
echo $resultado
```

#### expansores

* Para las operaciones aritméticas se utilizan los dobles paréntesis.
* Realizan la operación contenida dentro de ellos lanzando la ejecución fuera de ellos una vez resuelta.

* Ejemplo:
``` bash
#!/bin/bash
var=5
echo $(($1+$var+1))
echo $(($1 + $var + 1))
```

!!! tip
    **Consejo de uso**, ya que es mucho más intuitivo que las anteriores expresiones.

### Redirecciones

* Una **redirección** consiste en trasladar la información de un fichero de dispositivo a otro.
* Para ello se utilizan los siguientes símbolos:
    
    | Símbolo | Acción |  
    |:-----:|------------------------------------------------|
    | `<` | redirecciona la entrada desde el fichero **stdin** (entrada estándar)|
    | `>` | envía la salida de **stdout** (salida estándar) a un fichero especificado|
    | `>>` | añade la salida de **stdout** (salida estándar) a un fichero especificado|
    | `2>` | envía la salida de **stderr** (error estándar) a un fichero especificado|
* Ejemplo:

``` bash
sh script.sh 2>/dev/null
```
!!! info
    El objetivo de la expresión anterior puede ser utilizada en la administración de sistemas para descartar el error estándar de un proceso, de esta forma no aparecerán los mensajes de error por el terminal; **es muy utilizado**.


### Tuberías

* Forma práctica de **redireccionar la salida estándar de un programa** hacia la entrada estándar de otro.
* Esto se logra usando el símbolo `|` (pipeline). Ejemplo:

``` bash
$ cat archivo.txt | wc
```

!!! info
    El comando anterior utiliza tuberías para redireccionar la salida estándar del comando cat y pasarla como entrada estándar del comando wc para contar las líneas y palabras de un archivo.

### alias

* Alias es un comando que se ejecuta desde un terminal que permite configurar vínculos entre varios comandos.
* Cada usuario puede asignar una palabra fácil de recordar a uno o más comandos que, por lo general, pueden ser más complicados de recordar.
* Ejemplo:

``` bash
$ alias listado='ls -lia'
```

---

## Control de Flujo

### Sistema de notación

* Antes de lanzarse a escribir una sola línea de código es necesario pensar en la resolución del problema tal y como se ha indicado.
* La creación de una solución a un problema siguiendo un conjunto de instrucciones se denomina algoritmo.
* Es necesario invertir el tiempo suficiente para construir ese algoritmo ya que esa será la solución que se debe implementar en código.
* Existen varios sistemas de representación para describir esos algoritmos, como por ejemplo, **pseudocódigo** o la descripción narrada, pero en este manual se ha optado por **los diagramas de flujo** ya que resultan más intuitivos.

#### Diagramas de flujo

* Los diagramas de flujo o flujogramas son la representación gráfica de la solución algorítmica de un problema.
* Para diseñarlos se emplean figuras normalizadas que representan una acción dentro del procedimiento.
* Cada una de estas figuras representa un paso a seguir dentro del algoritmo.

!!! note "NOTA"
    * Para su construcción se han de respetar las siguientes reglas:
        1. Tiene un elemento de inicio en la parte superior y uno final en la parte inferior.
        2. Se escribe de arriba hacia abajo y de izquierda a derecha.
        3. Siempre se usan flechas verticales u horizontales, jamás curvas u oblicuas
        4. Se debe evitar cruce de flujos.
        5. En cada paso expresar una acción concreta.

En la siguiente figura se puede observar **simbología** para diseñar diagramas de flujo.

<figure>
  <img src="imagenes/01/SimboloDiagrama.png" width="400"/>
  <figcaption>Simbología diagramas.</figcaption>
</figure>

## Estructuras

* Controlar el flujo es determinar el orden en el que se ejecutarán las instrucciones en un programa.
* Si no existiese las estructuras de control del flujo, todo el código se ejecutarían de forma secuencial, es decir, empezarían por la primera instrucción y se ejecutarían una a una hasta llegar a la última.
* Este modo de ejecución esta realizado por **estructuras secuenciales**. Ejemplo:

<figure>
  <img src="imagenes/01/EstructuraSecuencial.png" width="200"/>
  <figcaption>Estructura secuencial.</figcaption>
</figure>

!!! warning
    La estructura secuencial no es válida para solucionar la mayoría de los problemas que se plantean.

* Para ello es necesario la elección de un código u otro en función de ciertas condiciones, formando otro tipo de estructuras que son conocidas como **estructuras condicionales**; entre las cuales podemos destacar:
    1. **Estructuras Alternativas**, según si se cumple la condición o no, se realizará una tarea u otra.
        * Ejemplo de utilización con la sentencia: **if**.
    2. **Estructuras Iterativas**, cuando necesario ejecutar algunas instrucciones repetidas veces.
        * Ejemplo de utilización con la sentencia: **for**.

#### Estructuras alternativas

* Las estructuras de selección permiten ejecutar diferentes instrucciones dependiendo del valor de una variable o expresión.
* También se les llama ramificaciones, estructuras de decisión o alternativas.
* Cuando se usan, no todas las instrucciones del programa se ejecutan, solo las especificadas para el valor de la variable durante esa ejecución.
* Las estructuras de selección más comunes son las que proporcionan ramificaciones dobles (**if**) y múltiples (**elif** y **case**).

##### Estructura alternativa doble: **if**

* La forma general de la orden **if** es:

``` bash
if [ expresión ]
then
    realizar este código si expresión es verdadera
fi
```

<figure>
  <img src="imagenes/01/Estructura_If.png" width="200"/>
  <figcaption>Estructura alternativa simple.</figcaption>
</figure>

* Ejemplo: 
``` bash
if [ $# -eq 1 ]
then
    VAR=$1
fi
```

!!! info
    El código anterior comprueba se ha pasado algún argumento ,es decir, si han pasado un parámetro. En caso afirmativo, asigna el contenido de ese parámetro a la variable VAR.

!!! warning
    Hay que recordar siempre cerrar esta estructura para indicarle al terminal donde termina, en este caso, se cierra con la palabra reservada **fi**.

##### Estructura alternativa multiple if then else

* En este caso se contempla también la posibilidad de ejecutar alguna acción si no se cumple la expresión.
* La forma general del **if then else** es:

``` bash
if [ expresión ]
then
    realizar si expresión es verdadera
else
    realizar si expresión es falsa
fi
```

<figure>
  <img src="imagenes/01/Estructura_If_else.png" width="300"/>
  <figcaption>Estructura alternativa doble.</figcaption>
</figure>

* Ejemplo: 
``` bash
if [ $a -gt $b ]
then
    echo "$a es mayor que $b"
else
    echo "$a es menor que $b"
fi
```

##### La estructura if then elif else

* Permite una segunda evaluación para ejecutar código a través de la estructura **elif**.
* Es posible colocar tantos elif como condiciones se requiera evaluar.
* La forma general del **if then elif else** es:

``` bash
if [ exp1 ]
then
    realizar si exp1 es verdadera
elif [ exp2 ]
    then
    realizar si exp1 es falsa, pero es verdadera exp2
elif [ exp3 ]
then
    realizar si exp1 y exp2 son falsas, pero es verdadera exp3
else
    realizar si todas las expresiones son falsas
fi
```

* Ejemplo: 
``` bash
if [ $a -gt $b ]
then
    echo "$a es mayor que $b"
elif [ $a -eq $b ]
then
    echo "$a es igual que $b"
else
    echo "$a es menor que $b"
fi
```

!!! info
    Este ejemplo amplía el anterior comprobando si, además, los valores de a y b son iguales.

!!! warning
    El último caso se realiza con la sentencia **else**.

##### La estructura case

* La estructura case permite realizar varias acciones en función del valor de una variable.
* La limitación que tan sólo se comprueba si es igual a ese valor.
* La forma general del **case** es:

``` bash
case VARIABLE in
    valor1)
        Se ejecuta si VARIABLE tiene el valor1
        ;;
    valor2)
        Se ejecuta si VARIABLE tiene el valor2
        ;;
    *)
        Se ejecuta por defecto
        ;;
esac
```
<figure>
  <img src="imagenes/01/EstructuraAlternativaMultiple.png" width="600"/>
  <figcaption>Estructura Alternativa Multiple.</figcaption>
</figure>

#### Estructuras de iteración

* Son operaciones que se deben ejecutar un número repetido de veces para resolver un problema.
* El conjunto de instrucciones que se ejecuta dentro de esta estructura, se denomina ciclo, bucle o lazo.
* `Iteración` es cada una de las pasadas o ejecuciones de todas las instrucciones contenidas en el bucle.
* Estas repeticiones de código van a depender de la evaluación de una condición o del valor de una variable.
* Es posible repetir un código hasta que se cumpla o deje de cumplir una condición pero también se posible la repetición tantas veces como indique una variable.

!!! warning
    Hay que tener mucho cuidado a la hora de diseñar estas estructuras y no caer en el error de construir **bucles infinitos**, es decir, estructuras que nunca dejarán de ejecutarse ya que no tienen condición de salida o, si la tienen, ésta nunca se va a cumplir.

* Para utilizar esta estructura en algoritmos, se usan:

1. **Contador:** es una variable cuyo valor se incrementa o decrementa en una cantidad constante cada vez que se produce un determinado suceso o acción. Los contadores se utilizan con la finalidad de contar sucesos o acciones internas de un bucle.

!!! info "NOTA"
    La inicialización consiste en asignarle al contador un valor. Se situará antes y fuera del bucle.

2. **Acumulador o Totalizador** es una variable que suma sobre sí misma un conjunto de valores para de esta manera tener el total de todos ellos en una sola variable.

!!! info "NOTA"
    La diferencia entre un contador y un acumulador es que mientras el primero va aumentando de uno en uno, el acumulador va aumentando en una cantidad variable.

3. **Banderas**, conocidas también como interruptores, switch, flags o conmutadores. Son variables que pueden tomar solamente dos valores durante la ejecución del programa, los cuales pueden ser **cero o uno**, o bien los valores **booleanos verdadero o falso**.

!!! info "NOTA"
    Se les suele llamar interruptores porque cuando toman un valor están simulando un interruptor abierto/cerrado o encendido/apagado.

<figure>
  <img src="imagenes/01/EstructuraIterativa.png" width="300"/>
  <figcaption>Estructura Iterativa.</figcaption>
</figure>

##### Las estructuras while y until

Estas estructuras van a repetir el código que contienen mientras la expresión evaluada sea verdadera. Funcionamiento:

* Evalúa la condición, si es falsa, no realiza ninguna acción y continua con el siguiente código del programa.
* Si es verdadera entra en el bucle y ejecuta el código que contiene.
* Al finalizar la ejecución, al iterar, vuelve a evaluar la condición y vuelve a repetir la operación anterior.

!!! warning
    Al construir una estructura while es preciso asegurarse que en algún momento de su ejecución la condición dejará de cumplirse y se romperá el ciclo, si no, éste será infinito, a menos que el usuario o el sistema interrumpa su ejecución.

* `WHILE`
``` bash
while [ expresión ]
do
    código se repite MIENTRAS la expresión sea verdadera
done
```

* `UNTIL`
``` bash
until [ expresión ]
do
    código se repite HASTA que la expresión sea verdadera
done
```

!!! info
    La diferencia es que un `until` se ejecuta como mínimo una vez, ya que ejecuta el código y luego comprueba, mientras que el `while` es posible que nunca se ejecute, ya que es posible que la condición de entrada nunca se cumpla.

* Ejemplo:

``` bash
#! /bin/bash
read -p "Escribe un número: " num
i=1
while [ $i -le 10 ]
do
    let res=num*i
    echo "$i x $num = $res"
    let i=i+1
done
```
!!! info
    Este código imprime por pantalla la tabla de multiplicar del número que el usuario ha especificado. Las líneas contenidas entre `do` y `done` se ejecutarán mientras i sea menor o igual a diez. Al final de cada iteración el valor de i se incrementa en uno (es un contador) por lo que en diez iteraciones la condición dejará de cumplirse y el bucle se romperá.

##### La estructuras for

* Esta estructura permite repetir código por cada elemento de un conjunto determinado.
* No necesita condición de salida ya que al finalizar los elementos del conjunto acabará con su ejecución.
* la forma general es:

``` bash
for variable in conjunto
do
    estas líneas se repiten una vez por cada elemento del conjunto
    variable toma los valores del conjunto, uno en cada iteración
done
```
!!! example "Ejemplo:"

``` bash
#! /bin/bash
read -p “Escribe la dirección de una carpeta: “ car
for i in $(ls $car)
do
    if [ -f $i ]
    then
        echo “$i es un archivo de tipo regular”
    elif [ -d $i ]
    then
        echo “$i es un archivo de tipo directorio”
    else
        echo “$i es otro tipo de archivo o no existe”
    fi
done
```
!!! info "NOTA"
    Este ejemplo se van a mostrar los nombres de los ficheros que contiene un directorio y dirá si es un directorio o un fichero.

> Romper un bucle de forma deliberada

No sólo es posible terminar un bucle cuando se cumpla una condición o cuando se terminen los elementos de un conjunto, shell script proporciona dos formas de alterar el funcionamiento de la estructura en un bucle y romperla en función de las necesidades del programa:

1. `break` rompe el bucle que lo contiene y continúa la ejecución del script.
2. `continue` rompe la iteración que lo contiene, pero mantiene el bucle, que continuará con la siguiente iteración hasta que termine su ejecución.
3. `exit` detiene la ejecución del script. Este comando no es exclusivo de las estructuras iterativas, pero cobra especial sentido en este ámbito.

## Vectores y Funciones

### Vectores en shell script

* Un vector es una estructura de datos que permite almacenar una colección de elementos.
* Por el hecho de tratarse de una estructura de datos es posible realizar operaciones sobre él como buscar, eliminar y agregar elementos a su estructura.
* Los elementos se encuentran ordenados en función de como han sido introducidos en la estructura.
* Para acceder a cada elemento será necesario especificar la posición que ocupan dentro de ella, teniendo presente que la numeración de los vectores comienza desde cero, no desde uno.

!!! info
    Un buen ejemplo de uso sería, recoger el listado de archivos que hay en una carpeta.

<figure>
  <img src="imagenes/01/EsquemaVector.png" width="500"/>
  <figcaption>Esquema de un vector de doce elementos.</figcaption>
</figure>

Para definir un vector disponemos de dos formas:

1. **Implícita:** hace referencia a que el vector ha sido declarado y al mismo tiempo se han inicializado sus valores.
2. **Explícitamente:** cuando el vector no requiere que se inicialice mientras se declara, es decir, pueden ser inicializados con posterioridad.

Para declarar un vector hay que utilizar la siguiente estructura:

``` bash
declare -a meses=("enero" "febrero" "marzo")
```

También es posible utilizar alguna expresión para completar un vector, como con el operador rango ...

``` bash
declare -a letras=( {N..Z} {s..z} )
echo ${letras[*]}
```

!!! info
    * Esto creará un vector con el siguiente contenido y lo mostrará por pantalla así:
    * N O P Q R S T U V W X Y Z s t u v w x y z

* Para añadir un elemento a la estructura se debe indicar el índice o posición que ocupará el nuevo dato.
* Si el índice es mayor que la última posición de la estructura, se escribirá al final de la misma.
* Si se usa un índice que ya contiene un dato, éste será sobrescrito.

``` bash
meses[3]="abril"
```

* Para mostrar el contenido del vector:

``` bash
echo ${meses[*]}
```

!!! info
    Mostrará: 
    enero febrero marzo abril

* Es buena idea conocer el número de elementos que contiene un vector para poder introducir datos de forma correcta y no sobrescribir por accidente algún valor ya almacenado. Así es posible utilizar:

| Comando | Acción |  
|:-----:|------------------------------------------------|
| `${meses[*]}` | Muestra todos los valores del vector|
| `${!meses[*]}` | Muestra todos los índices del vector|
| `${#meses[*]}` | Devuelve el número de valores del vector|
| `${#meses[0]}` | Imprime la longitud del primer dato del vector|

* Para recorrer los valores que contiene esta estructura se puede utilizar un bucle **for**

``` bash
for item in ${meses[*]}
do
    echo $item
done
```
* También se puede utilizar sus índices para mostrar los datos contenidos.

``` bash
for index in ${!meses[*]}
do
    echo ${meses[$index]}
done
```

* Es una estructura muy útil en la que se puede guardar cualquier tipo de información, como por ejemplo los ficheros que contiene una carpeta:

``` bash
i=0;
for fichero in $(ls -a)
do
    ficheros[$i]=$fichero;
    let i=i+1;
done
```

### Funciones en shell script

* Una función es un conjunto de líneas de código que se distinguen a través de un identificador y que se ejecutan al invocar ese identificador.
* Se podría definir como un shell script dentro de un shell script.
* Sirve para organizarlo en unidades lógicas más pequeñas de manera que sea más fácil mantenerlo.
* Las funciones aceptan parámetros, de idéntica manera que los shell script, por lo que su uso también es muy intuitivo.
* La estructura de una función queda definida de la siguiente manera:

``` bash
function nombre_función(){
    código que se ejecutará al llamar a la función
}
```

* Ejemplo:

``` bash
##! /bin/bash
function imprimir_tabla(){
    echo “Tabla del número $1”
    for i in 1 2 3 4 5 6 7 8 9 10
    do
        let res=$1*i
    echo “$i x $1 = $res”
    done
}
read -p “Escribe un número: “ num
imprimir_tabla $num
imprimir_tabla 5
```

* En este ejemplo se ha construido una función para imprimir la tabla de multiplicar de un número pasado como parámetro.
* En la siguiente línea le pedimos al programa que imprima la tabla del número cinco.
* No se ha necesitado escribir el código que imprime la su tabla de multiplicar de nuevo, ya que con invocar el nombre de la función el programa ya sabe que código debe ejecutar.

!!! warning
    * Nótese que el valor de `$1` no se pasa como parámetro del shell script, si no como parámetro a la función imprimir_tabla tras haberlo preguntado al usuario.
    * Hay que tener en cuenta que las variables que se declaran dentro de una función existen únicamente dentro de ella. Si es preciso utilizar una variable fuera de una función se puede usar `return`, que devuelve un valor fuera de ella, o usar la palabra reservada `GLOBAL`
    * Es preferible utilizar el primer método para que devuelva un valor que será recogido en otra variable fuera de la función que lo originó.

!!! info
    * `source`
    * Para incluir el código de un fichero en otro tan sólo será necesario utilizar la palabra source seguida de la ruta de ese fichero. * 
    * También es posible usar el punto para poder cargarlo:
    * `source funciones.sh` o `./funciones.sh`

### Llamada a Scripts Externos como Funciones

* En ocasiones es útil **modularizar** un script principal dividiéndolo en varios archivos `.sh` que actúen como funciones especializadas.
* Esto permite **organizar mejor el código** y **reutilizar** scripts en diferentes proyectos.

#### Método 1: Usando `source` o `.`
* **`source`** ejecuta el script en el contexto actual del shell, permitiendo compartir variables.
* **`.`** es equivalente a `source` pero más corto.

``` bash
#!/bin/bash
# script_principal.sh

# Cargar funciones desde archivos externos
source funciones_servidor.sh
source monitoreo.sh
source backup.sh

# Ahora podemos usar las funciones definidas en esos archivos
menu_principal() {
    echo "=== MENÚ PRINCIPAL ==="
    echo "1) Gestión de servidores"
    echo "2) Monitoreo"
    echo "3) Backup"
    read -p "Selecciona opción: " opcion
    
    case $opcion in
        1) gestionar_servidores ;;
        2) monitorear_sistema ;;
        3) crear_backup ;;
    esac
}

# Ejecutar menú principal
menu_principal
```

#### Método 2: Ejecutando Scripts como Comandos
* Los scripts se ejecutan como **subprocesos independientes**.
* No comparten variables con el script principal.

``` bash
#!/bin/bash
# script_principal.sh

menu_principal() {
    echo "=== MENÚ PRINCIPAL ==="
    echo "1) Gestión de servidores"
    echo "2) Monitoreo"
    echo "3) Backup"
    read -p "Selecciona opción: " opcion
    
    case $opcion in
        1) ./funciones_servidor.sh ;;
        2) ./monitoreo.sh ;;
        3) ./backup.sh ;;
    esac
}

# Ejecutar menú principal
menu_principal
```

#### Ejemplo Práctico: Sistema Modular

**Estructura de archivos:**
```
sistema_gestion/
├── menu_principal.sh
├── funciones_servidor.sh
├── monitoreo.sh
├── backup.sh
└── configuracion.conf
```

**menu_principal.sh:**
``` bash
#!/bin/bash
# Cargar configuración
source ./configuracion.conf

# Cargar módulos
source ./funciones_servidor.sh
source ./monitoreo.sh
source ./backup.sh

# Función principal
main() {
    while true; do
        clear
        echo "=== SISTEMA DE GESTIÓN ==="
        echo "1) Gestión de servidores"
        echo "2) Monitoreo del sistema"
        echo "3) Copias de seguridad"
        echo "4) Salir"
        read -p "Selecciona opción: " opcion
        
        case $opcion in
            1) gestionar_servidores ;;
            2) monitorear_sistema ;;
            3) crear_backup ;;
            4) exit 0 ;;
            *) echo "Opción inválida" ;;
        esac
    done
}

# Ejecutar programa principal
main
```

**funciones_servidor.sh:**
``` bash
#!/bin/bash
# Módulo de gestión de servidores

gestionar_servidores() {
    echo "=== GESTIÓN DE SERVIDORES ==="
    echo "1) Listar servidores"
    echo "2) Añadir servidor"
    echo "3) Buscar servidor"
    read -p "Selecciona opción: " opcion
    
    case $opcion in
        1) listar_servidores ;;
        2) añadir_servidor ;;
        3) buscar_servidor ;;
    esac
}

listar_servidores() {
    echo "Listando servidores..."
    # Código para listar servidores
}

añadir_servidor() {
    echo "Añadiendo servidor..."
    # Código para añadir servidor
}

buscar_servidor() {
    echo "Buscando servidor..."
    # Código para buscar servidor
}
```

#### Ventajas de la Modularización

* **Organización:** Código más limpio y organizado
* **Reutilización:** Scripts pueden usarse en otros proyectos
* **Mantenimiento:** Fácil modificar módulos específicos
* **Colaboración:** Diferentes personas pueden trabajar en módulos diferentes
* **Debugging:** Más fácil localizar y corregir errores

#### Consideraciones Importantes

* **Permisos:** Asegurar que los scripts tengan permisos de ejecución (`chmod +x`)
* **Rutas:** Usar rutas relativas o absolutas correctas
* **Variables:** Con `source` se comparten variables, con ejecución directa no
* **Dependencias:** Verificar que todos los módulos necesarios estén disponibles

* Las funciones suelen declararse al inicio del documento y luego utilizadas a lo largo del programa.
* Uno de los objetivos es optimizar el código, mediante el "aprovechamiento" de código. Cuando un conjunto de líneas de código se repiten, es posible agruparlas bajo un nombre y utilizar ese nombre en lugar de repetir este código.

---

## Actividades

!!! tip "Formato de entrega"
    Escribe el código de los scripts en **ShellScript** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle


<!-- Para la entrega de las actividades, si no se pide una captura o un archivo concreto, se debe adjuntar un fichero de texto en formato Markdown con el enunciado y la solución justificada. El nombre del archivo debe contener el nombre de la actividad y el nombre del alumn@. Por ejemplo, para la actividad AC101, la alumna Laura entregará el archivo AC101Laura.md. Dentro del documento, se seguirá la siguiente estructura:
    ```markdown
    AC101Laura.md

    # AC101

    Laura García Sánchez

    ## Enunciado

    Aquí copio el enunciado de la actividad.

    ## Solución

    Aquí escribo la solución de la actividad. -->


<a name="AC101"></a>

* :simple-readdotcv: **AC101**. (RA.7 // CE7a, CE7b, CE7g y CE7i // 1-3p) Crea un shell script que muestre por pantalla el mensaje “**¡Hola Mundo!**”.

<a name="AC102"></a>

* :simple-readdotcv: **AC102**. (RA.7 // CE7a, CE7b, CE7g y CE7i // 1-3p) Realiza un script que guarde en un fichero el listado de archivos y directorios de la carpeta *etc*, a posteriori que imprima por pantalla dicho listado.

<a name="AC103"></a>

* :simple-readdotcv: **AC103**. (RA.7 // CE7a, CE7b, CE7g y CE7i // 1-3p) Modifica el script anterior para que además muestre por pantalla el número de líneas del archivo y el número de palabras.

<a name="AC104"></a>

* :simple-readdotcv: **AC104**. (RA.7 // CE7a, CE7b, CE7f y CE7i // 1-3p) Crea un shell script que muestre por pantalla el resultado de de las siguientes operaciones. Debes tener en cuenta que a, b y c son variables enteras que son preguntadas al usuario al iniciar el script.
    * a%b
    * a/c
    * 2 * b + 3 * (a-c)
    * a * (b/c)
    * (a*c)%b

<a name="AC105"></a>

* :simple-readdotcv: **AC105**. (RA.7 // CE7a, CE7b, CE7f y CE7i // 1-3p) Realiza un script que muestre por pantalla los parámetros introducidos separados por espacio, el número de parámetros que se han pasado, y  el nombre del script.

<a name="AC106"></a>

* :simple-readdotcv: **AC106**. (RA.7 // CE7a, CE7b, CE7f y CE7i // 1-3p) Diseña un script en Shell que pida al usuario dos números, los guarde en dos variables y los muestre por pantalla.

<a name="AC107"></a>

* :simple-readdotcv: **AC107**. (RA.7 // CE7a, CE7b, CE7e, CE7f y CE7i // 1-3p) Genera un script que muestre los usuarios conectados en el sistema operativo, comprobando que son usuarios dados de alta en el mismo.

<a name="AC108"></a>

* :simple-readdotcv: **AC108**. (RA.7 // CE7a, CE7f y CE7i // 1-3p) Crea un shell script que al ejecutarlo muestre por pantalla uno de estos mensajes **"Buenos días"**, **"Buenas tardes"** o **"Buenas noches"**, en función de la hora que sea en el sistema (de 8:00 de la mañana a 15:00 será mañana, de 15:00 a 20:00 será tarde y el resto será noche). Para obtener la hora del sistema utiliza el comando date.

<a name="AC109"></a>

* :simple-readdotcv: **AC109**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7f y CE7i // 1-3p) Construye un programa denominado AGENDA que permita mediante un menú, el mantenimiento de un pequeño archivo lista.txt con el nombre, dirección y teléfono de varias personas. Debes incluir estas opciones al programa:
    * **Añadir** (añadir un registro)
    * **Buscar** (buscar entradas por nombre, dirección o teléfono)
    * **Listar** (visualizar todo el archivo).
    * **Ordenar** (ordenar los registros alfabéticamente).
    * **Borrar** (borrar el archivo).

<a name="AC110"></a>

* :simple-readdotcv: **AC110**. (RA.7 // CE7a, CE7f y CE7i // 1-3p) Crea un shell script que sume los números del 1 al 1000 mediante una estructura `for`, `while` y `until`.

!!! note
    Escribe el código de los scripts en **ShellScript** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.

<a name="AC111"></a>

* :simple-readdotcv: **AC111**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i // 1-3p) Realiza un script utilizando funciones que permita crear un informe de las **IP libres** en la red en la que se encuentra el equipo. Debe contener las siguientes opciones:
    1. El informe contendrá un **listado de todas las IP de la red** a la que pertenece el equipo indicando si está libre o no (usa el comando ping).
    2. En el informe debe aparecer el **tipo de red** (rango CIDR) en el que está inmerso el ordenador con el **nombre de la red**, su **broadcast** y su **máscara de subred**. Esta información la podéis obtener desde el comando ifconfig.

!!! note
    Para facilitar los cálculos asumimos que el equipo donde se ejecuta el script se encuentra en una única red, es decir, solo posee una tarjeta de red.

<a name="AC112"></a>

* :simple-readdotcv: **AC112**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7f, CE7h y CE7i // 1-3p) Crea un script que rellene un **vector** con cien valores aleatorios y muestre en pantalla en una sola línea los valores generados.

<a name="AC113"></a>

* :simple-readdotcv: **AC113**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7f, CE7h y CE7i // 1-3p) Genera un script que rellene un **vector** con diez números pedidos al usuario y que los muestre por pantalla de la siguiente forma:
    1. en orden inverso a como han sido introducidos los valores
    2. los valores ordenados de menor a mayor en una sola línea
    3. los valores ordenados de mayor a menor en una sola línea
    4. la suma total de sus valores
    5. cantidad de valores pares que contiene el vector
    6. la suma total de números impares
    7. la media aritmética de los valores que contiene el vector

<a name="AC114"></a>

* :simple-readdotcv: **AC114**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7f, CE7h y CE7i // 1-3p) Crea un script que muestre las opciones del ejercicio anterior con select. El usuario introducirá los valores del **vector** al iniciar el script. Cuando termine aparecerá el menú de selección (deberás añadir la opción para salir del script). Además deberás crear una **función** para cada opción del menú y llamarla en cada una de las opciones del select.

<a name="RETO_GRUPAL"></a>

* :material-trophy: **RG115**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i // 30p). Trabajo en grupos de 2 personas para crear un sistema completo de gestión de servidores que integre todos los conceptos aprendidos durante la unidad.
    * **[RETO GRUPAL: Sistema de Gestión de Servidores](RetoGrupalShellScript.md)**.  
    * [Consulta aquí la solución detallada del reto grupal](SolucionRetoGrupalShellScript.md)
* :clipboard: **Rúbrica de Evaluación:** Consulta los criterios de evaluación detallados en la [Rúbrica de Evaluación del Reto ShellScript](Rubrica_Evaluacion_RetoShell.md).


<a name="EXAMEN"></a>

* :material-school: **[EXAMEN: ShellScript (60 puntos)](ExamenShellScript.md)**. Examen de evaluación completa que cubre todos los contenidos del tema de ShellScript.


---

<!-- <a name="AC104"></a>

* :simple-readdotcv: **AC104**. (RA.7 // CE7b // 1-3p) Depura los ejercicios anteriores utilizando los argumentos `-x` y `-v`. -->

