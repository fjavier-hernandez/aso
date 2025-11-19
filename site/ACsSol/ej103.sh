#!/bin/bash
# =============================================================================
# SCRIPT: ej103.sh 
# =============================================================================
# AC103. Modifica el script anterior para que, además, muestre por pantalla el número de líneas, palabras y caracteres del archivo.
# =============================================================================

# VALIDACIÓN DE EXISTENCIA DE ARCHIVO
# -a = operador de test que verifica si el archivo existe
# $1 = primer parámetro pasado al script (nombre del archivo)
# Si el archivo existe, ejecutamos el bloque then
if [ -a $1 ]
then
	# PROCESAMIENTO CUANDO EL ARCHIVO EXISTE
	# wc = comando para contar líneas, palabras y caracteres
	# -l = cuenta solo líneas
	# -w = cuenta solo palabras
	# -c = cuenta solo caracteres
	# $1 = nombre del archivo a analizar
	# $(...) = sustitución de comando (ejecuta wc y usa su salida)
	
	echo "El fichero existe. Análisis completo:"
	echo "=========================================="
	echo "Número de líneas: $(wc -l < $1)"
	echo "Número de palabras: $(wc -w < $1)"
	echo "Número de caracteres: $(wc -c < $1)"
	echo "=========================================="
	
	# INFORMACIÓN ADICIONAL: Mostrar estadísticas completas
	# wc sin opciones muestra líneas, palabras y caracteres en una línea
	echo "Estadísticas completas: $(wc $1)" 

else
	# MANEJO DE ERROR - ARCHIVO NO ENCONTRADO
	# Si el archivo no existe, mostramos mensaje de error
	echo 'El fichero no existe'
	# Salimos del script con código de error
	exit
fi