# Sintaxis

## Parámetros en PowerShell

* A diferencia de GNU/Linux, los parámetros que reciba el script en PowerShell se reciben en el array **args**,
* Cada posición del array `args[]` guarda los parámetros introducidos al script en el orden indicado.
* Por lo tanto para acceder a los parámetros introducidos se debe acceder al valor de la posición que se desee.

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

* Para poder ejecutar este script, será necesario acompañarlo de un parámetro del siguiente modo.

``` pwsh
./Script.ps1 "Fº Javier Hernández Illán"
```

* Para entender por completo el ejemplo anterior, será necesario ver como PowerShell maneja las **variables**.

## Variables

* Para definir una variable en PowerShell sólo tenemos que nombrarla utilizando para ello cualquier combinación de caracteres, ya sean números, letras o símbolos.
* Es posible utilizar espacios en el nombre, aunque en este caso el nombre debe ir rodeado por símbolos de llaves **{}**.
* Al contrario que ocurre en shellscript, PowerShell es **fuertemente tipado**, lo que significa que las variables no son tratadas como cadenas de texto, sino que hay que especificar el tipo de dato que se guardará en ella.
* Para definir variables es posible utilizar el método **explícito** (además con **New-Variable** y sus opciones), pero también se puede utilizar el método **implícito** anteponiendo el símbolo **$** delante del nombre.

!!! info
    **Get-Variable** En cualquier momento puedes obtener una lista completa de las variables que se hayan definido hasta ese momento. Para lograrlo, basta con utilizar Get- Variable.

### Implícita

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

* En la forma implícita el shell establece el tipo de dato de la variable en función del dato que se le asigne en su creación.
* En el ejemplo anterior `$numero` es de forma automática de tipo `[double]`, ya que al crearla se ha inicializado con un número con decimales. 
* Por contra la variable `$Final_2021` es de tipo `[int]` ya que se ha guardado un número entero en ella.

!!! info
    * **GetType** Para poder obtener el tipo de dato  de una variable hay que usar el método `GetType().Name` sobre cualquier variable:
    * `Write-Host $numero.GetType().Name.`

!!! tip
    - Una variable cuya definición de tipo se ha realizado de forma implícita, podrá cambiar el tipo de dato almacenado durante la ejecución del programa sin experimentar ningún tipo de error. 
    - Esta práctica aunque cómoda **no es muy recomendable**.

### Explicita

* Es buena idea tomar el control del tipado de las variables y asignarlo en función de las necesidades del programa. 
* De esta forma se ahorrarán futuras conversiones de datos y posibles pérdidas de información.
* Para ello se usa la forma explícita de crear variables y junto con su creación se define el tipo de dato que va a contener.

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

PowerShell posee dos cmdlets para realizar estas tareas.

1. El primero de ellos es **Write-Host** y tiene un comportamiento similar al **echo** en GNU/Linux.
2. El segundo comando para interactuar con el usuario es **Read-Host** el cual permite imprimir un mensaje por el terminal y recoger aquello que el usuario ha escrito. Funciona de forma muy parecida al comando **read** en el terminal de GNU/Linux.

``` pwsh
[string] $marine = Read-Host "¿Cuál es el nombre del marine de Doom?"
Write-Host "No se sabe, pero lo has intentado con $marine
```

!!! note
    Este script detendrá su ejecución en la línea donde aparece **Read-Host**, esperará a que el usuario conteste a la pregunta y seguirá con la ejecución, del mismo modo que ocurre con shellscript.

## Operadores

### Aritméticos

* Las operaciones aritméticas en PowerShell son más intuitivas que en shellscript.
* Son las mismas que en el caso anterior: `+`, `-`, `*` , `/` y `%`.
* Su uso es más sencillo puesto que es el propio terminal en que realiza los cálculos aritméticos y no a través de un comando.

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

* Como en todos los lenguajes de programación fuertemente tipados, existen operadores lógicos para comprobar el tipo de dato de una variable, que resultan muy útiles para la interacción con los usuarios.

| Operador      | Acción                             | Ejemplo |
| ------------- | ------------------------------- | ------------ |
|`-is` |Devuelve verdadero si es del tipo indicado.| `"Javi" -is [string]` es verdadero|
|`-isnot` |Devuelve falso si es del tipo indicado. |`"Javi" -isnot [string]` es falso|
|`-as `|Convierte tipos de datos compatibles.|`$valor = 19.90`; `Write-Host ($valor -as [int])`|

### Comparación

los operadores tipo lógicos devuelven tan sólo un valor booleano que puede tener dos valores; **verdadero o falso**.

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

## Actividades

!!! note "NOTA"
    Escribe el código de los scripts en **PowerShell** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.

203. Crea un script que se le introduzca dos números como argumentos y los muestre por pantalla.

204. Diseña un script en Shell que pida al usuario dos números, los guarde en dos variables y los muestre por pantalla.

205. Crea un shell script que muestre por pantalla el resultado de de las siguientes operaciones. Debes tener en cuenta que a, b y c son variables enteras que son preguntadas al usuario al iniciar el script.
    * a%b
    * a/c
    * 2 * b + 3 * (a-c)
    * a * (b/c)
    * (a*c)%b