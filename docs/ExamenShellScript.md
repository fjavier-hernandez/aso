---
title: Examen ShellScript - ASO
description: Examen de evaluación de ShellScript para ASO
subtitle: Examen ShellScript
---

# Examen ShellScript - ASO

**Curso:** Administración de Sistemas Operativos  
**Módulo:** ShellScript  
**Duración:** 2 horas  
**Puntuación total:** 60 puntos  
<!-- **Fecha:** _______________ -->

---

## Instrucciones Generales

- **Tiempo:** 2 horas (120 minutos)
- **Puntuación:** 60 puntos total
- **Formato:** Resolver los ejercicios creando scripts en ShellScript
- **Entrega:** Crear un directorio `examen_[nombre]_[apellidos]` con todos los scripts
- **Nomenclatura:** Los scripts deben llamarse `ejercicio1.sh`, `ejercicio2.sh`, etc.
- **Documentación:** Cada script debe incluir comentarios explicativos
- **Pruebas:** Verificar que todos los scripts funcionan correctamente

### Recursos Permitidos

!!! warning "Recursos Permitidos"
    Durante el examen **SOLO** se permite utilizar:
    
    - **Apuntes del tema** [ShellScript](01ShellScript.md)
    - **Aules** (plataforma educativa)
    - **Terminal de bash de LliureX** (para probar los scripts)
    - "***cheat sheet***" propia.
    
    **NO se permite:**

    - Internet (excepto para acceder a Aules)
    - Documentación externa
    - Ayuda de compañeros
    - Dispositivos móviles
    - Cualquier otro recurso no autorizado

## Instrucciones de Entrega

1. **Crear directorio:** `examen_[nombre]_[apellidos]`
2. **Incluir:**

   - Archivo PDF con las respuestas de y explicaciones de los ejercicios 1-6 (según se solicita en cada ejercicio).
   - Scripts completos de los ejercicios 5 y 6 (implementación).

3. **Comprimir en ZIP** el directorio completo
4. **Subir al Moodle** antes del tiempo límite

---

## Ejercicio 1: Corrección de Código (10 puntos)

El siguiente script tiene **varios errores**. Identifica y corrige los errores:

```bash
#!/bin/bash

# Script para gestionar usuarios
nombre_usuario=$1
if [$# -eq 0]
    echo "Debe proporcionar un nombre de usuario"
    exit
fi

buscar_usuario() {
    resultado=$(grep -i $nombre_usuario /etc/passwd)
    if [$resultado]
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

**Tareas:**

1. Identifica los **errores** en el código
2. Escribe el código **corregido** completo
3. Explica brevemente cada corrección realizada

**Criterios de evaluación:**

- Identificación correcta de errores (4 puntos)
- Código corregido funcional (4 puntos)
- Explicaciones claras (2 puntos)

---

## Ejercicio 2: Completar Código (12 puntos)

Completa el script para gestionar una lista de ciudades mediante **Arrays**. Faltan las partes marcadas con `____`:

```bash
#!/bin/bash

# Declarar array de ciudades
____ ciudades=( ____ )

# Función para mostrar menú
mostrar_menu() {
    ____ "1) Añadir ciudad"
    ____ "2) Listar ciudades"
    ____ "3) Buscar ciudad"
    ____ "4) Salir"
}

# Función para añadir ciudad
añadir_ciudad() {
    ____ -p "Introduce el nombre de la ciudad: " nueva_ciudad
    ciudades[____]="$nueva_ciudad"
    ____ "Ciudad añadida correctamente"
}

# Función para listar ciudades
listar_ciudades() {
    ____ "Listado de ciudades:"
    ____ i ____ {0..$____[____]}; do
        ____ "$____ ciudad ${ciudades[$i]}"
    ____
}

# Función para buscar ciudad
buscar_ciudad() {
    ____ -p "Introduce el término de búsqueda: " termino
    ____ ciudad ____ ciudades[@]; ____
        ____ [[ "$ciudad" == *"$termino"* ]]; then
            ____ "Ciudad encontrada: $ciudad"
        ____
    ____
}

# Menú principal
while ____; do
    ____
    mostrar_menu
    ____ -p "Selecciona una opción: " opcion
    
    ____ $opcion ____
        1) añadir_ciudad ;;
        2) ____ ;;____
        3) buscar_ciudad ;;
        4) ____ ;;
        ____) ____ "Opción inválida" ;;
    ____
done
```

**Criterios de evaluación:**

- Sintaxis correcta (4 puntos)
- Lógica de arrays (3 puntos)
- Estructuras de control (3 puntos)
- Funcionalidad completa (2 puntos)

---

## Ejercicio 3: Trazar Ejecución (8 puntos)

**Analiza el siguiente script y completa la tabla de trazado:**

```bash
#!/bin/bash

ciudades=("Madrid" "Barcelona" "Valencia")

for i in {0..2}; do
    echo "Ciudad $i: ${ciudades[$i]}"
    
    case ${ciudades[$i]} in
        "Madrid")
            echo "Capital de España"
            ;;
        "Barcelona")
            echo "Capital de Cataluña"
            ;;
        *)
            echo "Otra ciudad"
            ;;
    esac
done

echo "Total de ciudades: ${#ciudades[@]}"
```

**Salida esperada:**

| Línea | Valor de `i` | Valor de `${ciudades[$i]}` | Salida del `case` | Total ciudades |
|-------|-------------|----------------------------|-------------------|----------------|
| 5     | 0           | __________                 | __________        | ______________ |
| 11    | 1           | __________                 | __________        | ______________ |
| 6     | 2           | __________                 | __________        | ______________ |
| 13    | -           | -                          | -                 | __________     |

**Criterios de evaluación:**

- Trazado correcto de variables (4 puntos)
- Comprensión del case (2 puntos)
- Salida correcta (2 puntos)

---

## Ejercicio 4: Debug y Explicar (10 puntos)

**Analiza este código del módulo de gestión de servidores:**

```bash
function gestionar_servidores() {
    while true; do
        clear
        
        # Mostrar opciones
        echo "1) Listar servidores"
        echo "2) Añadir servidor"
        echo "3) Buscar servidor"
        echo "4) Salir"
        
        read -p "Selecciona opción: " opcion
        
        case $opcion in
            1) listar_servidores ;;
            2) añadir_servidor ;;
            3) buscar_servidor ;;
            4) break ;;
            *) echo "Opción inválida" ;;
        esac
    done
}

function listar_servidores() {
    if [ -f "servidores.txt" ]; then
        cat -n servidores.txt
        echo "Total: $(wc -l < servidores.txt)"
    else
        echo "Archivo no encontrado"
    fi
    read -p "Presiona Enter para continuar..."
}
```

**Preguntas:**

1. ¿Qué hace `clear` y por qué se usa aquí?
2. Explica la diferencia entre `$opcion` y `"$opcion"` en el case
3. ¿Qué hace el operador `-f` en la línea `[ -f "servidores.txt" ]`?
4. Explica qué hace `wc -l < servidores.txt` y por qué se usa `<` en lugar de `|`
5. ¿Para qué sirve `read -p` al final de la función?

**Criterios de evaluación:**

- Respuestas técnicas correctas (6 puntos)
- Comprensión conceptual (4 puntos)

---

## Ejercicio 5: Implementar Función (10 puntos)

**Implementa la función `buscar_servidor()` que:**

1. Pida al usuario un término de búsqueda
2. Busque en el archivo `servidores.txt` (formato: `nombre|ip|puerto|servicio`)
3. Si encuentra resultados:

   - Muestre todas las líneas que contengan el término
   - Muestre cuántos resultados se encontraron

4. Si no encuentra resultados:
   - Muestre un mensaje informativo
5. Al final, pida presionar Enter para continuar

```bash
function buscar_servidor() {
    ____ "=========================================="
    ____ "    BUSCAR SERVIDOR"
    ____ "=========================================="
    ____ ""
    
    # Tu código aquí
    # ______________
    
    ____ -p "Presiona Enter para continuar..."
}
```

**Criterios de evaluación:**

- Estructura de función correcta (2 puntos)
- Búsqueda con grep (2 puntos)
- Manejo de resultados (3 puntos)
- Validaciones adecuadas (3 puntos)

---

## Ejercicio 6: Analizar Sistema de Backups (10 puntos)

**Lee este código del módulo de backups:**

```bash
crear_backup() {
    fecha=$(date +%Y%m%d_%H%M%S)
    nombre_backup="backup_servidores_$fecha.tar.gz"
    
    tar -czf "backups/$nombre_backup" servidores.txt configuracion.conf logs/ 2>/dev/null
    
    if [ -f "backups/$nombre_backup" ]; then
        tamaño=$(du -h "backups/$nombre_backup" | cut -f1)
        echo "Backup creado: $nombre_backup ($tamaño)"
        echo "$(date): Backup creado" >> logs/sistema.log
    else
        echo "Error al crear backup"
    fi
}
```

**Preguntas teórico-prácticas:**

1. ¿Qué formato de fecha genera `date +%Y%m%d_%H%M%S`? P.ej.: __________
2. ¿Qué hace `-czf` en el comando `tar`?
3. ¿Para qué sirve `2>/dev/null`?
4. ¿Qué hace `cut -f1` en `du -h "backups/$nombre_backup" | cut -f1`?
5. Explica la diferencia entre `>>` y `>`:

   - `>>` : __________
   - `>` : __________

**Implementa la función `restaurar_backup()`:**

```bash
function restaurar_backup() {
    ____ "Backups disponibles:"
    ____ -la backups/
    
    ____ -p "Nombre del backup: " backup_restaurar
    
    if [ ____ "backups/$backup_restaurar" ]; then
        tar -____ backups/$backup_restaurar
        ____ "Backup restaurado"
    else
        ____ "Backup no encontrado"
    fi
}
```

**Criterios de evaluación:**

- Respuestas teóricas correctas (4 puntos)
- Función implementada correctamente (6 puntos)

---

## Criterios de Evaluación General

### Comprensión Técnica (40 puntos)

- **Ejercicio 1 (Corrección):** 10 puntos
- **Ejercicio 2 (Completar):** 12 puntos  
- **Ejercicio 3 (Trazar):** 8 puntos
- **Ejercicio 4 (Debug):** 10 puntos

### Aplicación Práctica (20 puntos)

- **Ejercicio 5 (Implementar):** 10 puntos
- **Ejercicio 6 (Analizar):** 10 puntos

### Total: 60 puntos

---

<!-- 

---

## Estructura de Respuestas

Para cada ejercicio, sigue esta estructura:

### **Ejercicio 1 (Corrección):**

- Lista de errores identificados
- Código completo corregido
- Explicaciones breves

### **Ejercicio 2 (Completar):**

- Código completo con los espacios rellenados
- Sin comentarios adicionales, solo el código

### **Ejercicio 3 (Trazar):**

- Tabla completada con valores
- Resultado final esperado

### **Ejercicio 4 (Debug):**

- Respuestas a las 5 preguntas
- Cada respuesta en una línea

### **Ejercicio 5 (Implementar):**

- Función `buscar_servidor()` completa
- Sin bloque principal (solo la función)

### **Ejercicio 6 (Analizar):**

- Respuestas a las 5 preguntas teóricas
- Función `restaurar_backup()` completa

---

## Notas Importantes

- **Recursos:** Solo puedes usar los apuntes, Aules y el terminal de LliureX
- **Tiempo:** Gestiona bien el tiempo (10 minutos por ejercicio aprox.)
- **Comprensión:** Lee cada ejercicio con atención antes de responder
- **Trazado:** En el ejercicio de trazado, muestra tu razonamiento paso a paso
- **Correcciones:** En el ejercicio de corrección, explica por qué cada error ocurre
- **Implementación:** Los ejercicios 5 y 6 deben ser scripts funcionales probados
- **Integridad:** El uso de recursos no autorizados supondrá la anulación del examen -->

<!-- --- -->

**¡Buena suerte!**
