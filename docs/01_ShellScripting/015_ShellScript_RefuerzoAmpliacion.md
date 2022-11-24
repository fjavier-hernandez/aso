# Refuerzo y Ampliación

En esta sesión se trabajan actividades para reforzar los contenidos estudiados en esta unidad, y actividades de ampliación para profundizar en dichos contenidos.

## Actividades

!!! note
    Escribe el código de los scripts en **ShellScript** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.

### Refuerzo

116. Realiza un shell script que admita un único parámetro correspondiente al nombre de un fichero de texto. Mostrará por pantalla el número de líneas del mismo utilizando el comando `wc`.

117. Modifica el shell script realizado en el ejercicio anterior para comprobar si el fichero existe. Si el fichero no existe, debe mostrar un mensaje de error y salir.

118. Construye los siguientes dos shell script utilizando estructuras iterativas:
    1. el primero `ej108A.sh`, que pida un número e indique si se trata de un número par y si es número primo.
    2. el tercero `ej108B.sh`, que muestre las 10 primeras tablas de multiplicar por pantalla. Existirá un tiempo de espera de dos segundos entre tabla (usa el comando sleep para ello).

119. Genera un script que muestre la tabla de multiplicar de un número introducido por pantalla por el usuario.

### Ampliación

120. Escribe un shell script que genere dos vectores de quince elementos cada uno y los rellene con número aleatorios comprendidos entre 0 y 100. Después sume esas dos estructuras y muestre los tres vectores por pantalla. Para ello crea las funciones **imprimir_array(array_a_imprimir)** y **sumar_array(array1, array2).**

121. Realiza un script que permita crear un informe de las **IP libres** en la red en la que se encuentra el equipo. Debe contener las siguientes opciones:
    1. El informe contendrá un **listado de todas las IP de la red** a la que pertenece el equipo indicando si está libe o no (usa el comando ping).
    2. En el informe debe aparecer el **tipo de red** (rango CIDR) en el que está inmerso el ordenador con el **nombre de la red**, su **broadcast** y su **máscara de subred**. Esta información la podéis obtener desde el comando ifconfig.

!!! note
    Para facilitar los cálculos asumimos que el equipo donde se ejecuta el script se encuentra en una única red, es decir, solo posee una tarjeta de red.

122. Crea un shell script que funcione de manera similar a la papelera de reciclaje. El manejo de los ficheros se debe realizar a través de vectores. El programa debe mostrar el siguiente menú e implementar sus operaciones que serán implementadas a través de funciones:
    1. **eliminar archivo**. Esta operación recibe la ruta completa de un archivo y lo mueve al directorio `/home/tu_usuario/recycled.` Si no existe dicho directorio, el programa ha de crearlo.
    2. **restaurar archivo**. Esta operación recibe el nombre de un archivo y lo mueve, desde la papelera de reciclaje, al directorio en el que estuviera anteriormente. El proceso de eliminación, debe haber almacenado, por tanto dicho directorio en un fichero de texto.
    3. restaurar toda la papelera. Esta operación es similar a la anterior, pero se efectúa sobre todos los ficheros de la papelera.
    4. **vaciar la papelera**. Esta opción vacía el contenido de la papelera. Ninguno de los archivos será recuperable.
    5. **mostrar la papelera**. Esta opción muestra el contenido de la papelera.
    6. **salir**. Sale del programa.