#!/bin/bash
# =============================================================================
# SCRIPT: ej102.sh - Listado de archivos y directorios de /etc
# =============================================================================
# AC102. Realiza un script que guarde en un fichero el listado de archivos y directorios de la carpeta etc y, posteriormente,
# imprima por pantalla dicho listado.
# =============================================================================

# PROCESAMIENTO PRINCIPAL SEGÚN EL ENUNCIADO
# Definimos el nombre del archivo donde guardar el listado
archivo="listado_etc.txt"

# PASO 1: GUARDAR LISTADO DE /etc EN ARCHIVO
# ls -la /etc = lista todos los archivos y directorios de /etc con detalles
# -l = formato largo (permisos, tamaño, fecha, etc.)
# -a = incluye archivos ocultos (que empiezan con punto)
# > $archivo = redirección de salida que guarda el resultado en el archivo especificado
ls -la /etc > $archivo

# PASO 2: IMPRIMIR EL LISTADO POR PANTALLA
# cat $archivo = muestra el contenido del archivo en pantalla
echo "Listado de archivos y directorios de /etc guardado en: $archivo"
echo "Contenido del archivo:"
echo "=========================================="
cat $archivo

# COMENTARIOS ADICIONALES:
# - El comando ls -la /etc lista todos los archivos y directorios
# - La redirección > guarda la salida en el archivo especificado
# - El comando cat muestra el contenido del archivo por pantalla