---
title: Soluciones - Examen ShellScript
description: Soluciones de referencia para el examen de ShellScript
subtitle: Soluciones Examen
---

# Soluciones del Examen ShellScript - ASO

Este documento contiene las soluciones de referencia para el examen de ShellScript.

---

## Ejercicio 1: Corrección de Código (10 puntos)

### Errores Identificados:

| Línea # | Error | Corrección |
|---------|-------|------------|
| 4 | **Falta espacio** en `if [$#` | Debe ser `if [ $# -eq 0 ]` |
| 6 | **Sin código de salida** en `exit` | Debe ser `exit 1` |
| 10 | **Falta comillas** en variable de grep | Debe ser `"$nombre_usuario"` |
| 11 | **Falta prueba adecuada** en `if [$resultado]` | Debe ser `if [ -n "$resultado" ]` |

**Total: 4 errores principales**

### Código Corregido:

```bash
#!/bin/bash

# Script para gestionar usuarios
nombre_usuario=$1

if [ $# -eq 0 ]; then
    echo "Debe proporcionar un nombre de usuario"
    exit 1
fi

buscar_usuario() {
    resultado=$(grep -i "$nombre_usuario" /etc/passwd)
    if [ -n "$resultado" ]; then
        echo "Usuario encontrado: $resultado"
        return 0
    else
        echo "Usuario no encontrado"
        return 1
    fi
}

# Función principal
buscar_usuario
```

### Explicaciones:

**Línea 4 - Error de sintaxis:**

- `if [$# -eq 0]` ❌ - Falta espacio después de `[`
- `if [ $# -eq 0 ]` ✅ - Espacio requerido en condiciones bash
- En bash, los corchetes `[ ]` son un comando que requiere espacios alrededor

**Línea 6 - Sin código de salida:**

- `exit` ❌ - No indica si fue error o éxito
- `exit 1` ✅ - Indica que salió con error (código de salida 1)
- La convención es usar `exit 0` para éxito y `exit 1` (o mayor) para error

**Línea 10 - Variable sin comillas:**

- `grep -i $nombre_usuario` ❌ - Si el nombre tiene espacios, fallará
- `grep -i "$nombre_usuario"` ✅ - Las comillas protegen el valor
- Siempre usa comillas en variables para evitar problemas con espacios especiales

**Línea 11 - Condición incorrecta:**

- `if [$resultado]` ❌ - No es una prueba válida
- `if [ -n "$resultado" ]` ✅ - `-n` prueba si la variable NO está vacía
- Forma correcta de verificar si grep encontró algo

---

## Ejercicio 2: Completar Código (12 puntos)

### Código Completo:

```bash
#!/bin/bash

# Declarar array de ciudades
declare -a ciudades=( "Madrid" )

# Función para mostrar menú
mostrar_menu() {
    echo "1) Añadir ciudad"
    echo "2) Listar ciudades"
    echo "3) Buscar ciudad"
    echo "4) Salir"
}

# Función para añadir ciudad
añadir_ciudad() {
    read -p "Introduce el nombre de la ciudad: " nueva_ciudad
    ciudades[${#ciudades[@]}]="$nueva_ciudad"
    echo "Ciudad añadida correctamente"
}

# Función para listar ciudades
listar_ciudades() {
    echo "Listado de ciudades:"
    for i in {0..$((${#ciudades[@]}-1))}; do
        echo "$i) ciudad ${ciudades[$i]}"
    done
}

# Función para buscar ciudad
buscar_ciudad() {
    read -p "Introduce el término de búsqueda: " termino
    for ciudad in "${ciudades[@]}"; do
        if [[ "$ciudad" == *"$termino"* ]]; then
            echo "Ciudad encontrada: $ciudad"
        fi
    done
}

# Menú principal
while true; do
    clear
    mostrar_menu
    read -p "Selecciona una opción: " opcion
    
    case $opcion in
        1) añadir_ciudad ;;
        2) listar_ciudades ;;
        3) buscar_ciudad ;;
        4) break ;;
        *) echo "Opción inválida" ;;
    esac
done
```

---

## Ejercicio 3: Trazar Ejecución (8 puntos)

### Tabla Completada:

| Línea | Valor de `i` | Valor de `${ciudades[$i]}` | Salida del `case` | Total ciudades |
|-------|-------------|----------------------------|-------------------|----------------|
| 5     | 0           | Madrid                     | Capital de España | 3              |
| 11    | 1           | Barcelona                  | Capital de Cataluña | 3              |
| 6     | 2           | Valencia                   | Otra ciudad       | 3              |
| 13    | -           | -                          | -                 | 3              |

### Explicación del Trazado:

1. **Iteración 0**: `ciudades[0]` = "Madrid" → caso "Madrid" → "Capital de España"
2. **Iteración 1**: `ciudades[1]` = "Barcelona" → caso "Barcelona" → "Capital de Cataluña"
3. **Iteración 2**: `ciudades[2]` = "Valencia" → caso por defecto `*)` → "Otra ciudad"
4. **Final**: `${#ciudades[@]}` devuelve el número de elementos del array (3)

---

## Ejercicio 4: Debug y Explicar (10 puntos)

### Respuestas:

**1. ¿Qué hace `clear` y por qué se usa aquí?**
- `clear` limpia la pantalla del terminal
- Se usa para limpiar la pantalla cada vez que se muestra el menú, manteniendo una interfaz limpia y legible

**2. Explica la diferencia entre `$opcion` y `"$opcion"` en el case**
- `$opcion` expande la variable sin protección de espacios (si hay espacios, se interpretan como argumentos separados)
- `"$opcion"` protege el valor completo de la variable entre comillas
- En el `case`, ambos funcionan igual para valores simples, pero `"$opcion"` es más seguro

**3. ¿Qué hace el operador `-f` en la línea `[ -f "servidores.txt" ]`?**
- `-f` verifica si el archivo existe y es un archivo regular (no directorio)
- Retorna verdadero si `servidores.txt` existe y es un archivo
- Retorna falso si no existe, es un directorio, o hay algún problema de permisos

**4. Explica qué hace `wc -l < servidores.txt` y por qué se usa `<` en lugar de `|`**
- `wc -l` cuenta las líneas de un archivo
- `<` redirecciona el archivo como entrada al comando `wc`
- Se usa `<` para pasar el archivo directamente como entrada
- Funcionalmente es similar a `cat servidores.txt | wc -l` pero más directo
- `<` es más eficiente porque conecta directamente el archivo con el comando, sin necesidad de leer el archivo primero con `cat` y luego pasarlo por tubería

**5. ¿Para qué sirve `read -p` al final de la función?**
- `read -p` pausa la ejecución del script esperando que el usuario presione Enter
- Permite al usuario leer la información antes de continuar
- Mejora la experiencia de usuario dando tiempo para leer el resultado

---

## Ejercicio 5: Implementar Función (10 puntos)

### Función `buscar_servidor()`:

```bash
function buscar_servidor() {
    echo "=========================================="
    echo "    BUSCAR SERVIDOR"
    echo "=========================================="
    echo ""
    
    read -p "Introduce el término de búsqueda: " termino
    
    if [ -f "servidores.txt" ]; then
        resultado=$(grep -i "$termino" servidores.txt)
        
        if [ -n "$resultado" ]; then
            echo ""
            echo "Resultados encontrados:"
            echo "======================"
            echo "$resultado"
            
            # Contar resultados
            total=$(echo "$resultado" | wc -l)
            echo ""
            echo "Total de resultados encontrados: $total"
        else
            echo ""
            echo "No se encontraron servidores con el término '$termino'"
        fi
    else
        echo "No se encontró el archivo de servidores."
    fi
    
    read -p "Presiona Enter para continuar..."
}
```

### Explicación:

- Validación del archivo con `[ -f ]`
- Búsqueda case-insensitive con `grep -i`
- Verificación de resultados con `[ -n ]`
- Conteo de resultados con `wc -l`
- Mensajes informativos para el usuario
- Pausa al final para lectura

---

## Ejercicio 6: Analizar Sistema de Backups (10 puntos)

### Respuestas Teóricas:

**1. ¿Qué formato de fecha genera `date +%Y%m%d_%H%M%S`?**
- Formato: `YYYYMMDD_HHMMSS`
- Ejemplo: `20241222_143055` (22 de diciembre de 2024, 14:30:55)

**2. ¿Qué hace `-czf` en el comando `tar`?**
- `-c`: Crea un nuevo archivo
- `-z`: Comprime con gzip
- `-f`: Especifica el nombre del archivo

**3. ¿Para qué sirve `2>/dev/null`?**
- Redirecciona la salida de error (stderr) a `/dev/null`
- Oculta los mensajes de error del comando
- `/dev/null` es un "agujero negro" que descarta todo lo que recibe

**4. ¿Qué hace `cut -f1` en `du -h "backups/$nombre_backup" | cut -f1`?**
- `cut -f1` extrae el primer campo (columna) de la salida
- `du -h` muestra dos columnas: tamaño y ruta
- `cut -f1` extrae solo la columna del tamaño (primera columna)
- Resultado: solo el tamaño en formato legible (ej: "1.2M")

**5. Explica la diferencia entre `>>` y `>`:**
- `>>`: Añade al final del archivo (append), no sobrescribe el contenido existente
- `>`: Sobrescribe el archivo completo, eliminando todo el contenido previo

### Función `restaurar_backup()`:

```bash
function restaurar_backup() {
    echo "Backups disponibles:"
    ls -la backups/
    
    read -p "Nombre del backup: " backup_restaurar
    
    if [ -f "backups/$backup_restaurar" ]; then
        tar -xzf backups/$backup_restaurar
        echo "Backup restaurado"
    else
        echo "Backup no encontrado"
    fi
}
```

### Explicación:

- Lista los backups disponibles con `ls -la`
- Solicita el nombre del backup a restaurar
- Valida que el archivo existe con `[ -f ]`
- Extrae con `tar -xzf` (x=extraer, z=gzip, f=archivo)
- Muestra mensaje de confirmación o error

---

## Criterios de Corrección Sugeridos

### Ejercicio 1 (10 pts)
- Lista de 10 errores correctos: 5 puntos
- Código corregido sin errores: 3 puntos
- Explicaciones claras: 2 puntos

### Ejercicio 2 (12 pts)
- Sintaxis correcta: 4 puntos
- Arrays y bucles: 3 puntos
- Estructuras de control: 3 puntos
- Funcionalidad completa: 2 puntos

### Ejercicio 3 (8 pts)
- Valores de array correctos: 4 puntos
- Comprensión del case: 2 puntos
- Resultado final correcto: 2 puntos

### Ejercicio 4 (10 pts)
- 5 respuestas técnicas correctas: 6 puntos (1.2 pt cada una)
- Comprensión conceptual: 4 puntos

### Ejercicio 5 (10 pts)
- Estructura correcta de función: 2 puntos
- Búsqueda con grep funcional: 2 puntos
- Manejo de resultados: 3 puntos
- Validaciones adecuadas: 3 puntos

### Ejercicio 6 (10 pts)
- 5 respuestas teóricas: 4 puntos
- Función `restaurar_backup` correcta: 6 puntos

---

## Notas para el Corrector

### Diferencias Aceptables

Algunas variantes de código son aceptables:

- `read -p` vs `read -r -p` (ambos válidos)
- `grep -i` vs `grep` (con o sin case-insensitive)
- Uso de `echo ""` vs simplemente `echo` para espacio en blanco
- Variantes en nombres de variables (siempre que sean consistentes)

### Errores Comunes

Errores típicos a penalizar:

- Falta de comillas en variables
- Espacios incorrectos en condiciones `[`
- Confusión entre `return` y `exit`
- Redirecciones incorrectas (`>` vs `>>`)
- Sintaxis incorrecta de arrays
- Falta de validaciones de archivos

### Puntuación Adicional

- **Buena estructura**: +1 punto si el código está bien organizado
- **Comentarios útiles**: +1 punto si hay comentarios claros
- **Manejo de errores robusto**: +1 punto si incluye validaciones extra

---

**Fin del documento de soluciones**

