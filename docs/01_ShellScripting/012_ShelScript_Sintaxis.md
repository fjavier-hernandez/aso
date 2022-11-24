# Sintaxis
## Argumentos o Parámetros

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

## Variables

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

## Entrada y salida del Shell Script

* Para poder interactuar con un programa de terminal es necesario disponer de un mecanismo de entrada de datos.
* Para dinamizar el resultado de los shell scripts y un dispositivo de salida que mantenga informado al usuario en todo momento de los que está ocurriendo.
* Para la entrada de datos se utiliza el comando **read** y para la salida el comando **echo**.

### echo
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

### read
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

## Operadores en shell script

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

### Aritméticos

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

### Relacionales

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

### Lógicos

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

### expr

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

### let

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

### expansores

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

## Redirecciones

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


## Tuberías

* Forma práctica de **redireccionar la salida estándar de un programa** hacia la entrada estándar de otro.
* Esto se logra usando el símbolo `|` (pipeline). Ejemplo:

``` bash
$ cat archivo.txt | wc
```

!!! info
    El comando anterior utiliza tuberías para redireccionar la salida estándar del comando cat y pasarla como entrada estándar del comando wc para contar las líneas y palabras de un archivo.

## alias

* Alias es un comando que se ejecuta desde un terminal que permite configurar vínculos entre varios comandos.
* Cada usuario puede asignar una palabra fácil de recordar a uno o más comandos que, por lo general, pueden ser más complicados de recordar.
* Ejemplo:

``` bash
alias listado=’ls -lia>’
```
## Actividades

!!! note
    Escribe el código de los scripts en **ShellScript** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.

105. Crea un shell script que muestre por pantalla el resultado de de las siguientes operaciones. Debes tener en cuenta que a, b y c son variables enteras que son preguntadas al usuario al iniciar el script.
    * a%b
    * a/c
    * 2 * b + 3 * (a-c)
    * a * (b/c)
    * (a*c)%b

106. Realiza un script que muestre por pantalla los parámetros introducidos separados por espacio, el número de parámetros que se han pasado, y  el nombre del script.

107. Diseña un script en Shell que pida al usuario dos números, los guarde en dos variables y los muestre por pantalla.

108. Genera un script que muestre los usuarios conectados en el sistema operativo, comprobando que son usuarios dados de alta en el mismo.

