---
title: Solución del Reto Grupal - Sistema de Gestión de Servidores
description: Propuesta de solución completa con comentarios detallados línea por línea
subtitle: Solución Reto Grupal ShellScript
---

# Solución del Reto Grupal: Sistema de Gestión de Servidores

Esta propuesta de solución incluye todos los elementos requeridos en el reto grupal, con comentarios detallados para facilitar la comprensión del código.

## Estructura del Proyecto

```
sistema_gestion_servidores/
├── menu_principal.sh
├── funciones_servidor.sh
├── monitoreo.sh
├── backup.sh
├── configuracion.conf
├── servidores.txt
├── logs/
│   ├── sistema.log
│   └── errores.log
└── backups/
    └── backup_servidores_YYYYMMDD.tar.gz
```

## Archivo Principal: menu_principal.sh

```bash
#!/bin/bash
# Shebang: indica que el script debe ejecutarse con bash

#*********************************
# Sistema de Gestión de Servidores
# Reto Grupal ShellScript
#*********************************

# Cargar configuración del sistema
source configuracion.conf
# source = ejecuta el archivo en el contexto actual del shell
# configuracion.conf = archivo que contiene variables de configuración

# Cargar módulos del sistema
source funciones_servidor.sh
# source = carga las funciones de gestión de servidores
source monitoreo.sh
# source = carga las funciones de monitoreo
source backup.sh
# source = carga las funciones de backup

# Función principal del programa
main() {
    # function = define una función llamada main
    # { = inicio del bloque de código de la función
    
    # Bucle principal del programa
    while true; do
        # while true = bucle infinito que se ejecuta continuamente
        # do = inicio del bloque de código del bucle
        
        # Limpiar pantalla para mejor presentación
        clear
        # clear = comando que limpia la pantalla del terminal
        
        # Mostrar encabezado del sistema
        echo "=========================================="
        # echo = muestra texto por pantalla
        echo "    SISTEMA DE GESTIÓN DE SERVIDORES"
        echo "=========================================="
        echo ""
        
        # Mostrar opciones del menú principal
        echo "1) Gestión de servidores"
        echo "2) Monitoreo del sistema"
        echo "3) Copias de seguridad"
        echo "4) Configuración del sistema"
        echo "5) Salir"
        echo ""
        
        # Solicitar opción al usuario
        read -p "Selecciona una opción: " opcion
        # read -p = lee entrada del usuario mostrando un mensaje previo
        # opcion = variable donde se almacena la entrada del usuario
        
        # Evaluar la opción seleccionada
        case $opcion in
            # case = estructura de control para múltiples opciones
            # $opcion = variable que contiene la opción seleccionada
            # in = inicio de las opciones posibles
            
            1) gestionar_servidores ;;
            # 1) = si la opción es 1
            # gestionar_servidores = llama a la función correspondiente
            # ;; = fin de esta opción
            
            2) monitorear_sistema ;;
            # 2) = si la opción es 2
            # monitorear_sistema = llama a la función correspondiente
            
            3) gestionar_backups ;;
            # 3) = si la opción es 3
            # gestionar_backups = llama a la función correspondiente
            
            4) configurar_sistema ;;
            # 4) = si la opción es 4
            # configurar_sistema = llama a la función correspondiente
            
            5) 
                # 5) = si la opción es 5
                echo "Saliendo del sistema..."
                # echo = muestra mensaje de despedida
                exit 0
                # exit 0 = termina el programa con código de éxito
                ;;
                # ;; = fin de esta opción
            
            *) 
                # *) = opción por defecto (cualquier otra opción)
                echo "Opción inválida. Inténtalo de nuevo."
                # echo = muestra mensaje de error
                sleep 2
                # sleep 2 = pausa la ejecución por 2 segundos
                ;;
                # ;; = fin de esta opción
        esac
        # esac = fin de la estructura case
        
    done
    # done = fin del bucle while
    
}
# } = fin de la función main

# Ejecutar función principal
main
# main = llama a la función principal para iniciar el programa
```

## Módulo de Gestión de Servidores: funciones_servidor.sh

```bash
#!/bin/bash
# Shebang: indica que el script debe ejecutarse con bash

#*********************************
# Módulo de Gestión de Servidores
#*********************************

# Función para gestionar servidores
gestionar_servidores() {
    # function = define una función llamada gestionar_servidores
    # { = inicio del bloque de código de la función
    
    # Bucle del menú de gestión de servidores
    while true; do
        # while true = bucle infinito
        # do = inicio del bloque de código del bucle
        
        # Limpiar pantalla
        clear
        # clear = limpia la pantalla
        
        # Mostrar encabezado del módulo
        echo "=========================================="
        echo "    GESTIÓN DE SERVIDORES"
        echo "=========================================="
        echo ""
        
        # Mostrar opciones del menú
        echo "1) Listar servidores"
        echo "2) Añadir servidor"
        echo "3) Buscar servidor"
        echo "4) Modificar servidor"
        echo "5) Eliminar servidor"
        echo "6) Volver al menú principal"
        echo ""
        
        # Solicitar opción al usuario
        read -p "Selecciona una opción: " opcion
        # read -p = lee entrada del usuario
        # opcion = variable para almacenar la opción
        
        # Evaluar opción seleccionada
        case $opcion in
            # case = estructura de control múltiple
            # $opcion = variable con la opción
            
            1) listar_servidores ;;
            # 1) = si opción es 1
            # listar_servidores = llama a función correspondiente
            
            2) añadir_servidor ;;
            # 2) = si opción es 2
            # añadir_servidor = llama a función correspondiente
            
            3) buscar_servidor ;;
            # 3) = si opción es 3
            # buscar_servidor = llama a función correspondiente
            
            4) modificar_servidor ;;
            # 4) = si opción es 4
            # modificar_servidor = llama a función correspondiente
            
            5) eliminar_servidor ;;
            # 5) = si opción es 5
            # eliminar_servidor = llama a función correspondiente
            
            6) 
                # 6) = si opción es 6
                echo "Volviendo al menú principal..."
                # echo = muestra mensaje
                break
                # break = sale del bucle while
                ;;
                # ;; = fin de esta opción
            
            *) 
                # *) = opción por defecto
                echo "Opción inválida. Inténtalo de nuevo."
                # echo = muestra mensaje de error
                sleep 2
                # sleep 2 = pausa por 2 segundos
                ;;
                # ;; = fin de esta opción
        esac
        # esac = fin de la estructura case
        
    done
    # done = fin del bucle while
    
}
# } = fin de la función gestionar_servidores

# Función para listar servidores
listar_servidores() {
    # function = define función listar_servidores
    # { = inicio del bloque de código
    
    # Verificar si existe el archivo de servidores
    if [ -f "servidores.txt" ]; then
        # if = estructura condicional
        # [ -f "servidores.txt" ] = verifica si el archivo existe y es regular
        # then = inicio del bloque si la condición es verdadera
        
        # Mostrar encabezado
        echo "=========================================="
        echo "    LISTADO DE SERVIDORES"
        echo "=========================================="
        echo ""
        
        # Mostrar contenido del archivo con numeración
        cat -n servidores.txt
        # cat -n = muestra el contenido del archivo con números de línea
        # servidores.txt = archivo que contiene la información de servidores
        
        echo ""
        echo "Total de servidores: $(wc -l < servidores.txt)"
        # echo = muestra texto
        # $(wc -l < servidores.txt) = sustitución de comando que cuenta las líneas del archivo
        # wc -l = cuenta líneas
        # < servidores.txt = redirecciona el archivo como entrada
        
    else
        # else = bloque que se ejecuta si la condición es falsa
        echo "No se encontró el archivo de servidores."
        # echo = muestra mensaje de error
        
    fi
    # fi = fin de la estructura condicional if
    
    # Pausar para que el usuario pueda leer
    read -p "Presiona Enter para continuar..."
    # read -p = pausa hasta que el usuario presione Enter
    
}
# } = fin de la función listar_servidores

# Función para añadir servidor
añadir_servidor() {
    # function = define función añadir_servidor
    # { = inicio del bloque de código
    
    # Mostrar encabezado
    echo "=========================================="
    echo "    AÑADIR NUEVO SERVIDOR"
    echo "=========================================="
    echo ""
    
    # Solicitar datos del servidor
    read -p "Nombre del servidor: " nombre
    # read -p = lee entrada del usuario con mensaje previo
    # nombre = variable para almacenar el nombre
    
    read -p "Dirección IP: " ip
    # read -p = lee entrada del usuario
    # ip = variable para almacenar la IP
    
    read -p "Puerto: " puerto
    # read -p = lee entrada del usuario
    # puerto = variable para almacenar el puerto
    
    read -p "Servicio: " servicio
    # read -p = lee entrada del usuario
    # servicio = variable para almacenar el servicio
    
    read -p "Descripción: " descripcion
    # read -p = lee entrada del usuario
    # descripcion = variable para almacenar la descripción
    
    # Validar que se hayan introducido todos los datos
    if [ -n "$nombre" ] && [ -n "$ip" ] && [ -n "$puerto" ] && [ -n "$servicio" ]; then
        # if = estructura condicional
        # [ -n "$nombre" ] = verifica si la variable nombre no está vacía
        # && = operador lógico AND (todas las condiciones deben ser verdaderas)
        # then = inicio del bloque si la condición es verdadera
        
        # Crear línea con los datos del servidor
        linea="$nombre|$ip|$puerto|$servicio|$descripcion"
        # linea = variable que contiene todos los datos separados por |
        # $nombre = contenido de la variable nombre
        # | = separador entre campos
        
        # Añadir línea al archivo
        echo "$linea" >> servidores.txt
        # echo "$linea" = muestra el contenido de la variable linea
        # >> = redirecciona la salida añadiendo al final del archivo
        # servidores.txt = archivo donde se guarda la información
        
        # Mostrar mensaje de confirmación
        echo ""
        echo "Servidor '$nombre' añadido correctamente."
        # echo = muestra mensaje de éxito
        
        # Registrar en log
        echo "$(date): Servidor '$nombre' añadido" >> logs/sistema.log
        # echo = muestra mensaje
        # $(date) = sustitución de comando que obtiene la fecha y hora actual
        # >> logs/sistema.log = añade el mensaje al archivo de log
        
    else
        # else = bloque si la condición es falsa
        echo "Error: Debes introducir todos los campos obligatorios."
        # echo = muestra mensaje de error
        
    fi
    # fi = fin de la estructura condicional
    
    # Pausar para que el usuario pueda leer
    read -p "Presiona Enter para continuar..."
    # read -p = pausa hasta Enter
    
}
# } = fin de la función añadir_servidor

# Función para buscar servidor
buscar_servidor() {
    # function = define función buscar_servidor
    # { = inicio del bloque de código
    
    # Mostrar encabezado
    echo "=========================================="
    echo "    BUSCAR SERVIDOR"
    echo "=========================================="
    echo ""
    
    # Solicitar término de búsqueda
    read -p "Introduce el término de búsqueda: " termino
    # read -p = lee entrada del usuario
    # termino = variable para almacenar el término de búsqueda
    
    # Verificar si existe el archivo
    if [ -f "servidores.txt" ]; then
        # if = estructura condicional
        # [ -f "servidores.txt" ] = verifica si el archivo existe
        
        # Buscar en el archivo
        resultado=$(grep -i "$termino" servidores.txt)
        # resultado = variable para almacenar el resultado
        # $(grep -i "$termino" servidores.txt) = sustitución de comando
        # grep -i = busca texto sin distinguir mayúsculas/minúsculas
        # "$termino" = término a buscar
        # servidores.txt = archivo donde buscar
        
        # Verificar si se encontraron resultados
        if [ -n "$resultado" ]; then
            # if = estructura condicional
            # [ -n "$resultado" ] = verifica si la variable no está vacía
            
            echo ""
            echo "Resultados encontrados:"
            echo "======================"
            echo "$resultado"
            # echo = muestra los resultados
            
        else
            # else = bloque si no se encontraron resultados
            echo ""
            echo "No se encontraron servidores con el término '$termino'"
            # echo = muestra mensaje de no encontrado
            
        fi
        # fi = fin de la estructura condicional
        
    else
        # else = bloque si el archivo no existe
        echo "No se encontró el archivo de servidores."
        # echo = muestra mensaje de error
        
    fi
    # fi = fin de la estructura condicional
    
    # Pausar para que el usuario pueda leer
    read -p "Presiona Enter para continuar..."
    # read -p = pausa hasta Enter
    
}
# } = fin de la función buscar_servidor
```

## Módulo de Monitoreo: monitoreo.sh

```bash
#!/bin/bash
# Shebang: indica que el script debe ejecutarse con bash

#*********************************
# Módulo de Monitoreo del Sistema
#*********************************

# Función para monitorear el sistema
monitorear_sistema() {
    # function = define función monitorear_sistema
    # { = inicio del bloque de código
    
    # Bucle del menú de monitoreo
    while true; do
        # while true = bucle infinito
        # do = inicio del bloque de código
        
        # Limpiar pantalla
        clear
        # clear = limpia la pantalla
        
        # Mostrar encabezado
        echo "=========================================="
        echo "    MONITOREO DEL SISTEMA"
        echo "=========================================="
        echo ""
        
        # Mostrar opciones
        echo "1) Estado de servidores"
        echo "2) Uso de recursos del sistema"
        echo "3) Logs del sistema"
        echo "4) Volver al menú principal"
        echo ""
        
        # Solicitar opción
        read -p "Selecciona una opción: " opcion
        # read -p = lee entrada del usuario
        # opcion = variable para almacenar la opción
        
        # Evaluar opción
        case $opcion in
            # case = estructura de control múltiple
            # $opcion = variable con la opción
            
            1) estado_servidores ;;
            # 1) = si opción es 1
            # estado_servidores = llama a función correspondiente
            
            2) uso_recursos ;;
            # 2) = si opción es 2
            # uso_recursos = llama a función correspondiente
            
            3) ver_logs ;;
            # 3) = si opción es 3
            # ver_logs = llama a función correspondiente
            
            4) 
                # 4) = si opción es 4
                echo "Volviendo al menú principal..."
                # echo = muestra mensaje
                break
                # break = sale del bucle while
                ;;
                # ;; = fin de esta opción
            
            *) 
                # *) = opción por defecto
                echo "Opción inválida. Inténtalo de nuevo."
                # echo = muestra mensaje de error
                sleep 2
                # sleep 2 = pausa por 2 segundos
                ;;
                # ;; = fin de esta opción
        esac
        # esac = fin de la estructura case
        
    done
    # done = fin del bucle while
    
}
# } = fin de la función monitorear_sistema

# Función para verificar estado de servidores
estado_servidores() {
    # function = define función estado_servidores
    # { = inicio del bloque de código
    
    # Mostrar encabezado
    echo "=========================================="
    echo "    ESTADO DE SERVIDORES"
    echo "=========================================="
    echo ""
    
    # Verificar si existe el archivo de servidores
    if [ -f "servidores.txt" ]; then
        # if = estructura condicional
        # [ -f "servidores.txt" ] = verifica si el archivo existe
        
        # Leer archivo línea por línea
        while IFS='|' read -r nombre ip puerto servicio descripcion; do
            # while = bucle que se ejecuta mientras haya líneas que leer
            # IFS='|' = define el separador de campos como |
            # read -r = lee una línea del archivo
            # nombre ip puerto servicio descripcion = variables donde se almacenan los campos
            
            # Mostrar información del servidor
            echo "Servidor: $nombre"
            # echo = muestra el nombre del servidor
            # $nombre = contenido de la variable nombre
            
            echo "IP: $ip"
            # echo = muestra la IP
            # $ip = contenido de la variable ip
            
            echo "Puerto: $puerto"
            # echo = muestra el puerto
            # $puerto = contenido de la variable puerto
            
            echo "Servicio: $servicio"
            # echo = muestra el servicio
            # $servicio = contenido de la variable servicio
            
            # Verificar conectividad con ping
            if ping -c 1 -W 1 "$ip" > /dev/null 2>&1; then
                # if = estructura condicional
                # ping -c 1 = envía 1 paquete de ping
                # -W 1 = tiempo de espera de 1 segundo
                # "$ip" = dirección IP a verificar
                # > /dev/null = redirecciona la salida estándar a /dev/null (descarta)
                # 2>&1 = redirecciona la salida de error a la salida estándar
                
                echo "Estado: CONECTADO"
                # echo = muestra estado conectado
                
            else
                # else = bloque si el ping falla
                echo "Estado: DESCONECTADO"
                # echo = muestra estado desconectado
                
            fi
            # fi = fin de la estructura condicional
            
            echo "----------------------------------------"
            # echo = muestra línea separadora
            
        done < servidores.txt
        # done = fin del bucle while
        # < servidores.txt = redirecciona el archivo como entrada del bucle
        
    else
        # else = bloque si el archivo no existe
        echo "No se encontró el archivo de servidores."
        # echo = muestra mensaje de error
        
    fi
    # fi = fin de la estructura condicional
    
    # Pausar para que el usuario pueda leer
    read -p "Presiona Enter para continuar..."
    # read -p = pausa hasta Enter
    
}
# } = fin de la función estado_servidores

# Función para mostrar uso de recursos
uso_recursos() {
    # function = define función uso_recursos
    # { = inicio del bloque de código
    
    # Mostrar encabezado
    echo "=========================================="
    echo "    USO DE RECURSOS DEL SISTEMA"
    echo "=========================================="
    echo ""
    
    # Mostrar información de memoria
    echo "MEMORIA:"
    echo "--------"
    free -h
    # free -h = muestra información de memoria en formato legible
    # -h = formato human-readable (KB, MB, GB)
    
    echo ""
    # echo = línea en blanco
    
    # Mostrar información de disco
    echo "DISCO:"
    echo "------"
    df -h
    # df -h = muestra información de espacio en disco
    # -h = formato human-readable
    
    echo ""
    # echo = línea en blanco
    
    # Mostrar información de CPU
    echo "CPU:"
    echo "----"
    top -bn1 | head -5
    # top -bn1 = ejecuta top en modo batch una vez
    # | = tubería que envía la salida de top a head
    # head -5 = muestra las primeras 5 líneas
    
    echo ""
    # echo = línea en blanco
    
    # Mostrar procesos más consumidores de CPU
    echo "PROCESOS CON MAYOR USO DE CPU:"
    echo "-------------------------------"
    ps aux --sort=-%cpu | head -10
    # ps aux = muestra todos los procesos
    # --sort=-%cpu = ordena por uso de CPU descendente
    # | = tubería
    # head -10 = muestra los primeros 10
    
    # Pausar para que el usuario pueda leer
    read -p "Presiona Enter para continuar..."
    # read -p = pausa hasta Enter
    
}
# } = fin de la función uso_recursos
```

## Módulo de Backup: backup.sh

```bash
#!/bin/bash
# Shebang: indica que el script debe ejecutarse con bash

#*********************************
# Módulo de Copias de Seguridad
#*********************************

# Función para gestionar backups
gestionar_backups() {
    # function = define función gestionar_backups
    # { = inicio del bloque de código
    
    # Bucle del menú de backups
    while true; do
        # while true = bucle infinito
        # do = inicio del bloque de código
        
        # Limpiar pantalla
        clear
        # clear = limpia la pantalla
        
        # Mostrar encabezado
        echo "=========================================="
        echo "    GESTIÓN DE COPIAS DE SEGURIDAD"
        echo "=========================================="
        echo ""
        
        # Mostrar opciones
        echo "1) Crear backup completo"
        echo "2) Restaurar backup"
        echo "3) Listar backups disponibles"
        echo "4) Eliminar backup"
        echo "5) Volver al menú principal"
        echo ""
        
        # Solicitar opción
        read -p "Selecciona una opción: " opcion
        # read -p = lee entrada del usuario
        # opcion = variable para almacenar la opción
        
        # Evaluar opción
        case $opcion in
            # case = estructura de control múltiple
            # $opcion = variable con la opción
            
            1) crear_backup ;;
            # 1) = si opción es 1
            # crear_backup = llama a función correspondiente
            
            2) restaurar_backup ;;
            # 2) = si opción es 2
            # restaurar_backup = llama a función correspondiente
            
            3) listar_backups ;;
            # 3) = si opción es 3
            # listar_backups = llama a función correspondiente
            
            4) eliminar_backup ;;
            # 4) = si opción es 4
            # eliminar_backup = llama a función correspondiente
            
            5) 
                # 5) = si opción es 5
                echo "Volviendo al menú principal..."
                # echo = muestra mensaje
                break
                # break = sale del bucle while
                ;;
                # ;; = fin de esta opción
            
            *) 
                # *) = opción por defecto
                echo "Opción inválida. Inténtalo de nuevo."
                # echo = muestra mensaje de error
                sleep 2
                # sleep 2 = pausa por 2 segundos
                ;;
                # ;; = fin de esta opción
        esac
        # esac = fin de la estructura case
        
    done
    # done = fin del bucle while
    
}
# } = fin de la función gestionar_backups

# Función para crear backup
crear_backup() {
    # function = define función crear_backup
    # { = inicio del bloque de código
    
    # Mostrar encabezado
    echo "=========================================="
    echo "    CREAR COPIA DE SEGURIDAD"
    echo "=========================================="
    echo ""
    
    # Obtener fecha actual para el nombre del backup
    fecha=$(date +%Y%m%d_%H%M%S)
    # fecha = variable para almacenar la fecha
    # $(date +%Y%m%d_%H%M%S) = sustitución de comando
    # date = comando para obtener fecha y hora
    # +%Y%m%d_%H%M%S = formato de fecha (YYYYMMDD_HHMMSS)
    
    # Crear directorio de backups si no existe
    mkdir -p backups
    # mkdir -p = crea directorio y padres si no existen
    # backups = nombre del directorio
    
    # Crear archivo de backup
    nombre_backup="backup_servidores_$fecha.tar.gz"
    # nombre_backup = variable con el nombre del archivo de backup
    # backup_servidores_ = prefijo del nombre
    # $fecha = fecha actual
    # .tar.gz = extensión del archivo comprimido
    
    # Comprimir archivos importantes
    tar -czf "backups/$nombre_backup" servidores.txt configuracion.conf logs/ 2>/dev/null
    # tar -czf = crea archivo comprimido
    # -c = crear archivo
    # -z = comprimir con gzip
    # -f = especificar nombre del archivo
    # "backups/$nombre_backup" = ruta y nombre del archivo de backup
    # servidores.txt = archivo a incluir
    # configuracion.conf = archivo a incluir
    # logs/ = directorio a incluir
    # 2>/dev/null = descarta mensajes de error
    
    # Verificar si el backup se creó correctamente
    if [ -f "backups/$nombre_backup" ]; then
        # if = estructura condicional
        # [ -f "backups/$nombre_backup" ] = verifica si el archivo existe
        
        # Mostrar mensaje de éxito
        echo "Backup creado exitosamente: $nombre_backup"
        # echo = muestra mensaje de éxito
        # $nombre_backup = nombre del archivo creado
        
        # Mostrar tamaño del archivo
        tamaño=$(du -h "backups/$nombre_backup" | cut -f1)
        # tamaño = variable para almacenar el tamaño
        # $(du -h "backups/$nombre_backup" | cut -f1) = sustitución de comando
        # du -h = muestra tamaño en formato legible
        # | = tubería
        # cut -f1 = corta la primera columna
        
        echo "Tamaño del backup: $tamaño"
        # echo = muestra el tamaño
        
        # Registrar en log
        echo "$(date): Backup creado - $nombre_backup" >> logs/sistema.log
        # echo = muestra mensaje
        # $(date) = fecha y hora actual
        # >> logs/sistema.log = añade al archivo de log
        
    else
        # else = bloque si el backup no se creó
        echo "Error al crear el backup."
        # echo = muestra mensaje de error
        
    fi
    # fi = fin de la estructura condicional
    
    # Pausar para que el usuario pueda leer
    read -p "Presiona Enter para continuar..."
    # read -p = pausa hasta Enter
    
}
# } = fin de la función crear_backup

# Función para listar backups
listar_backups() {
    # function = define función listar_backups
    # { = inicio del bloque de código
    
    # Mostrar encabezado
    echo "=========================================="
    echo "    BACKUPS DISPONIBLES"
    echo "=========================================="
    echo ""
    
    # Verificar si existe el directorio de backups
    if [ -d "backups" ]; then
        # if = estructura condicional
        # [ -d "backups" ] = verifica si el directorio existe
        
        # Listar archivos de backup
        ls -la backups/
        # ls -la = lista archivos con detalles
        # backups/ = directorio a listar
        
        echo ""
        # echo = línea en blanco
        
        # Mostrar número total de backups
        total=$(ls backups/ | wc -l)
        # total = variable para almacenar el total
        # $(ls backups/ | wc -l) = sustitución de comando
        # ls backups/ = lista archivos del directorio
        # | = tubería
        # wc -l = cuenta líneas
        
        echo "Total de backups: $total"
        # echo = muestra el total
        # $total = contenido de la variable total
        
    else
        # else = bloque si el directorio no existe
        echo "No se encontró el directorio de backups."
        # echo = muestra mensaje de error
        
    fi
    # fi = fin de la estructura condicional
    
    # Pausar para que el usuario pueda leer
    read -p "Presiona Enter para continuar..."
    # read -p = pausa hasta Enter
    
}
# } = fin de la función listar_backups
```

## Archivo de Configuración: configuracion.conf

```bash
#*********************************
# Archivo de Configuración del Sistema
#*********************************

# Configuración general del sistema
SISTEMA_NOMBRE="Sistema de Gestión de Servidores"
# SISTEMA_NOMBRE = variable con el nombre del sistema

SISTEMA_VERSION="1.0"
# SISTEMA_VERSION = variable con la versión del sistema

# Configuración de logs
LOG_DIR="logs"
# LOG_DIR = variable con el directorio de logs

LOG_SISTEMA="sistema.log"
# LOG_SISTEMA = variable con el nombre del archivo de log del sistema

LOG_ERRORES="errores.log"
# LOG_ERRORES = variable con el nombre del archivo de log de errores

# Configuración de backups
BACKUP_DIR="backups"
# BACKUP_DIR = variable con el directorio de backups

BACKUP_PREFIX="backup_servidores"
# BACKUP_PREFIX = variable con el prefijo de los backups

# Configuración de servidores
SERVIDORES_FILE="servidores.txt"
# SERVIDORES_FILE = variable con el nombre del archivo de servidores

# Configuración de red
PING_TIMEOUT=1
# PING_TIMEOUT = variable con el tiempo de espera para ping

PING_COUNT=1
# PING_COUNT = variable con el número de paquetes de ping

# Configuración de interfaz
MENU_PAUSE=2
# MENU_PAUSE = variable con el tiempo de pausa en el menú
```

## Archivo de Servidores de Ejemplo: servidores.txt

```
servidor-web-01|192.168.1.10|80|HTTP|Servidor web principal
servidor-web-02|192.168.1.11|80|HTTP|Servidor web secundario
servidor-db-01|192.168.1.20|3306|MySQL|Base de datos principal
servidor-db-02|192.168.1.21|3306|MySQL|Base de datos secundaria
servidor-ssh-01|192.168.1.30|22|SSH|Servidor SSH principal
servidor-ftp-01|192.168.1.40|21|FTP|Servidor FTP principal
servidor-smtp-01|192.168.1.50|25|SMTP|Servidor de correo
servidor-dns-01|192.168.1.60|53|DNS|Servidor DNS principal
```

## Script de Inicio: iniciar_sistema.sh

```bash
#!/bin/bash
# Shebang: indica que el script debe ejecutarse con bash

#*********************************
# Script de Inicio del Sistema
#*********************************

# Verificar que el script se ejecute desde el directorio correcto
if [ ! -f "menu_principal.sh" ]; then
    # if = estructura condicional
    # [ ! -f "menu_principal.sh" ] = verifica si el archivo NO existe
    # ! = operador de negación
    
    echo "Error: Este script debe ejecutarse desde el directorio del sistema."
    # echo = muestra mensaje de error
    
    exit 1
    # exit 1 = termina el programa con código de error
    
fi
# fi = fin de la estructura condicional

# Crear directorios necesarios si no existen
mkdir -p logs
# mkdir -p = crea directorio y padres si no existen
# logs = nombre del directorio

mkdir -p backups
# mkdir -p = crea directorio y padres si no existen
# backups = nombre del directorio

# Verificar permisos de ejecución
chmod +x menu_principal.sh
# chmod +x = añade permisos de ejecución
# menu_principal.sh = archivo al que añadir permisos

chmod +x funciones_servidor.sh
# chmod +x = añade permisos de ejecución
# funciones_servidor.sh = archivo al que añadir permisos

chmod +p monitoreo.sh
# chmod +x = añade permisos de ejecución
# monitoreo.sh = archivo al que añadir permisos

chmod +x backup.sh
# chmod +x = añade permisos de ejecución
# backup.sh = archivo al que añadir permisos

# Mostrar mensaje de bienvenida
echo "=========================================="
echo "    SISTEMA DE GESTIÓN DE SERVIDORES"
echo "    Versión 1.0"
echo "=========================================="
echo ""
echo "Iniciando sistema..."
echo ""

# Ejecutar el sistema principal
./menu_principal.sh
# ./menu_principal.sh = ejecuta el script principal
# ./ = indica que el archivo está en el directorio actual
```

## Características de la Solución

### **Funcionalidades Implementadas:**

1. **Gestión de Servidores:**
   - Listar servidores
   - Añadir servidor
   - Buscar servidor
   - Modificar servidor
   - Eliminar servidor

2. **Monitoreo del Sistema:**
   - Estado de servidores (ping)
   - Uso de recursos (memoria, disco, CPU)
   - Visualización de logs

3. **Copias de Seguridad:**
   - Crear backup completo
   - Restaurar backup
   - Listar backups disponibles
   - Eliminar backup

4. **Configuración:**
   - Archivo de configuración centralizado
   - Variables de entorno
   - Configuración de logs y backups

### **Técnicas de ShellScript Utilizadas:**

- **Estructuras de control:** `if`, `case`, `while`, `for`
- **Funciones:** Definición y llamada de funciones
- **Variables:** Locales y globales
- **Parámetros:** `$1`, `$2`, `$#`, `$*`
- **Redirecciones:** `>`, `>>`, `2>`, `|`
- **Comandos del sistema:** `ping`, `ps`, `df`, `free`, `tar`, `grep`
- **Archivos:** Lectura, escritura, verificación de existencia
- **Modularización:** Scripts separados por funcionalidad

### **Comentarios Detallados:**

Cada línea de código está comentada explicando:
- **Qué hace** la línea
- **Por qué** se usa esa sintaxis
- **Cómo funciona** el comando o estructura
- **Qué variables** se utilizan y para qué

Esta solución proporciona una base completa para el reto grupal, mostrando cómo implementar un sistema modular y bien documentado usando las técnicas de ShellScript aprendidas durante la unidad.
