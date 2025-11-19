---
title: PowerShell - Scripts en Sistemas Propietarios
description: Realización de scripts mediante PowerShell en Windows.
subtitle: Introducción PowerShell
# tags:
#     - Introducción PowerShell
#     - RA7
---

# PowerShell

PowerShell es una interfaz de línea de comandos (CLI) y lenguaje de scripting desarrollado por Microsoft para automatizar tareas y administrar sistemas operativos Windows. Surgió ante las carencias que presenta el antiguo terminal basado en MS-DOS, ofreciendo una sintaxis moderna, orientada a objetos y potente para administradores de sistemas.

Estos scripts se ejecutan mediante el intérprete de PowerShell, permitiendo realizar desde la manipulación de archivos hasta la ejecución automática de programas complejos y administración de servicios del sistema operativo.

## Propuesta didáctica

En esta unidad vamos a continuar trabajando el **RA7 de ASO**:

> **RA7.** *Utiliza lenguajes de guiones en sistemas operativos, describiendo su aplicación y administrando servicios del sistema operativo.*

### Criterios de evaluación (RA7)

A lo largo de la unidad se trabajarán y evidenciarán los siguientes criterios:

- **CE7a**: Se han utilizado y combinado las estructuras del lenguaje para crear guiones.  
- **CE7b**: Se han utilizado herramientas para depurar errores sintácticos y de ejecución.  
- **CE7c**: Se han interpretado guiones de configuración del sistema operativo.  
- **CE7d**: Se han realizado cambios y adaptaciones de guiones del sistema.  
- **CE7e**: Se han creado y probado guiones de administración de servicios.  
- **CE7f**: Se han creado y probado guiones de automatización de tareas.  
- **CE7g**: Se han implantado guiones en **sistemas propietarios**.  
- **CE7h**: Se han consultado y utilizado librerías de funciones.  
- **CE7i**: Se han documentado los guiones creados.

## Contenidos

**Bloque 1 — Fundamentos de PowerShell (Sesión 1–2)**
- ¿Qué es PowerShell? Historia y características.  
- PowerShell ISE (Integrated Scripting Environment).  
- Creación y ejecución de scripts: extensión `.ps1`.  
- Comentarios y depuración de scripts.

**Bloque 2 — Elementos del lenguaje (Sesión 2–3)**
- Parámetros y argumentos (array `$args[]`).  
- Variables: tipado implícito y explícito.  
- Entrada/salida con `Write-Host` y `Read-Host`.  
- Operadores: aritméticos, lógicos, de comparación y tipo.

**Bloque 3 — Control de flujo (Sesión 3–4)**
- Estructuras condicionales: `if`, `elseif`, `else`, `switch`.  
- Bucles: `while`, `do-while`, `for`, `foreach`.  
- Opciones avanzadas de `switch`: `-wildcard`, `-regex`, `-casesensitive`.

**Bloque 4 — Estructuras y modularización (Sesión 4–5)**
- Vectores (arrays) y operaciones con ellos.  
- Funciones, parámetros tipados y retorno.  
- Organización del código y módulos.

!!! question "Actividades iniciales"
    1. Genera un Script que muestre los **procesos del sistema** ordenados por el **id**.
    2. Muestra los servicios cuyo nombre empiece por la letra `n`, utilizando la creación de un script.
    3. Crea un script que si no se le pasa ningún argumento nos lo diga.

### Programación de Aula (8h)

Esta unidad se imparte en la primera evaluación, con una duración estimada de 6 sesiones lectivas:

#### Sesiones 1-3: Contenidos Fundamentales

| Sesión | Contenidos | Actividades | Criterios trabajados |
| --- | --- | --- | --- |
| 1  | Introducción PowerShell, Creación Primer Script, Comentarios y depuración | AC201-AC202 | CE7a, CE7b, CE7g y CE7i |
| 2  | Sintaxis, Argumentos, variables, interacción con usuario y operadores | AC203-AC205 | CE7a, CE7b, CE7f y CE7i |
| 3      | Control de flujo: condicionales y bucles   | AC206, AC207, AC208          | CE7a, CE7f, CE7i               |

#### Sesiones 4-5: Contenidos Avanzados

| Sesión | Contenidos | Actividades | Criterios trabajados |
| --- | --- | --- | --- |
| 4      | Vectores y funciones   | AC209-AC210          | CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h, CE7i               |
| 5      | Actividades de ampliación   | AC211-AC212          | CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h, CE7i               |

#### Sesiones 6: Evaluación y Cierre

| Sesión | Contenidos | Actividades | Criterios trabajados |
| --- | --- | --- | --- |
| 6      | Evaluación y actividades de ampliación   | AC212-AC213          | CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h, CE7i               |

---

## Introducción

Los sistemas operativos basados en Microsoft Windows cuentan con la herramienta **PowerShell**, que surgió ante las carencias que presenta el viejo terminal basado en **MS-DOS**.

**PowerShell** es una interfaz de consola (CLI) con posibilidad de escritura y unión de comandos por medio de instrucciones (scripts). Esta interfaz de consola está diseñada para su uso por parte de **administradores de sistemas**, con el propósito de automatizar tareas o realizarlas de forma más controlada.

En abril de 2006 Microsoft lanzó una nueva interfaz CLI, con una sintaxis moderna que comparte similitudes con el lenguaje Perl.
- **Perl** es un lenguaje de programación diseñado por Larry Wall en 1987. Perl toma características del lenguaje C, del lenguaje interpretado bourne shell, AWK, sed, Lisp y, en un grado inferior, de muchos otros lenguajes de programación.

Se trata de una interfaz gratuita, y que antes de Microsoft **Windows 7** no se incluía con el sistema operativo. En la actualidad, está incluida en todos los sistemas operativos de Microsoft, aunque requiere la presencia de `.NET` framework del que hereda sus características orientadas a objetos.

En agosto de 2016, Microsoft publicó su código en GitHub para que pueda portarse a otros sistemas como GNU/Linux y MAC OSX.

Los comandos incluidos en PowerShell reciben el nombre de **cmdlets (command-let)** y posee conjuntos específicos para trabajar con *Active Directory, Exchange*, entre otros roles de servidor.

!!! info
    **cmdlets** Existen cientos de cmdlets en la *versión 5.1* de PowerShell. Es posible consultar la ayuda de cada uno de ellos en la página oficial de Microsoft.

Otra ventaja de PowerShell es que se dispone de la mayoría de comandos que del CLI tradicional de Microsoft. De ese modo, es posible ejecutar el comando `dir` en lugar del `Get-ChildItem`, cmdlet que realiza la misma tarea. En realidad lo que está usando es un alias del segundo para lanzar el primero.

Dispone de autocompletado de comandos y parámetros que facilitará las tareas de creación de scripts. Basta con comenzar a escribir un cmdlet y pulsar la tecla Tab. 

Si utilizamos **PowerShell ISE** al escribir aparecerá una ventana con todos los cmdlets que coincidan con el texto escrito, incluso puede aparecer un recuadro con ayuda sobre su sintaxis. Para aceptar la sugerencia se pulsa la tecla Intro.

!!! note
    Los nombres de todos los cmdlets están formados por un verbo, un guión y un nombre en singular. Habitualmente, se escribe con mayúsculas la primera letra de cada palabra, pero no se trata más que de una norma de estilo, porque **PowerShell no distingue entre mayúsculas y minúsculas.**

## Primer Script

Al igual que ocurre en GNU/Linux un script de PowerShell no es más que un archivo de texto plano que contiene una secuencia de comando y de **cmdlets** para realizar una tarea. La diferencia con ellos es que aquí será necesario dotarlos de una extensión; `ps1`.

!!! example
    ``` pwsh
    Write-Host "Hola!. Esto es mi primer script en PowerShell"
    Write-Host "Y esto es una segunda línea"
    ```

A continuación, se guarda el script desde el menú `Acción → Guardar Como…` asignándole un nombre.

Para ejecutarlo tan sólo es necesario escribir su nombre en el terminal de PowerShell anteponiendo un punto y una barra.

!!! example
    ``` pwsh
    ./Script.ps1
    ```

Aunque también es posible ejecutar el script desde la **herramienta gráfica** pulsando la tecla `F5`, ejecutar una parte de él con `F8` o detener la ejecución con `Ctrl+Intro`.

## PowerShell ISE

PowerShell viene acompañado de una **herramienta gráfica** que facilita la administración de todos los scripts. Se denomina Microsoft **PowerShell ISE (Integrated Scripting Environment)**, y se accede a través de: `Administrador del servidor → Herramientas → Windows PowerShell ISE`.

El uso de esta herramienta gráfica va a facilitar la creación de los scripts de forma significativa. Es práctico comenzar con esta ayuda ya que la sintaxis de los cmdlets, aunque sea lógica y sencilla, también lo es amplia y desconocida.

<figure>
  <img src="imagenes/02/InterfazPowerShell.png" width="800"/>
  <figcaption>Interfaz de la herramienta Windows PowerShell ISE</figcaption>
</figure>

!!! info
    - Uno de los aspectos más interesantes que posee esta aplicación es la barra de información que muestra un listado de todos los **cmdlets** de esta herramienta. Permite filtrarlos por función y consultar la ayuda de cada uno de ellos.
    - También posee un formulario destinado a generar el código de un **cmdlet** de forma automática.

!!! example
    * Creación de un comando que realice una copia de seguridad de los scripts de trabajo en una memoria externa. Es necesario el uso de Copy-Item para ello, pero no se conoce su sintaxis.
    * Si escribimos este **cmdlet** en el recuadro `Nombre` y se pulsa sobre `Mostrar Ayuda`, aparecerá un formulario con sus opciones. Tras completar las necesarias y pulsando el botón `Insertar` situado en la parte inferior, el código completo será escrito la parte destinada al terminal.

<figure>
  <img src="imagenes/02/PS_ISE_EJEM.png" width="800"/>
  <figcaption>Creación automática de scripts en Windows PowerShell ISE.</figcaption>
</figure>

## Comentarios

!!! note
    Los comentarios en **PowerShell** se realizan precediendo a la línea con el carácter `#` si se trata de una sola línea y `<#` y `#>` si es multilínea.

## Depuración

La depuración es el proceso de examinar un script mientras se ejecuta para identificar y corregir errores en las instrucciones del script. El depurador de PowerShell puede ayudarle a examinar e identificar errores e ineficiencias en los scripts, funciones, comandos, configuraciones o expresiones de PowerShell Desired State Configuration (DSC).

El depurador de PowerShell incluye el siguiente conjunto de cmdlets:

- **Set-PSBreakpoint**: establece puntos de interrupción en líneas, variables y comandos.
- **Get-PSBreakpoint**: obtiene puntos de interrupción en la sesión actual.
- **Disable-PSBreakpoint**: desactiva los puntos de interrupción en la sesión actual.
- **Enable-PSBreakpoint**: vuelve a habilitar los puntos de interrupción en la sesión actual.
- **Remove-PSBreakpoint**: elimina puntos de interrupción de la sesión actual.
- **Get-PSCallStack**: muestra la pila de llamadas actual.

---

## Sintaxis

### Parámetros en PowerShell

A diferencia de GNU/Linux, los parámetros que reciba el script en PowerShell se reciben en el array **args**. Cada posición del array `args[]` guarda los parámetros introducidos al script en el orden indicado. Por lo tanto para acceder a los parámetros introducidos se debe acceder al valor de la posición que se desee.

!!! example
    ``` pwsh
    [string]$param1= $args[0]
    Write-Host "Hola!. Esto es mi primer script en PowerShell"
    Write-Host "Y esto es una segunda línea"
    Write-Host "El primer parámetro introducido es $param1"
    ```

!!! note
    * El script anterior esperará un parámetro de tipo `string` que será contenido en la variable $param1.
    * En la cuarta línea mostrará el contenido de la variable por pantalla.

Para poder ejecutar este script, será necesario acompañarlo de un parámetro del siguiente modo.

``` pwsh
./Script.ps1 "Fº Javier Hernández Illán"
```

Para entender por completo el ejemplo anterior, será necesario ver como PowerShell maneja las **variables**.

### Variables

Para definir una variable en PowerShell sólo tenemos que nombrarla utilizando para ello cualquier combinación de caracteres, ya sean números, letras o símbolos. Es posible utilizar espacios en el nombre, aunque en este caso el nombre debe ir rodeado por símbolos de llaves **{}**.

Al contrario que ocurre en shellscript, PowerShell es **fuertemente tipado**, lo que significa que las variables no son tratadas como cadenas de texto, sino que hay que especificar el tipo de dato que se guardará en ella.

Para definir variables es posible utilizar el método **explícito** (además con **New-Variable** y sus opciones), pero también se puede utilizar el método **implícito** anteponiendo el símbolo **$** delante del nombre.

!!! info
    **Get-Variable** En cualquier momento puedes obtener una lista completa de las variables que se hayan definido hasta ese momento. Para lograrlo, basta con utilizar Get-Variable.

### Tipado Implícito

| Tipo      | Descripción                             | 
| ------------- | ------------------------------- |
|`[string]` |Cadena de caracteres Unicode|
|`[char]` |Un sólo carácter Unicode de 16 bits|
|`[byte]`| Un sólo carácter Unicode de 8 bits|
|`[int]` |Entero con signo de 32 bits|
|`[float]`| Número con coma flotante de 32 bits|
|`[double]`| Número con coma flotante de 64 bits|
|`[datetime]`| Fecha y Hora|
|`[bool]`| Valor lógico booleano|

!!! example 
    ``` pwsh
    $numero = 9.99
    $Final_2021 = 30
    ${Mi variable} = "Contiene espacios en el nombre"
    ```

En la forma implícita el shell establece el tipo de dato de la variable en función del dato que se le asigne en su creación. En el ejemplo anterior `$numero` es de forma automática de tipo `[double]`, ya que al crearla se ha inicializado con un número con decimales. Por contra la variable `$Final_2021` es de tipo `[int]` ya que se ha guardado un número entero en ella.

!!! info
    * **GetType** Para poder obtener el tipo de dato  de una variable hay que usar el método `GetType().Name` sobre cualquier variable:
    * `Write-Host $numero.GetType().Name`

!!! tip
    - Una variable cuya definición de tipo se ha realizado de forma implícita, podrá cambiar el tipo de dato almacenado durante la ejecución del programa sin experimentar ningún tipo de error. 
    - Esta práctica aunque cómoda **no es muy recomendable**.

### Tipado Explícito

Es buena idea tomar el control del tipado de las variables y asignarlo en función de las necesidades del programa. De esta forma se ahorrarán futuras conversiones de datos y posibles pérdidas de información. Para ello se usa la forma explícita de crear variables y junto con su creación se define el tipo de dato que va a contener.

!!! example
    ``` pwsh
    [float] $numero = 9.99
    [int] $Final_2021 = 30
    [string] ${Mi variable} = "Contiene espacios en el nombre"
    ```

Al contrario que en el caso anterior, cuando el dato asignado no coincida con el tipo esperado, pueden ocurrir dos cosas:

1. Se modifiquen las características del dato para amoldarse al tipo de variable, lo que puede traducirse en la pérdida de datos y un mal funcionamiento del script,
2. Se produzca un error si esa conversión no es posible y se detenga el script.

## Interacción con el usuario

PowerShell posee dos cmdlets para realizar estas tareas:

1. El primero de ellos es **Write-Host** y tiene un comportamiento similar al **echo** en GNU/Linux.
2. El segundo comando para interactuar con el usuario es **Read-Host** el cual permite imprimir un mensaje por el terminal y recoger aquello que el usuario ha escrito. Funciona de forma muy parecida al comando **read** en el terminal de GNU/Linux.

``` pwsh
[string] $marine = Read-Host "¿Cuál es el nombre del marine de Doom?"
Write-Host "No se sabe, pero lo has intentado con $marine"
```

!!! note
    Este script detendrá su ejecución en la línea donde aparece **Read-Host**, esperará a que el usuario conteste a la pregunta y seguirá con la ejecución, del mismo modo que ocurre con shellscript.

## Operadores

### Aritméticos

Las operaciones aritméticas en PowerShell son más intuitivas que en shellscript. Son las mismas que en el caso anterior: `+`, `-`, `*` , `/` y `%`. Su uso es más sencillo puesto que es el propio terminal en que realiza los cálculos aritméticos y no a través de un comando.

```pwsh
[int] $a=10
[float] $b=20
[int] $res=$a+$b
Write-Host $res
Write-Host $a+$b
Write-Host "$a x $b = " ($a*$b)
```

También se dispone de expansores de terminal como en GNU/Linux.

!!! note
    Nótese que en la última línea aparece directamente el producto **$a*$b** ya que al rodear la operación con paréntesis, se convierte en un expansor, realiza la operación en su interior y envía el resultado fuera.

Existen variantes que simplifican el uso de algunos operadores.

| Operador      | Uso                             | Equivalencia |
| ------------- | ------------------------------- | ------------ |
| `+=`  | $contador += 5 | $contador = $contador+5 |
| `-=`  | $contador -= 5 | $contador = $contador-5 |
| `*=`  | $contador *= 5 | $contador = $contador*5 |
| `/=`  | $contador /= 5 | $contador = $contador/5 |

Además de estos operadores existen dos específicos para el incremento (`++`) y decremento (`--`) de una unidad, ideal para el uso de variables como contadores.

### Lógicos

| Operador      | Descripción                             | 
| ------------- | ------------------------------- |
|`-and` |Devuelve verdadero si las dos expresiones son verdaderas.|
|`-or`| Devuelve verdadero si una de las dos expresiones o las dos son verdaderas.|
|`-xor`| Devuelve verdadero si tan sólo una de las expresiones es verdadera.|
|`-not o !`| Devuelve verdadero cuando la expresión da el valor falso.|

!!! example
    ```pwsh
    Write-Host ((6 -ge 4) -and (7 -le 7))
    Write-Host ((10 -gt 1) -or (2 -lt 2))
    Write-Host ((1 -gt 0) -xor (4 -le 1))
    Write-Host ( -not (12 -lt 10))
    Write-Host (!(12 -lt 10))
    ```

!!! note
    En el ejemplo anterior si se ejecuta el script en un terminal PowerShell, todos los resultados serán verdaderos.

Como en todos los lenguajes de programación fuertemente tipados, existen operadores lógicos para comprobar el tipo de dato de una variable, que resultan muy útiles para la interacción con los usuarios.

| Operador      | Acción                             | Ejemplo |
| ------------- | ------------------------------- | ------------ |
|`-is` |Devuelve verdadero si es del tipo indicado.| `"Javi" -is [string]` es verdadero|
|`-isnot` |Devuelve falso si es del tipo indicado. |`"Javi" -isnot [string]` es falso|
|`-as `|Convierte tipos de datos compatibles.|`$valor = 19.90`; `Write-Host ($valor -as [int])`|

### Comparación

Los operadores de comparación devuelven tan sólo un valor booleano que puede tener dos valores; **verdadero o falso**.

| Operador      | Acción                             | Ejemplo |
| ------------- | ------------------------------- | ------------ |
| `-eq` | Comprueba si son iguales. | `5 -eq 3` es falso |
|`-ieq` | Iguales. En cadenas no es casesensitive. |`"Javi" -ieq "javi"` es verdadero|
|`-ceq` |Iguales. En cadenas es casesensitive.| `"Javi" -ceq "javi"` es falso |
|`-ne` | Verifica si son diferentes.| `5 -ne 3` es verdadero |
|`-lt` | Coteja si la izquierda es menor que derecha.  | `5 -lt 3` es falso |
|`-le` | Constata si la izquierda es menor o igual que derecha.  | `5 -le 3` es falso |
| `-gt` | Examina si la izquierda en mayor que la derecha. | `5 -gt 3` es verdadero |
| `-ge` | Revisa si la izquierda en mayor o igual que la derecha.  | `5 -ge 3` es verdadero |

**PowerShell** añade operadores de comparación que aportan un nivel de complejidad mayor.

| Operador      | Acción                             | Ejemplo |
| ------------- | ------------------------------- | ------------ |
|`-like` | Evalúa un patrón "es como". | `"Perro" -like "Pe*"` es verdadero |
| `-notlike` | Evalúa un patrón "no es como". | `"Perro" -notlike "Pe*"` es falso |
|`-contains`| Contiene un valor. |`1,2,3 -contains 2` es verdadero|
|`-notcontains`| No contiene un valor. |`1,2,3 -notcontains 2`es falso|

---

## Control del flujo en PowerShell

En esta parte se indicará tan sólo la sintaxis de las estructuras alternativas e iterativas, ya que los conceptos teóricos ya se han abordado en el apartado de Shellscript.

### Estructuras alternativas

#### Alternativa Simple

``` pwsh
    if ( condición ){
        ejecutar este código si la condición es verdadera
    }
```

#### Alternativa doble

``` pwsh
    if ( condición ) {
        ejecutar este código si la condición es verdadera
    } else {
        ejecutar este código si la condición es falsa
    }
```

#### Alternativa múltiple

``` pwsh
    if ( condición1 ) {
        ejecutar este código si la condición1 es verdadera
    } elseif ( condición2 ) {
        ejecutar este código si la condición2 es verdadera
    } else {
        ejecutar este código si todas las condiciones son falsas
    }
```

### El equivalente a case en GNU/Linux

``` pwsh
    switch ($valor){
        opción1 { código a ejecutar si opción1 coincide con $valor }
        opción2 { código a ejecutar si opción2 coincide con $valor }
        opciónN { código a ejecutar si opciónN coincide con $valor }
        default { código a ejecutar si ninguna de las opciones coincide }
    }
```

!!! example
    ``` pwsh
        $saludo = Read-Host "Escribe un saludo"
        switch ($saludo){
            "Buenos días" { Write-Host "Saludaste en Castellano" }
            "Bon dia" { Write-Host "Saludaste en Catalán" }
            "Bo dias" { Write-Host "Saludaste en Gallego" }
            "Egun on" { Write-Host "Saludaste en Euskera" }
            "Good morning" { Write-Host "Saludaste en Inglés" }
            "Bonjour" { Write-Host "Saludaste en Francés" }
            "Buon Giorno" { Write-Host "Saludaste en Italiano" }
            "Bom día" { Write-Host "Saludaste en Portugués" }
            "Guten Tag" { Write-Host "Saludaste en Alemán" }
            {$_ -is [string]} { Write-Host "La variable que has pasado es una cadena" }
            default { "Eso no parece un saludo" }
        }
    ```

!!! note
    * Existe la posibilidad de colocar operadores lógicos como opciones de un `switch`, si estos operadores lógicos devuelven un valor verdadero, se ejecutará esa parte del código, si se evalúa a falso, no realizará esa parte del código. 
    * El carácter $_ hace referencia a la variable $saludo, de ese modo es posible realizar operaciones lógicas con el valor pasado.

Además de todo esto, `switch` posee una serie de opciones que no están presentes en GNU/Linux, aunque es posible realizarlas de otra manera.

| Operador      | Descripción                             | 
| ------------- | ------------------------------- |
|`-wildcard` | Sólo aplicable a `[string]`. Indica si cumple un patrón determinado.|
|`-exact` | Sólo aplicable a `[string]`. Debe coincidir exactamente con alguno de los patrones.|
|`-casesensitive`| Sólo aplicable a `[string]`. Debe coincidir en mayúsculas y minúsculas.|
|`-file` | La entrada es un archivo. Se evaluará cada línea del archivo.|
|`-regex` |Sólo aplicable a `[string]`. Permite usar expresiones regulares en la comparación.|

!!! example
    `-regex`
    ``` pwsh
    $target = 'https://bing.com'
    switch -Regex ($target){
        '^ftp\://.*$' { "$_ is an ftp address"; Break }
        '^\w+@\w+\.com|edu|org$' { "$_ is an email address"; Break }
        '^(http[s]?)\://.*$' { "$_ is a web address that uses $($matches[1])"; Break }
    }
    ```

!!! example
    `-wildcard`
    ``` pwsh
    switch -wildcard ( Read-Host "Escribe un número de teléfono" ){
        "8*" { Write-Host "Es un teléfono fijo: $_"; break }
        "9*" { Write-Host "Es un teléfono fijo: $_"; break }
        "6*" { Write-Host "Es un teléfono móvil: $_"; break }
        default { "$_ no parece un teléfono" }
    }
    ```

* El comando break que aparece al final de cada opción indica que si encuentra una coincidencia no siga buscando más y rompa el switch, ahorrándose así el resto de comprobaciones.

### Estructuras iterativas

#### while

A diferencia de lo que ocurría en GNU/Linux, en PowerShell existen diferencias entre las estructuras **while, do while** y **do until**. En este caso, la única de las tres que evaluará la condición al inicio del bloque de código será la primera. El resto comprueba la condición al final del bloque ejecutando como mínimo una vez el código que contiene.

``` pwsh
while ( condición ){
    bloque de código a ejecutar mientras condición sea verdadera
}
```

``` pwsh
do {
    bloque de código a ejecutar mientras condición sea verdadera
} while ( condición )
```

Existe una variante de esta estructura que se crea sustituyendo el **while por un until**. Esto cambia el sentido de la condición y es este caso el bloque se repite hasta que la condición se cumpla. Esta estructura no es muy utilizada, pero siempre es bueno contar con herramientas extra.

#### for

También la estructura `for` es sensiblemente diferente que en shellscript. Esta estructura en PowerShell tiene más que ver con los lenguajes de programación y se utiliza cuando el programador sabe el número de iteraciones que hay que realizar para solucionar un problema.

``` pwsh
for ( inicialización; condición; incremento ){
    bloque de código a ejecutar mientras condición sea verdadera
}
```

Por ejemplo, la creación de la tabla de multiplicar de un número especificado por el usuario. Para resolver este problema sí se conoce el número de iteraciones necesarias, concretamente diez.

!!! example
    ``` pwsh
    $numero = Read-Host "Dame un número"
    Write-Host "Esta es la tabla del $numero"
    for ( $i=0; $i -lt 11; $i++){
        Write-Host " $i x $numero = "($i*$numero)
    }
    ```

#### foreach

La estructura `foreach` en PowerShell es el equivalente a for en shellscript. Está pensada para recorrer un conjunto de valores y ejecutar el bloque de código una vez por cada elemento del conjunto.

``` pwsh
foreach ( elemento in conjunto ){
    bloque de código a ejecutar por cada elemento del conjunto
}
```

Al igual que ocurre en GNU/Linux, el conjunto puede serlo de cualquier tipo de objetos, incluso los ficheros de una carpeta. En el siguiente ejemplo se buscan los ficheros que en su nombre contengan la cadena de texto que el usuario ha especificado:

!!! example
    ``` pwsh
    $ruta = "C:\Users\Administrador\Desktop"
    $busca = Read-Host "Escribe el texto a buscar"
    foreach ($archivo in Get-ChildItem $ruta){
        if ($archivo.Name.IndexOf($busca) -ge 0){
        Write-Host $archivo.Name
        }
    }
    ```

!!! note
    Las opciones que ofrece PowerShell en cuanto a estructuras de control parece una oferta más completa que la de shellscript, aunque para las tareas que se van a realizar en este módulo, ambos sistemas poseen herramientas suficientes.

---

## Vectores y Funciones

### Vectores

PowerShell considera como un vector a toda colección de objetos, sea cual sea su tipo. Los elementos que lo conforman pueden estar separados por comas, estar expresados por el operador de rango `..` o ser el resultado de alguna expresión que devuelva una colección, como así lo hacen muchos cmdlets.

!!! example
    ``` pwsh
    $Vacia = @()
    $Enteros = 1,2,3,4,5
    $Texto = "Lunes","Martes","Miércoles", "Jueves","Viernes"
    $EnterosRango = 1..10
    ```

De esta forma se han definido cuatro vectores; el segundo contendrá enteros y el tercero cadenas de caracteres. La última línea asigna los valores desde el 1 al 10 utilizando el operador rango `..` .

!!! note
    El operador de **rango** representa una secuencia de enteros, con los límites superior e inferior separados por dos puntos decimales. Permite expresar el rango en orden ascendente o descendente, así como también que los límites inferior o superior sean establecidos por medio de variables que contengan enteros.

Un vector también puede definirse como el resultado de una expresión.

!!! example
    ``` pwsh
    $EnterosFor = @(For($i=1;$i -lt 5;$i++){$i})
    $Comando = Get-Process | Sort-Object ProcessName
    ```

En la primera línea ``$EnterosFor`` será completado a través del resultado de una estructura iterativa, mientras que la segunda contendrá el resultado del cmdlet indicado. Además de todas estas formas de declaración, también se puede realizar a través del cmdlet ``New-Variable``

!!! example
    ``` pwsh
    New-Variable -Name Enteros -Value 1,2,3,4,5 -Force
    New-Variable -Name Texto -Value "Lunes","Martes","Miércoles","Jueves","Viernes" –Force
    New-Variable -Name EnterosRango -Value (1..5) -Force
    New-Variable -Name EnterosFor -value (. {For($i=1;$i -lt 5;$i++){$i}}) -Force
    ```

!!! note
    El atributo `-Force` sobrescribe la variable si esta ya existe, de ese modo no saltará ningún error a la hora de definir estas variables.

Para obtener el número de elementos de un vector se utiliza el método Length, si se aplica a un elemento del vector, devolverá el tamaño de este elemento, no del vector completo.

!!! example
    ``` pwsh
    $Texto.Length # mostrará 5 por pantalla
    $Texto[2].Length # mostrará 9, las letras de "Miércoles"
    ```

Para añadir elementos al final de un vector se utiliza el operador `+=`.

!!! example
    ``` pwsh
    $Enteros += 6
    $Texto += "Sábado", "Domingo"
    ```

!!! note
    La primera línea añade el entero 6 al vector `$Enteros`, mientras que en la segunda se añaden los elementos "Sábado" y "Domingo" al vector `$Texto`.

Para eliminar un elemento de un vector PowerShell no ofrece un sistema parecido al de añadir valores, sino que tendrá que reescribirse el vector de nuevo sin los valores no deseados.

### Funciones

También en PowerShell es posible utilizar funciones a través de la siguiente estructura:

``` pwsh
Function <NOMBRE> {
    Param (<Parametro>,<Parametro>,...)
        Comandos PowerShell
}
```

!!! warning
    El paso de parámetros a una función se realiza de idéntica forma que en shell script. **La principal diferencia** entre las funciones usadas en shell script es que ahora es preferible **declarar y tipar** antes de iniciar con el código de la función.

!!! example
    ```pwsh
    Function Get-Sumar {
        param ([integer] $a, [integer] $b)
        $sumar = $a + $b
        Write-Host "La suma es $sumar"
    }
    ```

!!! note
    Si se ejecuta la siguiente instrucción: `Get-Sumar 2 8` La salida del terminal será `La suma es 10`.

Si se necesita que las funciones estén disponibles durante la sesión del usuario o si es necesario enlazarlas desde otro script, se deberá utilizar la notación de punto, del mismo modo que ocurría en shell script.

---

## Actividades

!!! tip "Formato de entrega"
    Escribe el código de los scripts en **PowerShell** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.ps1, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.

<a name="AC201"></a>

* :simple-readdotcv: **AC201**. (RA.7 // CE7a, CE7b, CE7g y CE7i // 1-3p) Genera un Script que muestre los **procesos del sistema** ordenados por el **id**.

<a name="AC202"></a>

* :simple-readdotcv: **AC202**. (RA.7 // CE7a, CE7b, CE7g y CE7i // 1-3p) Muestra los servicios cuyo nombre empiece por la letra `n`, utilizando la creación de un script.

<a name="AC203"></a>

* :simple-readdotcv: **AC203**. (RA.7 // CE7a, CE7b, CE7f y CE7i // 1-3p) Crea un script que se le introduzca dos números como argumentos y los muestre por pantalla.

<a name="AC204"></a>

* :simple-readdotcv: **AC204**. (RA.7 // CE7a, CE7b, CE7f y CE7i // 1-3p) Diseña un script en PowerShell que pida al usuario dos números, los guarde en dos variables y los muestre por pantalla.

<a name="AC205"></a>

* :simple-readdotcv: **AC205**. (RA.7 // CE7a, CE7b, CE7f y CE7i // 1-3p) Crea un script PowerShell que muestre por pantalla el resultado de de las siguientes operaciones. Debes tener en cuenta que a, b y c son variables enteras que son preguntadas al usuario al iniciar el script.
    * a%b
    * a/c
    * 2 * b + 3 * (a-c)
    * a * (b/c)
    * (a*c)%b

<a name="AC206"></a>

* :simple-readdotcv: **AC206**. (RA.7 // CE7a, CE7f y CE7i // 1-3p) Crea un script que si no se le pasa ningún argumento nos lo diga.

<a name="AC207"></a>

* :simple-readdotcv: **AC207**. (RA.7 // CE7a, CE7f y CE7i // 1-3p) Crea un script PowerShell que al ejecutarlo muestre por pantalla uno de estos mensajes **"Buenos días"**, **"Buenas tardes"** o **"Buenas noches"**, en función de la hora que sea en el sistema (de 8:00 de la mañana a 15:00 será mañana, de 15:00 a 20:00 será tarde y el resto será noche). Usa el `cmdlet Get-Date`.

<a name="AC208"></a>

* :simple-readdotcv: **AC208**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7f y CE7i // 1-3p) Construye tres script PowerShell utilizando estructuras iterativas:
    1. el primero **ej208A.ps1**, que imprima la **tabla de multiplicar** de un número preguntado al usuario. Este número debe ser entero positivo.
    2. el segundo **ej208B.ps1**, que pida un número e indique si se trata de un número par y si es número primo.
    3. el tercero **ej208C.ps1**, que muestre las diez primeras tablas de multiplicar por pantalla. Hay un tiempo de espera de un segundo entre ellas. Utiliza las estructuras **while, do while, for y foreach y el cmdlet Start-Sleep.**

!!! note "NOTA"
    Utiliza en la generación de los scripts los **cmdlets** de depuración si así lo consideras al haber encontrado problemas en la ejecución.

<a name="AC209"></a>

* :simple-readdotcv: **AC209**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7f, CE7h y CE7i // 1-3p) Diseña un script PowerShell que lea un vector con 365 temperaturas y calcule la media y cuantos días han estado por encima y cuantos por debajo de ella. Rellena el vector con valores aleatorios entre -5 y 35, para ello usa Get-Random.

<a name="AC210"></a>

* :simple-readdotcv: **AC210**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i // 1-3p) Crea un script PowerShell para que haga una **copias de seguridad** de todos los archivos del directorio de trabajo del usuario actual. Deberá realizar las siguientes acciones:
    * **comprobará** si el archivo ya existe en la copia de seguridad, si es así comprobará cual de los dos es más reciente y que tamaño tienen. Si es más reciente o posee un tamaño mayor, lo copiará. En cualquier otro caso, no lo copia.
    * llevará un **registro** de todos los archivos copiados cada vez que se ejecute mediante un archivo de bitácora. Guarda este fichero el directorio que contiene el script.

Crea una **función** para cada tarea realizada en este script.

!!! note "NOTA"
    Utiliza en la generación de los scripts los **cmdlets** de depuración si así lo consideras al haber encontrado problemas en la ejecución.

<a name="AC211"></a>

* :simple-readdotcv: **AC211**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i // 1-3p) Crea un script PowerShell que rellene un vector con diez números de **forma aleatoria** y que los **muestre** por pantalla de la siguiente forma:
    * en **orden inverso** a como han sido introducidos los valores.
    * los valores ordenados de **menor a mayor** en una sola línea.
    * los valores ordenados de **mayor a menor** en una sola línea la suma total de sus valores.
    * cantidad de valores pares que contiene el vector.
    * la **suma total** de números impares.
    * la **media aritmética** de los valores que contiene el vector.

<a name="AC212"></a>

* :simple-readdotcv: **AC212**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i // 1-3p) Diseña un script PowerShell que muestre un menú al usuario con cuatro operaciones disponibles: **Crear directorio, Eliminar directorio, Mostrar directorio, Informe de directorio, Copia de directorio y Salir**. Una vez elegida una opción correcta, el programa debe **solicitar un nombre de directorio** y hacer la operación seleccionada. Tras esto debe mostrar un mensaje con el resultado de la operación. Crea una función para cada una de estas opciones.
    * Si se elige la opción **Informe de directorio**, mostrará por pantalla el número de ficheros que contiene, cuantos son carpetas, cuantos directorios y el tamaño total de ellos. Si la carpeta no existe, mostrará un error.
    * Si elige la opción **Copia de directorio**, preguntará la carpeta de destino y mostrará fichero a fichero la copia.

<a name="AC213"></a>

* :simple-readdotcv: **AC213**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i // 1-3p) Realiza un script PowerShell que permita crear un informe de las IP libres en la red en la que se encuentra el equipo. Debe contener las siguientes opciones:
    * **el informe contendrá** un listado de todas las IP de la red a la que pertenece el equipo indicando si está libre o no (usa el comando ping).
    * en el informe debe aparecer el **tipo de red** (A, B o C) en el que está inmerso el ordenador con el **nombre de la red, su broadcast y su máscara de subred.**

<a name="RETO_GRUPAL"></a>

* :material-trophy: **RG214**. (RA.7 // CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i // 30p). Trabajo en grupos de 2 personas para crear un sistema completo de gestión de servicios de Windows que integre todos los conceptos aprendidos durante la unidad.
    * **[RETO GRUPAL: Sistema de Gestión de Servicios de Windows](RetoGrupalPowerShell.md)**.  
    * [Consulta aquí la solución detallada del reto grupal](SolucionRetoGrupalPowerShell.md)
* :clipboard: **Rúbrica de Evaluación:** Consulta los criterios de evaluación detallados en la [Rúbrica de Evaluación del Reto PowerShell](Rubrica_Evaluacion_RetoPowerShell.md).


---

