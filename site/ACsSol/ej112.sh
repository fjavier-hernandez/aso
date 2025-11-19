#!/bin/bash
# =============================================================================
# SCRIPT: ej112.sh - Vector con valores aleatorios
# =============================================================================
# AC112. Crea un script que rellene un vector con cien valores aleatorios 
# y muestre en pantalla en una sola línea los valores generados.
# =============================================================================

# PRESENTACIÓN DEL SCRIPT
echo "=========================================="
echo "VECTOR CON VALORES ALEATORIOS"
echo "=========================================="

# DECLARACIÓN DEL VECTOR
# En bash, los arrays se declaran con paréntesis
# vector=() = declara un array vacío
vector=()

# RELLENAR EL VECTOR CON 100 VALORES ALEATORIOS
echo "Generando 100 valores aleatorios entre 1 y 1000..."
echo "=========================================="

# Bucle for para generar 100 números aleatorios
# {0..99} = genera números del 0 al 99 (100 elementos)
for i in {0..99}
do
    # $RANDOM = variable especial de bash que genera números aleatorios
    # % 1000 = operador módulo para limitar el rango (0-999)
    # + 1 = suma 1 para obtener rango 1-1000
    # vector[$i] = asigna el valor al elemento i del array
    vector[$i]=$((RANDOM % 1000 + 1))
done

# MOSTRAR LOS VALORES EN UNA SOLA LÍNEA
echo "Valores generados (en una sola línea):"
echo "=========================================="

# Mostrar todos los valores del vector en una sola línea
# ${vector[@]} = expande todos los elementos del array
# tr '\n' ' ' = reemplaza saltos de línea por espacios
echo "${vector[@]}" | tr '\n' ' '

# Agregar un salto de línea al final
echo ""

echo "=========================================="
echo "Total de valores generados: ${#vector[@]}"
echo "=========================================="

# INFORMACIÓN ADICIONAL: Mostrar algunos valores específicos
echo "INFORMACIÓN ADICIONAL:"
echo "=========================================="
echo "Primer valor: ${vector[0]}"
echo "Último valor: ${vector[99]}"
echo "Valor en posición 50: ${vector[50]}"
echo "=========================================="

