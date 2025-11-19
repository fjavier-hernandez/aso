---
title: Reto Grupal - Sistema de Gestión de Servidores
description: Reto grupal para crear un sistema completo de gestión de servidores usando ShellScript
subtitle: Reto Grupal ShellScript
---

# RETO GRUPAL: Sistema de Gestión de Servidores

**Módulo:** Administración de Sistemas Operativos (ASO)  
**Unidad:** ShellScript  
**Modalidad:** Trabajo en grupo (2 personas)  
**Puntuación:** 30 puntos (sobre 100)  
**Criterios evaluados:** CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i

---

## Objetivo del Reto

Crear un **sistema completo de gestión de servidores** que integre todos los conceptos aprendidos durante la unidad de ShellScript. El sistema debe permitir gestionar servidores, monitorear su estado, realizar copias de seguridad y mantener logs del sistema.

Este reto te permitirá demostrar tu dominio de:

- Estructuras de control (if, case, while, for)
- Funciones y modularización
- Variables y parámetros
- Redirecciones y tuberías
- Comandos del sistema operativo
- Gestión de archivos y directorios

---

## Requisitos del Sistema

### Funcionalidades Obligatorias

El sistema debe incluir las siguientes funcionalidades organizadas en módulos:

#### 1. **Menú Principal Interactivo**

- Menú con opciones numeradas
- Navegación entre módulos
- Opción de salida del sistema
- Interfaz clara y amigable

#### 2. **Gestión de Servidores**

- **Listar** servidores: Mostrar todos los servidores registrados
- **Añadir** servidor: Registrar nuevos servidores con sus datos
- **Buscar** servidor: Buscar servidores por nombre, IP, servicio, etc.
- **Modificar** servidor: Editar información de servidores existentes
- **Eliminar** servidor: Eliminar servidores del sistema

**Datos de cada servidor:**

- Nombre del servidor
- Dirección IP
- Puerto
- Servicio (HTTP, SSH, MySQL, FTP, SMTP, DNS, etc.)
- Descripción (opcional)

#### 3. **Monitoreo del Sistema**

- **Estado de servidores**: Verificar conectividad usando `ping`
- **Uso de recursos**: Mostrar información de:
  - Memoria (comando `free`)
  - Disco (comando `df`)
  - CPU (comando `top` o `ps`)
- **Visualización de logs**: Mostrar logs del sistema

#### 4. **Sistema de Copias de Seguridad**

- **Crear backup**: Generar copias de seguridad comprimidas (`.tar.gz`)
- **Restaurar backup**: Restaurar datos desde un backup
- **Listar backups**: Mostrar backups disponibles
- **Eliminar backup**: Eliminar backups antiguos

#### 5. **Gestión de Logs**

- Registrar acciones del sistema en archivos de log
- Diferentes tipos de logs (sistema, errores)
- Formato con fecha y hora de cada acción

#### 6. **Configuración del Sistema**

- Archivo de configuración centralizado
- Variables de entorno configurables
- Configuración de rutas y directorios

#### 7. **Servidores Simulados (Opcional pero Recomendado)**

- Simulación de servidores para pruebas sin necesidad de servidores reales
- Simulación de diferentes tipos de servidores (HTTP, SSH, MySQL, FTP, SMTP, DNS)
- Scripts temporales con here documents
- Ejecución en segundo plano con gestión de PIDs
- Verificación de conectividad automática

**Servidores simulados disponibles:**

| Servidor | Puerto | Protocolo | Respuesta |
|----------|--------|-----------|-----------|
| Web | 8080 | HTTP | `HTTP/1.1 200 OK\r\n\r\nServidor Web Simulado` |
| SSH | 2222 | SSH | `SSH-2.0-OpenSSH_7.4 Simulado` |
| MySQL | 3306 | MySQL | `MySQL Simulado - Puerto 3306` |
| FTP | 21 | FTP | `220 FTP Server Simulado` |
| SMTP | 25 | SMTP | `220 SMTP Server Simulado` |
| DNS | 53 | DNS | `DNS Server Simulado` |

---

## Estructura del Proyecto

El proyecto debe estar organizado de forma modular con la siguiente estructura:

```
sistema_gestion_servidores/
├── menu_principal.sh          # Script principal del sistema
├── funciones_servidor.sh       # Módulo de gestión de servidores
├── monitoreo.sh               # Módulo de monitoreo del sistema
├── backup.sh                  # Módulo de copias de seguridad
├── configuracion.conf         # Archivo de configuración
├── servidores.txt             # Base de datos de servidores (formato texto)
├── servidores_simulados.sh    # Script para simular servidores (opcional)
├── iniciar_simuladores.sh     # Script de inicio rápido de simuladores (opcional)
├── logs/                      # Directorio de logs
│   ├── sistema.log
│   └── errores.log
└── backups/                   # Directorio de backups
    └── backup_servidores_YYYYMMDD.tar.gz
```

### Descripción de Archivos

#### `menu_principal.sh`

- Script principal que inicia el sistema
- Carga los módulos necesarios usando `source`
- Implementa el menú principal
- Gestiona la navegación entre módulos

#### `funciones_servidor.sh`

- Funciones para gestión CRUD de servidores
- Lectura y escritura en `servidores.txt`
- Validación de datos
- Formato de datos: `nombre|ip|puerto|servicio|descripcion`

#### `monitoreo.sh`

- Funciones de monitoreo de servidores
- Verificación de conectividad con `ping`
- Obtención de información del sistema
- Visualización de logs

#### `backup.sh`

- Funciones para crear, restaurar, listar y eliminar backups
- Uso de `tar` y `gzip` para compresión
- Gestión del directorio de backups

#### `configuracion.conf`

- Variables de configuración del sistema
- Rutas de directorios
- Configuraciones de logs y backups
- Parámetros del sistema

#### `servidores_simulados.sh` (Opcional)

- Script para simular diferentes tipos de servidores
- Verificación de dependencias (netcat)
- Creación de scripts temporales con here documents
- Ejecución en segundo plano con gestión de PIDs
- Verificación de estado de servidores

#### `iniciar_simuladores.sh` (Opcional)

- Script de inicio rápido de servidores simulados
- Función genérica para simular cualquier servidor
- Inicio de múltiples servidores simultáneamente

---

## Técnicas ShellScript Requeridas

El sistema debe demostrar el uso de:

### Estructuras de Control

- `if`, `elif`, `else` para condiciones
- `case` para menús y opciones múltiples
- `while` para bucles y menús interactivos
- `for` para recorrer listas y arrays

### Funciones y Modularización

- Definición de funciones con `function nombre() {}`
- Uso de `source` o `.` para cargar módulos
- Parámetros de funciones (`$1`, `$2`, etc.)
- Retorno de valores con `return`

### Variables y Parámetros

- Variables locales y globales
- Parámetros del script (`$0`, `$1`, `$#`, `$*`)
- Variables de entorno
- Arrays/vectores para almacenar datos

### Redirecciones y Tuberías

- Redirección de salida (`>`, `>>`)
- Redirección de errores (`2>`)
- Tuberías (`|`) para conectar comandos
- Redirección de entrada (`<`)

### Comandos del Sistema

- `ping` para verificar conectividad
- `ps`, `top` para información de procesos
- `df`, `free` para recursos del sistema
- `tar`, `gzip` para backups
- `grep` para búsquedas
- `date` para fechas y horas

### Gestión de Archivos

- Lectura de archivos (`cat`, `read`)
- Escritura en archivos (`echo >>`)
- Verificación de existencia (`[ -f ]`, `[ -d ]`)
- Creación de directorios (`mkdir -p`)

### Técnicas Avanzadas (Para Servidores Simulados)

- **Here Documents:** `<< EOF` para crear scripts temporales
- **Ejecución en segundo plano:** `&` y variable `$!` para PIDs
- **Comandos de red:** `netcat` (nc) para simulación de servidores
- **Gestión de procesos:** `pkill`, `ps` para control de procesos
- **Verificación de estado:** `netstat` y `grep` para monitoreo de puertos
- **Scripts temporales:** Creación dinámica de archivos ejecutables

---

## Formato de Datos

### Archivo `servidores.txt`

Cada línea representa un servidor con el siguiente formato:

```
nombre_servidor|direccion_ip|puerto|servicio|descripcion
```

**Ejemplo:**
```
servidor-web-01|192.168.1.10|80|HTTP|Servidor web principal
servidor-db-01|192.168.1.20|3306|MySQL|Base de datos principal
servidor-ssh-01|192.168.1.30|22|SSH|Servidor SSH principal
```

### Archivo de Logs

Formato de cada entrada en los logs:

```
YYYY-MM-DD HH:MM:SS: Mensaje de la acción
```

**Ejemplo:**
```
2024-10-15 14:30:25: Servidor 'servidor-web-01' añadido
2024-10-15 14:35:10: Backup creado - backup_servidores_20241015_143510.tar.gz
```

---

## Servidores Simulados

### Descripción

La funcionalidad de **servidores simulados** permite probar el sistema de gestión sin necesidad de servidores reales. Esta característica es **opcional pero altamente recomendada** ya que facilita las pruebas del sistema y demuestra el uso de técnicas avanzadas de ShellScript.

### Funcionalidad

Los servidores simulados permiten:

- Simular diferentes tipos de servidores (HTTP, SSH, MySQL, FTP, SMTP, DNS)
- Probar el sistema de monitoreo con servidores locales
- Verificar la conectividad sin depender de servidores externos
- Demostrar el uso de técnicas avanzadas de ShellScript

### Implementación

#### Técnica: Here Documents

Los servidores simulados se crean usando **here documents** para generar scripts temporales:

```bash
cat > "/tmp/servidor_${puerto}.sh" << EOF
#!/bin/bash
while true; do
    echo "$respuesta" | nc -l $puerto
    sleep 0.1
done
EOF
```

#### Técnica: Ejecución en Segundo Plano

Los servidores se ejecutan en segundo plano usando `&` y se guarda el PID:

```bash
"/tmp/servidor_${puerto}.sh" &
echo "Servidor iniciado (PID: $!)"
```

#### Técnica: Verificación de Estado

Se puede verificar si un servidor está activo usando `netstat`:

```bash
if netstat -an | grep -q ":${puerto}.*LISTEN"; then
    echo "Servidor ACTIVO"
else
    echo "Servidor INACTIVO"
fi
```

### Requisitos

Para usar servidores simulados necesitas:

- **netcat (nc):** Herramienta para simulación de servidores
  - macOS: `brew install netcat`
  - Ubuntu/Debian: `apt-get install netcat`
  - CentOS/RHEL: `yum install nc`
- **Puertos disponibles:** 8080, 2222, 3306, 21, 25, 53
- **Permisos:** Acceso de escritura en `/tmp/` para scripts temporales

### Ejemplo de Uso

#### Iniciar Servidores Simulados:

```bash
# Opción 1: Script básico
./iniciar_simuladores.sh

# Opción 2: Script mejorado
./servidores_simulados.sh
```

#### Verificar Servidores Activos:

```bash
netstat -an | grep LISTEN | grep -E "(8080|2222|3306|21|25|53)"
```

#### Probar Conectividad:

```bash
echo "test" | nc -w 1 127.0.0.1 8080
```

#### Detener Servidores:

```bash
pkill -f "nc -l"
```

### Integración con el Sistema

Los servidores simulados pueden añadirse al archivo `servidores.txt`:

```
servidor-web-simulado|127.0.0.1|8080|HTTP|Servidor web local simulado
servidor-ssh-simulado|127.0.0.1|2222|SSH|Servidor SSH simulado
servidor-mysql-simulado|127.0.0.1|3306|MySQL|Base de datos MySQL simulado
servidor-ftp-simulado|127.0.0.1|21|FTP|Servidor FTP simulado
servidor-smtp-simulado|127.0.0.1|25|SMTP|Servidor SMTP simulado
servidor-dns-simulado|127.0.0.1|53|DNS|Servidor DNS simulado
```

### Archivos Temporales

Durante la ejecución se crean scripts temporales en `/tmp/`:

- `/tmp/servidor_8080.sh` - Servidor web
- `/tmp/servidor_2222.sh` - Servidor SSH
- `/tmp/servidor_3306.sh` - Servidor MySQL
- `/tmp/servidor_21.sh` - Servidor FTP
- `/tmp/servidor_25.sh` - Servidor SMTP
- `/tmp/servidor_53.sh` - Servidor DNS

Estos archivos se pueden limpiar manualmente o al detener los servidores.

---

## Criterios de Evaluación

El proyecto será evaluado según los siguientes criterios (ver [Rúbrica de Evaluación](Rubrica_Evaluacion_RetoShell.md) para más detalles):

1. **Funcionalidad (15 puntos)**

   - Sistema completamente funcional
   - Todas las funcionalidades requeridas implementadas
   - Sin errores de ejecución
   - Manejo correcto de errores

2. **Estructura del Código (5 puntos)**

   - Código organizado y modular
   - Comentarios detallados en cada línea
   - Separación clara de responsabilidades
   - Nombres descriptivos

3. **Uso de Conceptos ShellScript (5 puntos)**

   - Uso correcto de todas las técnicas aprendidas
   - Variables, bucles, funciones bien implementadas
   - Manejo de parámetros y redirecciones
   - Integración de comandos del sistema

4. **Documentación (3 puntos)**

   - README.md completo y profesional
   - Instrucciones claras de instalación y uso
   - Documentación de cada módulo
   - Capturas de pantalla

5. **Creatividad e Innovación (2 puntos)**

   - Funcionalidades adicionales innovadoras
   - Mejoras creativas al sistema
   - Interfaz mejorada
   - Características únicas

### Puntos Extra (Hasta +8 puntos)

- **Autenticación de usuarios** (+2 puntos)
- **Gráficos ASCII con estadísticas** (+2 puntos)
- **Notificaciones por email** (+2 puntos)
- **Interfaz con colores** (+1 punto)
- **Sistema de alertas sonoras** (+1 punto)

---

## Instrucciones de Entrega

### Estructura de Entrega

1. **Crear directorio** con el nombre: `reto_grupal_[nombre1]_[nombre2]`
2. **Incluir todos los archivos** del proyecto:

   - Scripts `.sh` con permisos de ejecución
   - Archivo de configuración `.conf`
   - README.md con documentación completa
   - Capturas de pantalla del sistema funcionando
3. **Comprimir en ZIP** el directorio completo
4. **Subir al Moodle** antes de la fecha límite

### Contenido del README.md

El README.md debe incluir:

- **Descripción del proyecto**: Qué hace el sistema
- **Instrucciones de instalación**: Cómo configurar el sistema
- **Guía de uso**: Cómo usar cada funcionalidad
- **Estructura del proyecto**: Explicación de cada archivo
- **Capturas de pantalla**: Imágenes del sistema funcionando
- **Autores**: Nombres de los miembros del grupo
- **Fecha**: Fecha de entrega

### Requisitos Técnicos

- Todos los scripts deben tener el shebang `#!/bin/bash`
- Todos los scripts deben tener permisos de ejecución (`chmod +x`)
- El código debe estar completamente comentado
- El sistema debe funcionar sin errores
- Debe incluir manejo de errores básico

---

## Ejemplo de Funcionamiento

### Menú Principal
```
==========================================
    SISTEMA DE GESTIÓN DE SERVIDORES
==========================================

1) Gestión de servidores
2) Monitoreo del sistema
3) Copias de seguridad
4) Configuración del sistema
5) Salir

Selecciona una opción: 
```

### Gestión de Servidores
```
==========================================
    GESTIÓN DE SERVIDORES
==========================================

1) Listar servidores
2) Añadir servidor
3) Buscar servidor
4) Modificar servidor
5) Eliminar servidor
6) Volver al menú principal

Selecciona una opción: 
```

---

## Consejos y Recomendaciones

### Planificación

1. **Dividir el trabajo** entre los miembros del grupo
2. **Crear primero la estructura** básica del proyecto
3. **Implementar funcionalidad por funcionalidad**
4. **Probar cada módulo** antes de integrarlo
5. **Documentar mientras se desarrolla**

### Buenas Prácticas

- Usar nombres descriptivos para variables y funciones
- Comentar cada línea de código importante
- Validar entradas del usuario
- Manejar errores de forma adecuada
- Mantener el código organizado y limpio

### Depuración

- Usar `bash -x script.sh` para depurar
- Usar `set -x` y `set +x` dentro del código
- Probar cada función individualmente
- Verificar permisos de archivos y directorios

---

## Recursos y Referencias

- [Documentación del tema ShellScript](01ShellScript.md)
- [Solución detallada del reto](SolucionRetoGrupalShellScript.md)
- [Rúbrica de evaluación](Rubrica_Evaluacion_RetoShell.md)

---

## Fechas Importantes

- **Fecha de inicio:** Sesión 5
- **Fecha de entrega:** Sesión 8
- **Presentación:** Sesión 8

---

!!! success "¡Éxito en el reto!"
    Este reto te permitirá demostrar todos los conocimientos adquiridos durante la unidad de ShellScript. ¡Trabaja en equipo, planifica bien y documenta todo!

