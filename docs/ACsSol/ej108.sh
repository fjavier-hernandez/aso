#!/bin/bash
# =============================================================================
# SCRIPT: ej108.sh - Saludo según la hora del día
# =============================================================================
# Crea un shell script que al ejecutarlo muestre por pantalla uno de estos mensajes:
# “Buenos días”, “Buenas tardes” o “Buenas noches”,
# en función de la hora que sea en el sistema.
# De 8:00 a 15:00 será mañana, de 15:00 a 20:00 será tarde y el resto será noche.
# Para obtener la hora del sistema utiliza el comando date.
# =============================================================================

# OBTENER HORA ACTUAL
# date +%T = comando que devuelve la hora en formato HH:MM:SS
# $(...) = sustitución de comando para capturar la salida
d=$(date +%T)

# DEFINIR HORARIOS DE REFERENCIA
# Establecemos los límites para cada período del día
dia="15:00:00"    # Hasta las 15:00 es "día"
tarde="20:00:00"  # Entre 15:00 y 20:00 es "tarde"

# LÓGICA DE COMPARACIÓN DE HORAS
# if-elif-else = estructura condicional múltiple
# \< = operador de comparación "menor que" para strings
if [ $d \< $dia ]
then
	# HORA ANTERIOR A LAS 15:00
	echo 'Buenos días'

elif [ $d \< $tarde ]
then
	# HORA ENTRE 15:00 Y 20:00
	# Solo se ejecuta si la primera condición fue falsa
	echo 'Buenas tardes'

else
	# HORA POSTERIOR A LAS 20:00
	# Se ejecuta si ninguna de las condiciones anteriores fue verdadera
	echo 'Buenas noches'
fi