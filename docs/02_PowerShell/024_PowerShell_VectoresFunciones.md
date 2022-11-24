# Vectores y Funciones

## Vectores

* PowerShell considera como un vector a toda colección de objetos, sea cual sea su tipo.
* Los elementos que lo conforman pueden estar separados por comas, estar expresados por el operador de rango `..` o ser el resultado de alguna expresión que devuelva una colección, como así lo hacen muchos cmdlets.

!!! example
    ``` pwsh
    $Vacia = @{}
    $Enteros = 1,2,3,4,5
    $Texto = “Lunes”,“Martes”,”Miércoles”, “Jueves”,”Viernes”
    $EnterosRango = 1..10
    ```

De esta forma se han definido cuatro vectores; el segundo contendrá enteros y el tercero cadenas de caracteres. La última línea asigna los valores desde el 1 al 10 utilizando el operador rango `..` .

!!! note
    El operador de **rango** representa una secuencia de enteros, con los límites superior e inferior separados por dos puntos decimales. Permite expresar el rango en orden ascendente o descendente, así como también que los límites inferior o superior sean establecidos por medio de variables que contengan enteros.

* Un vector también puede definirse como el resultado de una expresión.

!!! example
    ``` pwsh
    $EnterosFor = @(For($i;$i < 5;$i++){$i})
    $Comando = Get-Process | Sort-Object ProcessName
    ```

En la primera línea ``$enteros`` será completado a través del resultado de una estructura iterativa, mientras que la segunda contendrá el resultado del cmdlet indicado. Además de todas estas formas de declaración, también se puede realizar a través del cmdlet ``New-Variable``

!!! example
    ``` pwsh
    New-Variable -Name Enteros -Value 1,2,3,4,5 -Force
    New-Variable -Name Texto -Value "Lunes","Martes","Miércoles","Jueves","Viernes" –Force
    New-Variable -Name EnterosRango -Value (1..5) -Force
    New-Variable -Name EnterosFor -value (. {For($i=1;$i -lt 5;$i++){$i}}) -Force
    ```

!!! note
    El atributo `-Force` sobrescribe la variable si esta ya existe, de ese modo no saltará ningún error a la hora de definir estas variables.

* Para obtener el número de elementos de un vector se utiliza el método Length, si se aplica a un elemento del vector, devolverá el tamaño de este elemento, no del vector completo.

!!! example
    ``` pwsh
    $Texto.Length # mostrará 5 por pantalla
    $Texto[2].Length # mostrará 9, las letras de “Miércoles”
    ```

* Para añadir elementos al final de un vector se utiliza el operador `+=`.

!!! example
    ``` pwsh
    $Enteros += 6
    $Texto += “Sábado”, “Domingo”
    ```

!!! note
    La primera línea añade el entero 6 al vector `$Enteros`, mientras que en la segunda se añaden los elementos “Sábado” y “Domingo” al vector `$Texto`.

* Para eliminar un elemento de un vector PowerShell no ofrece un sistema parecido al de añadir valores, sino que tendrá que reescribirse el vector de nuevo sin los valores no deseados.

## Funciones

También en PowerShell es posible utilizar funciones a través de la siguiente estructura:

``` pwsh
Function <NOMBRE> {
    Param (<Parámetro>,<Parámetro>,...)
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
        Write-Host “La suma es $sumar”
    }
    ```

!!! note
    Si se ejecuta la siguiente instrucción: `Get-Sumar 2 8` La salida del terminal será `La suma es 10`.

Si se necesita que las funciones estén disponibles durante la sesión del usuario o si es necesario enlazarlas desde otro script, se deberá utilizar la notación de punto, del mismo modo que ocurría en shell script.

## Actividades

!!! note "NOTA"
    Escribe el código de los scripts en **PowerShell** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.

209. Diseña un script PowerShell que lea un vector con 365 temperaturas y calcule la media y cuantos días han estado por encima y cuantos por debajo de ella. Rellena el vector con valores aleatorios entre -5 y 35, para ello usa Get-Random.

210. Crea un script PowerShell para que haga una **copias de seguridad** de todos los archivos del directorio de trabajo del usuario actual. Deberá realizar las siguientes acciones:
    * **comprobará** si el archivo ya existe en la copia de seguridad, si es así comprobará cual de los dos es más reciente y que tamaño tienen. Si es más reciente o posee un tamaño mayor, lo copiará. En cualquier otro caso, no lo copia.
    * llevará un **registro** de todos los archivos copiados cada vez que se ejecute mediante un archivo de bitácora. Guarda este fichero el directorio que contiene el script.

Crea una **función** para cada tarea realizada en este script.

!!! note "NOTA"
    Utiliza en la generación de los scripts los **cmdlets** de depuración si así lo consideras  al haber encontrado problemas en la ejecución.