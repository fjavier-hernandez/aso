#!/bin/bash
# =============================================================================
# SCRIPT: ej105.sh - Análisis de parámetros del script
# =============================================================================
# AC105. Realiza un script que muestre por pantalla los parámetros introducidos separados por espacio, 
# el número de parámetros que se han pasado, y el nombre del script.
# =============================================================================

# MOSTRAR INFORMACIÓN DEL SCRIPT
echo "=========================================="
echo "ANÁLISIS DE PARÁMETROS DEL SCRIPT"
echo "=========================================="

# MOSTRAR EL NOMBRE DEL SCRIPT
# $0 = variable especial que contiene el nombre del script
echo "Nombre del script: $0"

# MOSTRAR EL NÚMERO DE PARÁMETROS
# $# = variable especial que contiene el número de argumentos pasados
echo "Número de parámetros: $#"

# MOSTRAR LOS PARÁMETROS INTRODUCIDOS
# $* = variable especial que contiene todos los argumentos como una sola cadena
# $@ = variable especial que contiene todos los argumentos como elementos separados
echo "Parámetros introducidos: $*"

# MOSTRAR INFORMACIÓN ADICIONAL
echo "=========================================="
echo "INFORMACIÓN DETALLADA:"
echo "=========================================="

# VERIFICAR SI HAY PARÁMETROS
if [ $# -eq 0 ]
then
    echo "No se han introducido parámetros."
else
    echo "Lista de parámetros individuales:"
    # BUCLE PARA MOSTRAR CADA PARÁMETRO INDIVIDUALMENTE
    # for = bucle que itera sobre los argumentos
    # $@ = todos los argumentos como elementos separados
    contador=1
    for parametro in "$@"
    do
        # $contador = número del parámetro
        # $parametro = valor del parámetro
        echo "  Parámetro $contador: $parametro"
        contador=$((contador + 1))
    done
fi

echo "=========================================="
