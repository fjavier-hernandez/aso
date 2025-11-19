#!/bin/bash
# =============================================================================
# SCRIPT: ej111.sh - Informe de IP libres en la red
# =============================================================================
# AC111. Realiza un script utilizando funciones que permita crear un informe de las IP libres 
# en la red en la que se encuentra el equipo. Debe contener las siguientes opciones:
# - El informe contendrá un listado de todas las IP de la red a la que pertenece el equipo 
#   indicando si está libre o no (usa el comando ping).
# - En el informe debe aparecer el tipo de red (rango CIDR) en el que está inmerso el ordenador 
#   con el nombre de la red, su broadcast y su máscara de subred. Esta información la podéis 
#   obtener desde el comando ifconfig.
# =============================================================================

# CONFIGURACIÓN DEL ARCHIVO DE INFORME
archivo_informe="informe_red.txt"

# =============================================================================
# FUNCIÓN: Obtener información de la interfaz de red
# =============================================================================
function obtener_info_red() {
	# ifconfig = comando que muestra información de interfaces de red
	# grep "inet " = filtra líneas que contienen direcciones IP
	# head -1 = toma solo la primera línea
	# cut -d' ' -f2 = extrae la segunda columna (dirección IP)
	ip_local=$(ifconfig | grep "inet " | head -1 | cut -d' ' -f2)
	
	# Extraer componentes de la IP
	# cut -d'.' -f1-3 = extrae los primeros 3 octetos (red)
	red=$(echo $ip_local | cut -d'.' -f1-3)
	
	# cut -d'.' -f1 = extrae el primer octeto para determinar la clase
	primer_octeto=$(echo $ip_local | cut -d'.' -f1)
	
	echo "IP local: $ip_local"
	echo "Red: $red.0/24"
	echo "Primer octeto: $primer_octeto"
}

# =============================================================================
# FUNCIÓN: Determinar tipo de red y calcular broadcast
# =============================================================================
function determinar_tipo_red() {
	local primer_octeto=$1
	local red=$2
	
	# Determinar clase de red basada en el primer octeto
	if [ $primer_octeto -ge 1 ] && [ $primer_octeto -le 126 ]
	then
		tipo="Clase A"
		broadcast="$red.255.255.255"
		mascara="255.0.0.0"
		cidr="/8"
	elif [ $primer_octeto -ge 128 ] && [ $primer_octeto -le 191 ]
	then
		tipo="Clase B"
		broadcast="$red.255.255"
		mascara="255.255.0.0"
		cidr="/16"
	else
		tipo="Clase C"
		broadcast="$red.255"
		mascara="255.255.255.0"
		cidr="/24"
	fi
	
	echo "Tipo: $tipo"
	echo "Broadcast: $broadcast"
	echo "Máscara: $mascara"
	echo "CIDR: $cidr"
}

# =============================================================================
# FUNCIÓN: Escanear IPs de la red
# =============================================================================
function escanear_red() {
	local red=$1
	local archivo=$2
	
	echo "Escaneando red $red.0/24..."
	
	# Escanear del 1 al 254 (excluyendo .0 y .255)
	for i in {1..254}
	do
		ip="$red.$i"
		
		# ping -c 1 = envía 1 paquete de prueba
		# -W 1 = timeout de 1 segundo
		# 2>/dev/null = suprime mensajes de error
		if ping -c 1 -W 1 $ip 2>/dev/null >/dev/null
		then
			echo "IP $ip: OCUPADA" >> $archivo
		else
			echo "IP $ip: LIBRE" >> $archivo
		fi
	done
}

# =============================================================================
# FUNCIÓN: Generar informe completo
# =============================================================================
function generar_informe() {
	local archivo=$1
	
	echo "=========================================="
	echo "INFORME DE RED - IP LIBRES Y OCUPADAS"
	echo "=========================================="
	echo "Fecha: $(date)"
	echo "Equipo: $(hostname)"
	echo "=========================================="
	
	# Obtener información de la red
	obtener_info_red
	echo ""
	
	# Determinar tipo de red
	determinar_tipo_red $primer_octeto $red
	echo ""
	
	# Escanear la red
	escanear_red $red $archivo
}

# =============================================================================
# PROGRAMA PRINCIPAL
# =============================================================================

# PRESENTACIÓN DEL SCRIPT
echo "=========================================="
echo "GENERADOR DE INFORME DE RED"
echo "=========================================="

# Obtener información básica de la red
obtener_info_red
echo ""

# Determinar tipo de red
determinar_tipo_red $primer_octeto $red
echo ""

# Generar informe completo
echo "Generando informe en $archivo_informe..."
generar_informe $archivo_informe

echo "=========================================="
echo "Informe completado: $archivo_informe"
echo "=========================================="