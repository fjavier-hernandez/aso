#!/bin/bash
# =============================================================================
# SCRIPT: ej113.sh - Análisis estadístico de vector
# =============================================================================
# AC113. Genera un script que rellene un vector con diez números pedidos al usuario 
# y que los muestre por pantalla de la siguiente forma:
# - en orden inverso a como han sido introducidos los valores
# - los valores ordenados de menor a mayor en una sola línea
# - los valores ordenados de mayor a menor en una sola línea
# - la suma total de sus valores
# - cantidad de valores pares que contiene el vector
# - la suma total de números impares
# - la media aritmética de los valores que contiene el vector
# =============================================================================

# PRESENTACIÓN DEL SCRIPT
echo "=========================================="
echo "ANÁLISIS ESTADÍSTICO DE VECTOR"
echo "=========================================="

# DECLARACIÓN DEL VECTOR
# En bash, los arrays se declaran con paréntesis
# vector=() = declara un array vacío
vector=()

# ENTRADA DE DATOS POR TECLADO
echo "Introduce 10 números enteros:"
echo "=========================================="

# Bucle for para solicitar 10 números al usuario
# {0..9} = genera números del 0 al 9 (10 elementos)
for i in {0..9}
do
    # read -p = lee entrada del usuario mostrando un prompt
    # $((i+1)) = convierte el índice 0-9 a 1-10 para mostrar al usuario
    read -p "Introduce el número $((i+1)): " numero
    
    # VALIDACIÓN DE ENTRADA
    # Verificamos que sea un número entero válido
    # grep -x = busca coincidencia exacta en toda la línea
    # "[0-9]\{1,\}" = expresión regular que busca uno o más dígitos
    # -z = verifica si la variable está vacía
    if ! echo "$numero" | grep -xq "[0-9]\{1,\}" || [ -z "$numero" ]; then
        echo "Error: Debe introducir un número entero válido."
        exit 1
    fi
    
    # vector[$i] = asigna el valor al elemento i del array
    vector[$i]=$numero
done

echo "=========================================="
echo "ANÁLISIS DEL VECTOR:"
echo "=========================================="

# 1. MOSTRAR VECTOR EN ORDEN INVERSO
echo "1. Vector en orden inverso:"
echo "=========================================="
# Bucle for que recorre el array de atrás hacia adelante
# i=9; i>=0; i-- = bucle inverso desde el último elemento
for ((i=9; i>=0; i--))
do
    # ${vector[$i]} = accede al elemento i del array
    echo -n "${vector[$i]} "
done
echo ""  # Salto de línea
echo ""

# 2. VALORES ORDENADOS DE MENOR A MAYOR
echo "2. Valores ordenados de menor a mayor:"
echo "=========================================="
# sort -n = ordena numéricamente
# ${vector[@]} = expande todos los elementos del array
# tr '\n' ' ' = reemplaza saltos de línea por espacios
echo "${vector[@]}" | tr ' ' '\n' | sort -n | tr '\n' ' '
echo ""  # Salto de línea
echo ""

# 3. VALORES ORDENADOS DE MAYOR A MENOR
echo "3. Valores ordenados de mayor a menor:"
echo "=========================================="
# sort -nr = ordena numéricamente en orden inverso (descendente)
echo "${vector[@]}" | tr ' ' '\n' | sort -nr | tr '\n' ' '
echo ""  # Salto de línea
echo ""

# 4. SUMA TOTAL DE VALORES
echo "4. Suma total de valores:"
echo "=========================================="
suma_total=0  # Variable para acumular la suma

# Bucle for para sumar todos los valores
for i in {0..9}
do
    # $((suma_total + vector[i])) = expansión aritmética para sumar
    suma_total=$((suma_total + vector[i]))
done

echo "Suma total: $suma_total"
echo ""

# 5. CANTIDAD DE VALORES PARES
echo "5. Cantidad de valores pares:"
echo "=========================================="
pares=0  # Contador de números pares

# Bucle for para contar números pares
for i in {0..9}
do
    # $((vector[i] % 2)) = resto de la división entre 2
    # -eq 0 = igual a 0 (número par)
    if [ $((vector[i] % 2)) -eq 0 ]; then
        # $((pares + 1)) = incrementa el contador
        pares=$((pares + 1))
    fi
done

echo "Cantidad de valores pares: $pares"
echo ""

# 6. SUMA TOTAL DE NÚMEROS IMPARES
echo "6. Suma total de números impares:"
echo "=========================================="
suma_impares=0  # Variable para acumular la suma de impares

# Bucle for para sumar números impares
for i in {0..9}
do
    # $((vector[i] % 2)) = resto de la división entre 2
    # -ne 0 = no igual a 0 (número impar)
    if [ $((vector[i] % 2)) -ne 0 ]; then
        # $((suma_impares + vector[i])) = suma el número impar
        suma_impares=$((suma_impares + vector[i]))
    fi
done

echo "Suma total de números impares: $suma_impares"
echo ""

# 7. MEDIA ARITMÉTICA
echo "7. Media aritmética:"
echo "=========================================="
# $((suma_total / 10)) = división entera para calcular la media
# En bash, la división es entera por defecto
media=$((suma_total / 10))
echo "Media aritmética: $media"
echo ""

# INFORMACIÓN ADICIONAL
echo "=========================================="
echo "INFORMACIÓN ADICIONAL:"
echo "=========================================="
echo "Vector original: ${vector[@]}"
echo "Total de elementos: ${#vector[@]}"
echo "=========================================="
