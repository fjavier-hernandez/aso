#!/bin/bash
# =============================================================================
# SCRIPT: ej107.sh - Usuarios conectados en el sistema
# =============================================================================
# AC107. Genera un script que muestre los usuarios conectados en el sistema operativo, 
# comprobando que son usuarios dados de alta en el mismo.
# =============================================================================

# PRESENTACIÓN DEL SCRIPT
echo "=========================================="
echo "USUARIOS CONECTADOS EN EL SISTEMA"
echo "=========================================="

# OBTENER USUARIOS CONECTADOS
# who = comando que muestra los usuarios conectados
# cut -d' ' -f1 = extrae solo la primera columna (nombre de usuario)
# sort = ordena los resultados alfabéticamente
# uniq = elimina duplicados
usuarios_conectados=$(who | cut -d' ' -f1 | sort | uniq)

# VERIFICAR SI HAY USUARIOS CONECTADOS
if [ -z "$usuarios_conectados" ]
then
    echo "No hay usuarios conectados en el sistema."
    exit 0
fi

# MOSTRAR USUARIOS CONECTADOS
echo "Usuarios conectados:"
echo "=========================================="

# BUCLE PARA VERIFICAR CADA USUARIO
# for = bucle que itera sobre cada usuario conectado
for usuario in $usuarios_conectados
do
    # VERIFICAR SI EL USUARIO EXISTE EN EL SISTEMA
    # id = comando que muestra información del usuario
    # 2>/dev/null = redirige errores a /dev/null (los suprime)
    if id "$usuario" >/dev/null 2>&1
    then
        # USUARIO VÁLIDO - Obtener información adicional
        # id -u = muestra el UID del usuario
        # id -g = muestra el GID del usuario
        uid=$(id -u "$usuario" 2>/dev/null)
        gid=$(id -g "$usuario" 2>/dev/null)
        
        echo "✓ $usuario (UID: $uid, GID: $gid) - Usuario válido"
    else
        # USUARIO NO VÁLIDO
        echo "✗ $usuario - Usuario no válido o no existe en el sistema"
    fi
done

echo "=========================================="

# INFORMACIÓN ADICIONAL
echo "INFORMACIÓN DETALLADA:"
echo "=========================================="

# MOSTRAR INFORMACIÓN COMPLETA DE CONEXIONES
echo "Conexiones activas:"
who

echo "=========================================="

# CONTAR USUARIOS CONECTADOS
total_usuarios=$(echo "$usuarios_conectados" | wc -l)
echo "Total de usuarios únicos conectados: $total_usuarios"

# MOSTRAR ESTADÍSTICAS DEL SISTEMA
echo "=========================================="
echo "ESTADÍSTICAS DEL SISTEMA:"
echo "=========================================="
echo "Fecha y hora actual: $(date)"
echo "Sistema operativo: $(uname -s)"
echo "Hostname: $(hostname)"
echo "=========================================="
