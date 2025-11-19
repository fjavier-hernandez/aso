#!/bin/bash
# =============================================================================
# SCRIPT: ej114.sh - Análisis estadístico de vector con menú select
# =============================================================================
# AC114. Crea un script que muestre las opciones del ejercicio anterior con select. 
# El usuario introducirá los valores del vector al iniciar el script. 
# Cuando termine aparecerá el menú de selección (deberás añadir la opción para salir del script). 
# Además deberás crear una función para cada opción del menú y llamarla en cada una de las opciones del select.
# =============================================================================

# DECLARACIÓN DEL VECTOR GLOBAL
vector=()

# =============================================================================
# FUNCIÓN: Entrada de datos del vector
# =============================================================================
function entrada_datos() {
    echo "=========================================="
    echo "ENTRADA DE DATOS DEL VECTOR"
    echo "=========================================="
    echo "Introduce 10 números enteros:"
    echo "=========================================="
    
    for i in {0..9}
    do
        read -p "Introduce el número $((i+1)): " numero
        
        if ! echo "$numero" | grep -xq "[0-9]\{1,\}" || [ -z "$numero" ]; then
            echo "Error: Debe introducir un número entero válido."
            exit 1
        fi
        
        vector[$i]=$numero
    done
    
    echo "=========================================="
    echo "Datos introducidos correctamente."
    echo "Vector: ${vector[@]}"
    echo "=========================================="
}

# =============================================================================
# FUNCIÓN: Mostrar vector en orden inverso
# =============================================================================
function mostrar_orden_inverso() {
    echo "=========================================="
    echo "VECTOR EN ORDEN INVERSO"
    echo "=========================================="
    
    for ((i=9; i>=0; i--))
    do
        echo -n "${vector[$i]} "
    done
    echo ""
    echo "=========================================="
}

# =============================================================================
# FUNCIÓN: Mostrar valores ordenados de menor a mayor
# =============================================================================
function mostrar_orden_ascendente() {
    echo "=========================================="
    echo "VALORES ORDENADOS DE MENOR A MAYOR"
    echo "=========================================="
    
    echo "${vector[@]}" | tr ' ' '\n' | sort -n | tr '\n' ' '
    echo ""
    echo "=========================================="
}

# =============================================================================
# FUNCIÓN: Mostrar valores ordenados de mayor a menor
# =============================================================================
function mostrar_orden_descendente() {
    echo "=========================================="
    echo "VALORES ORDENADOS DE MAYOR A MENOR"
    echo "=========================================="
    
    echo "${vector[@]}" | tr ' ' '\n' | sort -nr | tr '\n' ' '
    echo ""
    echo "=========================================="
}

# =============================================================================
# FUNCIÓN: Calcular y mostrar suma total
# =============================================================================
function mostrar_suma_total() {
    echo "=========================================="
    echo "SUMA TOTAL DE VALORES"
    echo "=========================================="
    
    suma_total=0
    
    for i in {0..9}
    do
        suma_total=$((suma_total + vector[i]))
    done
    
    echo "Suma total: $suma_total"
    echo "=========================================="
}

# =============================================================================
# FUNCIÓN: Contar valores pares
# =============================================================================
function contar_valores_pares() {
    echo "=========================================="
    echo "CANTIDAD DE VALORES PARES"
    echo "=========================================="
    
    pares=0
    
    for i in {0..9}
    do
        if [ $((vector[i] % 2)) -eq 0 ]; then
            pares=$((pares + 1))
        fi
    done
    
    echo "Cantidad de valores pares: $pares"
    echo "=========================================="
}

# =============================================================================
# FUNCIÓN: Sumar números impares
# =============================================================================
function sumar_numeros_impares() {
    echo "=========================================="
    echo "SUMA TOTAL DE NÚMEROS IMPARES"
    echo "=========================================="
    
    suma_impares=0
    
    for i in {0..9}
    do
        if [ $((vector[i] % 2)) -ne 0 ]; then
            suma_impares=$((suma_impares + vector[i]))
        fi
    done
    
    echo "Suma total de números impares: $suma_impares"
    echo "=========================================="
}

# =============================================================================
# FUNCIÓN: Calcular media aritmética
# =============================================================================
function calcular_media_aritmetica() {
    echo "=========================================="
    echo "MEDIA ARITMÉTICA"
    echo "=========================================="
    
    suma_total=0
    
    for i in {0..9}
    do
        suma_total=$((suma_total + vector[i]))
    done
    
    media=$((suma_total / 10))
    
    echo "Suma total: $suma_total"
    echo "Media aritmética: $media"
    echo "=========================================="
}

# =============================================================================
# FUNCIÓN: Mostrar información del vector
# =============================================================================
function mostrar_informacion_vector() {
    echo "=========================================="
    echo "INFORMACIÓN DEL VECTOR"
    echo "=========================================="
    echo "Vector original: ${vector[@]}"
    echo "Total de elementos: ${#vector[@]}"
    echo "=========================================="
}

# =============================================================================
# PROGRAMA PRINCIPAL
# =============================================================================

echo "=========================================="
echo "ANÁLISIS ESTADÍSTICO DE VECTOR CON MENÚ"
echo "=========================================="

# ENTRADA DE DATOS AL INICIAR EL SCRIPT
entrada_datos

# =============================================================================
# BUCLE PRINCIPAL DEL MENÚ SELECT
# =============================================================================
# while true = bucle infinito que se ejecuta hasta que se use exit
# Este bucle mantiene el menú activo hasta que el usuario elija salir
while true
do
    # MOSTRAR ENCABEZADO DEL MENÚ
    echo ""
    echo "=========================================="
    echo "MENÚ DE OPCIONES"
    echo "=========================================="
    
    # CONFIGURACIÓN DEL PROMPT DEL SELECT
    # PS3 = variable especial que define el prompt mostrado por select
    # Se muestra cuando el usuario debe introducir su selección
    PS3="Selecciona una opción (1-9): "
    
    # ESTRUCTURA SELECT - MENÚ INTERACTIVO
    # select = comando especial de bash que crea un menú interactivo
    # opcion = variable que contendrá la opción seleccionada
    # in = separa la variable de la lista de opciones
    # \ = continuación de línea para mejorar legibilidad
    # Cada opción se enumera automáticamente (1, 2, 3, etc.)
    select opcion in \
        "Mostrar vector en orden inverso" \
        "Mostrar valores ordenados de menor a mayor" \
        "Mostrar valores ordenados de mayor a menor" \
        "Calcular suma total de valores" \
        "Contar cantidad de valores pares" \
        "Sumar números impares" \
        "Calcular media aritmética" \
        "Mostrar información del vector" \
        "Salir del script"
    do
        # ESTRUCTURA CASE PARA MANEJAR OPCIONES
        # case = estructura condicional múltiple más eficiente que if-elif
        # $REPLY = variable especial que contiene el número de la opción seleccionada
        # (1, 2, 3, etc.) independientemente del texto de la opción
        case $REPLY in
            1)
                # OPCIÓN 1: Mostrar vector en orden inverso
                # Llamada a la función correspondiente
                mostrar_orden_inverso
                # break = sale del select para volver al menú principal
                # Sin break, el select se quedaría esperando otra entrada
                break
                ;;
            2)
                # OPCIÓN 2: Mostrar valores ordenados de menor a mayor
                mostrar_orden_ascendente
                break
                ;;
            3)
                # OPCIÓN 3: Mostrar valores ordenados de mayor a menor
                mostrar_orden_descendente
                break
                ;;
            4)
                # OPCIÓN 4: Calcular suma total de valores
                mostrar_suma_total
                break
                ;;
            5)
                # OPCIÓN 5: Contar cantidad de valores pares
                contar_valores_pares
                break
                ;;
            6)
                # OPCIÓN 6: Sumar números impares
                sumar_numeros_impares
                break
                ;;
            7)
                # OPCIÓN 7: Calcular media aritmética
                calcular_media_aritmetica
                break
                ;;
            8)
                # OPCIÓN 8: Mostrar información del vector
                mostrar_informacion_vector
                break
                ;;
            9)
                # OPCIÓN 9: Salir del script
                echo "=========================================="
                echo "SALIENDO DEL SCRIPT"
                echo "=========================================="
                echo "¡Hasta luego!"
                # exit 0 = termina el script completamente con código de salida 0 (éxito)
                # 0 = éxito, !=0 = error
                exit 0
                ;;
            *)
                # OPCIÓN INVÁLIDA: Cualquier número que no sea 1-9
                # * = caso por defecto que captura cualquier opción no contemplada
                echo "Opción inválida. Por favor, selecciona una opción del 1 al 9."
                # No hay break aquí, por lo que el select vuelve a mostrar el menú
                # y espera una nueva entrada del usuario
                ;;
        esac
    done
    # FIN DEL SELECT
    # Cuando se ejecuta break, el control vuelve aquí
    # El bucle while true se reinicia y muestra el menú nuevamente
done
# FIN DEL BUCLE PRINCIPAL
# Este punto solo se alcanza si se ejecuta exit 0 en la opción 9