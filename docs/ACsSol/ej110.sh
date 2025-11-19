#!/bin/bash
# =============================================================================
# SCRIPT: ej110.sh - Suma de números del 1 al 1000 con diferentes bucles
# =============================================================================
# AC110. Crea un shell script que sume los números del 1 al 1000 mediante 
# una estructura for, while y until.
# =============================================================================

# PRESENTACIÓN DEL SCRIPT
echo "=========================================="
echo "SUMA DE NÚMEROS DEL 1 AL 1000"
echo "=========================================="

# INICIALIZACIÓN DE VARIABLES
suma=0  # Variable que acumula la suma total

# =============================================================================
# BUCLE FOR - Itera sobre una secuencia de valores
# =============================================================================
echo "1. BUCLE FOR:"
echo "=========================================="
suma=0  # Reiniciamos la suma para el bucle for

# for = bucle que itera sobre una secuencia de valores
# {1..1000} = expansión de llaves que genera números del 1 al 1000
for i in {1..1000}
do
	# $((suma + i)) = expansión aritmética para sumar
	suma=$((suma + i))
done

echo "Suma con bucle FOR: $suma"
echo ""

# =============================================================================
# BUCLE WHILE - Se ejecuta mientras la condición sea verdadera
# =============================================================================
echo "2. BUCLE WHILE:"
echo "=========================================="
suma=0  # Reiniciamos la suma para el bucle while
contador=1  # Variable contador que va del 1 al 1000

# while = bucle que se ejecuta mientras la condición sea verdadera
# [ $contador -le 1000 ] = contador es menor o igual a 1000
while [ $contador -le 1000 ]
do
	# $((suma + contador)) = expansión aritmética para sumar
	suma=$((suma + contador))
	# $((contador + 1)) = expansión aritmética para incrementar
	contador=$((contador + 1))
done

echo "Suma con bucle WHILE: $suma"
echo ""

# =============================================================================
# BUCLE UNTIL - Se ejecuta hasta que la condición sea verdadera
# =============================================================================
echo "3. BUCLE UNTIL:"
echo "=========================================="
suma=0  # Reiniciamos la suma para el bucle until
contador=1  # Variable contador que va del 1 al 1000

# until = bucle que se ejecuta hasta que la condición sea verdadera
# [ $contador -gt 1000 ] = contador es mayor que 1000
until [ $contador -gt 1000 ]
do
	# $((suma + contador)) = expansión aritmética para sumar
	suma=$((suma + contador))
	# $((contador + 1)) = expansión aritmética para incrementar
	contador=$((contador + 1))
done

echo "Suma con bucle UNTIL: $suma"
echo ""

# =============================================================================
# VERIFICACIÓN Y RESULTADO FINAL
# =============================================================================
echo "=========================================="
echo "RESULTADO FINAL:"
echo "=========================================="
echo "La suma de los números del 1 al 1000 es: $suma"
echo "Fórmula matemática: n(n+1)/2 = 1000(1001)/2 = 500500"
echo "=========================================="
