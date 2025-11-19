#!/bin/bash
# =============================================================================
# SCRIPT: ej106.sh - Entrada y almacenamiento de dos números
# =============================================================================
# AC106. Diseña un script en Shell que pida al usuario dos números, 
# los guarde en dos variables y los muestre por pantalla.
# =============================================================================

# PRESENTACIÓN DEL SCRIPT
echo "=========================================="
echo "ENTRADA Y ALMACENAMIENTO DE NÚMEROS"
echo "=========================================="

# ENTRADA DEL PRIMER NÚMERO
# read -p = lee entrada del usuario mostrando un prompt
# Guardamos el primer número en la variable numero1
read -p "Introduce el primer número: " numero1

# ENTRADA DEL SEGUNDO NÚMERO
# Guardamos el segundo número en la variable numero2
read -p "Introduce el segundo número: " numero2

# VALIDACIÓN DE ENTRADA (OPCIONAL)
# Verificamos que ambos números sean válidos
# grep -x = busca coincidencia exacta en toda la línea
# "[0-9]\{1,\}" = expresión regular que busca uno o más dígitos
# >/dev/null = redirige la salida a /dev/null (descarta el resultado)
echo $numero1$numero2 | grep -x "[0-9]\{1,\}" >/dev/null

# VERIFICACIÓN DE VALIDEZ
# $? = código de salida del último comando (0 = éxito, !=0 = error)
# -ne 0 = no igual a 0 (grep no encontró coincidencia)
# -z = verifica si la variable está vacía
# || = operador OR lógico
if [ $? -ne 0 ] || [ -z $numero1 ] || [ -z $numero2 ]
then
    echo "Error: Por favor, introduce números válidos."
    exit 1
fi

# MOSTRAR LOS NÚMEROS ALMACENADOS
echo "=========================================="
echo "NÚMEROS ALMACENADOS:"
echo "=========================================="
echo "Primer número: $numero1"
echo "Segundo número: $numero2"
echo "=========================================="

# INFORMACIÓN ADICIONAL
echo "Variables utilizadas:"
echo "- numero1 = $numero1"
echo "- numero2 = $numero2"
echo "=========================================="
