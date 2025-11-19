#!/bin/bash
# =============================================================================
# SCRIPT: ej104.sh - Operaciones matemáticas con variables enteras
# =============================================================================
# AC104. Crea un shell script que muestre por pantalla el resultado de las siguientes operaciones.
# Debes tener en cuenta que a, b y c son variables enteras que son preguntadas al usuario al iniciar el script.
# Operaciones a realizar:
# a) a % b      - Resto de a dividido por b
# b) a / c      - División entera de a entre c
# c) 2 * b + 3 * (a - c) - Expresión algebraica
# d) a * (b / c) - a multiplicado por la división entera de b entre c
# e) (a * c) % b - Resto de (a * c) dividido por b
# =============================================================================

# PRESENTACIÓN DEL SCRIPT
echo 'Este script muestra por pantalla los resultados de las operaciones matemáticas con variables a, b y c'

# ENTRADA DE DATOS
# read -p = lee entrada del usuario mostrando un prompt
# Guardamos los valores en variables a, b, c (variables enteras)
read -p  'Introduce el valor de a: ' a
read -p  'Introduce el valor de b: ' b
read -p  'Introduce el valor de c: ' c

# VALIDACIÓN DE ENTRADA
# Concatenamos los tres números y verificamos que sean solo dígitos
# grep -x = busca coincidencia exacta en toda la línea
# "[0-9]\{1,\}" = expresión regular que busca uno o más dígitos
# >/dev/null = redirige la salida a /dev/null (descarta el resultado)
echo $a$b$c | grep -x "[0-9]\{1,\}" >/dev/null

# VERIFICACIÓN DE VALIDEZ
# $? = código de salida del último comando (0 = éxito, !=0 = error)
# -ne 0 = no igual a 0 (grep no encontró coincidencia)
# -z = verifica si la variable está vacía
# || = operador OR lógico
if [ $? -ne 0 ] || [ -z $a ] || [ -z $b ] || [ -z $c ] 
then
	echo 'Error en la introducción de los números'
	exit # Salimos del script si hay error
fi

# OPERACIONES MATEMÁTICAS SEGÚN EL ENUNCIADO
# let = comando para realizar operaciones aritméticas
# % = operador módulo (resto de la división)
# / = división entera

# a) a%b - Resto de a dividido por b
let resultado1=$a%$b

# b) a/c - División entera de a entre c
let resultado2=$a/$c

# c) 2 * b + 3 * (a-c) - Expresión algebraica
let resultado3="2*$b+3*($a-$c)"

# d) a * (b/c) - a multiplicado por la división entera de b entre c
let resultado4="$a*($b/$c)"

# e) (a*c)%b - Resto de (a*c) dividido por b
let resultado5="($a*$c)%$b"

# MOSTRAR RESULTADOS
echo "=========================================="
echo "Resultados de las operaciones:"
echo "=========================================="
echo "a) a%b = $a%$b = $resultado1"
echo "b) a/c = $a/$c = $resultado2"
echo "c) 2*b + 3*(a-c) = 2*$b + 3*($a-$c) = $resultado3"
echo "d) a*(b/c) = $a*($b/$c) = $resultado4"
echo "e) (a*c)%b = ($a*$c)%$b = $resultado5"
echo "=========================================="