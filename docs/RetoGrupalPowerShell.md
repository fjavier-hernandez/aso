---
title: Reto Grupal - Sistema de Gestión de Servicios de Windows
description: Reto grupal para crear un sistema completo de gestión de servicios de Windows usando PowerShell
subtitle: Reto Grupal PowerShell
---

# RETO GRUPAL: Sistema de Gestión de Servicios de Windows

**Módulo:** Administración de Sistemas Operativos (ASO)  
**Unidad:** PowerShell  
**Modalidad:** Trabajo en grupo (2-3 personas)  
**Puntuación:** 30 puntos (sobre 100)  
**Criterios evaluados:** CE7a, CE7b, CE7c, CE7d, CE7e, CE7f, CE7g, CE7h y CE7i  
**Defensa del proyecto:** Obligatoria, duración 20-30 minutos

---

## Objetivo del Reto

Crear un **sistema completo de gestión de servicios de Windows** que integre todos los conceptos aprendidos durante la unidad de PowerShell. El sistema debe permitir gestionar servicios, monitorear procesos y recursos del sistema, realizar copias de seguridad y mantener logs del sistema.

Este reto te permitirá demostrar tu dominio de:

- Estructuras de control (if, switch, while, for, foreach)
- Funciones y modularización con parámetros tipados
- Variables con tipado implícito y explícito
- Cmdlets de PowerShell para administración de Windows
- Gestión de archivos y directorios
- Trabajo con objetos y colecciones

---

## Requisitos del Sistema

### Funcionalidades Obligatorias

El sistema debe incluir las siguientes funcionalidades organizadas en módulos:

#### 1. **Menú Principal Interactivo**

- Menú con opciones numeradas
- Navegación entre módulos
- Opción de salida del sistema
- Interfaz clara y amigable usando `Write-Host` con colores

#### 2. **Gestión de Servicios de Windows**

- **Listar** servicios: Mostrar todos los servicios registrados con su estado
- **Añadir** servicio a seguimiento: Registrar servicios para monitoreo personalizado
- **Buscar** servicio: Buscar servicios por nombre, estado, tipo de inicio, etc.
- **Modificar** seguimiento: Editar información de servicios en seguimiento
- **Eliminar** de seguimiento: Eliminar servicios del sistema de seguimiento
- **Controlar** servicios: Iniciar, detener, pausar, reanudar servicios

**Datos de cada servicio:**

- Nombre del servicio
- Nombre para mostrar (DisplayName)
- Estado actual (Running, Stopped, Paused)
- Tipo de inicio (Automatic, Manual, Disabled)
- Descripción
- Proceso asociado (PID)

#### 3. **Monitoreo del Sistema**

- **Estado de servicios**: Verificar estado de servicios usando `Get-Service`
- **Uso de recursos**: Mostrar información de:
  - Memoria (cmdlet `Get-CimInstance Win32_OperatingSystem`)
  - Disco (cmdlet `Get-PSDrive` o `Get-CimInstance Win32_LogicalDisk`)
  - CPU (cmdlet `Get-Process` con uso de CPU)
  - Procesos más consumidores de recursos
- **Visualización de logs**: Mostrar logs del sistema y eventos de Windows

#### 4. **Sistema de Copias de Seguridad**

- **Crear backup**: Generar copias de seguridad comprimidas (`.zip`)
- **Restaurar backup**: Restaurar datos desde un backup
- **Listar backups**: Mostrar backups disponibles
- **Eliminar backup**: Eliminar backups antiguos

#### 5. **Gestión de Logs**

- Registrar acciones del sistema en archivos de log
- Diferentes tipos de logs (sistema, errores, eventos)
- Formato con fecha y hora de cada acción usando `Get-Date`
- Integración con Event Viewer de Windows

#### 6. **Configuración del Sistema**

- Archivo de configuración centralizado (formato CSV o JSON)
- Variables tipadas configurables
- Configuración de rutas y directorios
- Parámetros del sistema

#### 7. **Gestión de Procesos (Opcional pero Recomendado)**

- Listar procesos del sistema
- Filtrar procesos por nombre, CPU, memoria
- Detener procesos específicos
- Monitoreo de procesos críticos
- Alertas cuando procesos consumen demasiados recursos

#### 8. **Simulación de Servicios (Opcional pero Recomendado)**

- Simulación de servicios para pruebas sin necesidad de modificar servicios reales
- Creación de servicios temporales o ficticios para pruebas
- Uso de servicios existentes de Windows en modo de prueba
- Simulación de cambios de estado de servicios
- Verificación de comportamiento del sistema con servicios simulados

---

## Estructura del Proyecto

El proyecto debe estar organizado de forma modular con la siguiente estructura:

```
sistema_gestion_servicios/
├── Menu-Principal.ps1          # Script principal del sistema
├── Funciones-Servicio.ps1     # Módulo de gestión de servicios
├── Monitoreo-Sistema.ps1       # Módulo de monitoreo del sistema
├── Backup-Sistema.ps1          # Módulo de copias de seguridad
├── Configuracion.csv           # Archivo de configuración (CSV)
├── Servicios-Seguimiento.csv   # Base de datos de servicios (formato CSV)
├── Simulador-Servicios.ps1     # Script para simular servicios (opcional)
├── logs/                       # Directorio de logs
│   ├── sistema.log
│   └── errores.log
└── backups/                    # Directorio de backups
    └── backup_servicios_YYYYMMDD.zip
```

### Descripción de Archivos

#### `Menu-Principal.ps1`

- Script principal que inicia el sistema
- Carga los módulos necesarios usando `.` (notación de punto)
- Implementa el menú principal con `switch`
- Gestiona la navegación entre módulos

#### `Funciones-Servicio.ps1`

- Funciones para gestión CRUD de servicios
- Lectura y escritura en `Servicios-Seguimiento.csv`
- Validación de datos usando operadores de comparación
- Uso de cmdlets `Get-Service`, `Start-Service`, `Stop-Service`, etc.
- Formato de datos: CSV con columnas separadas por comas

!!! note "¿Qué es CRUD?"
    CRUD se refiere a las cuatro operaciones fundamentales para interactuar con los datos en una base de datos o sistema de almacenamiento: **Crear**, **Leer**, **Actualizar** y **Eliminar** (del inglés *Create, Read, Update, Delete*).


#### `Monitoreo-Sistema.ps1`

- Funciones de monitoreo de servicios y procesos
- Verificación de estado con `Get-Service`
- Obtención de información del sistema usando CIM/WMI
- Visualización de logs y eventos
- Uso de `Get-EventLog` para eventos del sistema

#### `Backup-Sistema.ps1`

- Funciones para crear, restaurar, listar y eliminar backups
- Uso de `Compress-Archive` para compresión ZIP
- Gestión del directorio de backups
- Uso de `Expand-Archive` para restaurar

#### `Configuracion.csv`

- Variables de configuración del sistema en formato CSV
- Rutas de directorios
- Configuraciones de logs y backups
- Parámetros del sistema

#### `Servicios-Seguimiento.csv`

- Base de datos de servicios en formato CSV
- Columnas: Nombre, DisplayName, Estado, TipoInicio, Descripcion, PID

#### `Simulador-Servicios.ps1` (Opcional)

- Script para simular servicios de Windows
- Funciones para crear y gestionar servicios simulados
- Uso de objetos personalizados `[PSCustomObject]`
- Integración con el sistema de seguimiento

---

## Técnicas PowerShell Requeridas

El sistema debe demostrar el uso de:

### Estructuras de Control

- `if`, `elseif`, `else` para condiciones
- `switch` para menús y opciones múltiples (con opciones `-wildcard`, `-regex`)
- `while`, `do-while` para bucles y menús interactivos
- `for`, `foreach` para recorrer colecciones y arrays

### Funciones y Modularización

- Definición de funciones con `Function Nombre-Funcion {}`
- Parámetros tipados con `param ([tipo] $parametro)`
- Uso de `.` (notación de punto) para cargar módulos
- Retorno de valores con `return`
- Funciones con validación de parámetros

### Variables y Parámetros

- Variables con tipado implícito y explícito
- Parámetros del script usando `$args[]`
- Arrays y vectores con operador `@()`
- Operador de rango `..` para generar secuencias
- Variables de entorno usando `$env:`

### Operadores PowerShell

- **Aritméticos:** `+`, `-`, `*`, `/`, `%`, `+=`, `-=`, `++`, `--`
- **Comparación:** `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`, `-like`, `-contains`
- **Lógicos:** `-and`, `-or`, `-xor`, `-not`, `!`
- **Tipo:** `-is`, `-isnot`, `-as`

### Cmdlets del Sistema

- `Get-Service` para gestión de servicios
- `Start-Service`, `Stop-Service`, `Restart-Service` para control de servicios
- `Get-Process` para información de procesos
- `Get-CimInstance` o `Get-WmiObject` para información del sistema
- `Get-EventLog` para eventos del sistema
- `Compress-Archive`, `Expand-Archive` para backups
- `Get-Content`, `Set-Content`, `Add-Content` para archivos
- `Get-Date` para fechas y horas
- `Import-Csv`, `Export-Csv` para trabajar con CSV

### Gestión de Archivos

- Lectura de archivos (`Get-Content`, `Import-Csv`)
- Escritura en archivos (`Set-Content`, `Add-Content`, `Export-Csv`)
- Verificación de existencia (`Test-Path`)
- Creación de directorios (`New-Item`)

### Trabajo con Objetos

- Acceso a propiedades de objetos con `.`
- Filtrado con `Where-Object`
- Ordenamiento con `Sort-Object`
- Selección de propiedades con `Select-Object`
- Agrupación con `Group-Object`

---

## Formato de Datos

### Archivo `Servicios-Seguimiento.csv`

Cada línea representa un servicio con el siguiente formato:

```csv
Nombre,DisplayName,Estado,TipoInicio,Descripcion,PID
```

**Ejemplo:**

```csv
Spooler,Print Spooler,Running,Automatic,Servicio de cola de impresión,1234
WinRM,Windows Remote Management,Running,Automatic,Servicio de administración remota,5678
```

### Archivo de Logs

Formato de cada entrada en los logs:

```
YYYY-MM-DD HH:MM:SS: Mensaje de la acción
```

**Ejemplo:**

```
2024-10-15 14:30:25: Servicio 'Spooler' añadido al seguimiento
2024-10-15 14:35:10: Backup creado - backup_servicios_20241015_143510.zip
```

### Archivo de Configuración `Configuracion.csv`

Formato CSV con variables de configuración:

```csv
Variable,Valor
SistemaNombre,Sistema de Gestión de Servicios
Version,1.0
LogDir,logs
BackupDir,backups
```

---

## Simulación de Servicios

### Descripción

La funcionalidad de **simulación de servicios** permite probar el sistema de gestión sin necesidad de modificar servicios reales de Windows. Esta característica es **opcional pero altamente recomendada** ya que facilita las pruebas del sistema y demuestra el uso de técnicas avanzadas de PowerShell.

### Funcionalidad

Los servicios simulados permiten:

- Probar el sistema de gestión con servicios ficticios o temporales
- Simular cambios de estado sin afectar servicios reales
- Verificar el comportamiento del sistema con diferentes configuraciones
- Demostrar el uso de técnicas avanzadas de PowerShell

### Métodos de Simulación

#### Método 1: Usar Servicios Existentes de Windows (Recomendado)

La forma más segura es usar servicios reales de Windows que no sean críticos para el sistema, como servicios que se pueden detener e iniciar sin problemas:

```powershell
# Listar servicios que se pueden usar para pruebas
Get-Service | Where-Object {$_.Status -eq 'Stopped' -and $_.StartType -ne 'Disabled'} | Select-Object Name, DisplayName

# Ejemplo: Usar el servicio "Spooler" (si está detenido)
$servicioPrueba = Get-Service -Name "Spooler"
Write-Host "Estado actual: $($servicioPrueba.Status)"
```

**Servicios recomendados para pruebas:**

| Servicio | Nombre | Descripción |
|----------|--------|-------------|
| Spooler | Spooler | Servicio de cola de impresión (puede detenerse si no hay impresoras) |
| Themes | Themes | Servicio de temas de Windows |
| TabletInputService | TabletInputService | Servicio de entrada de tableta (si no se usa) |
| WSearch | WSearch | Servicio de búsqueda de Windows |

#### Método 2: Crear Servicios Temporales con sc.exe

Usando el comando `sc.exe` se pueden crear servicios temporales (requiere permisos de administrador):

```powershell
# Crear un servicio temporal
sc.exe create "ServicioPrueba" binPath= "C:\Windows\System32\notepad.exe" start= demand

# Verificar que se creó
Get-Service -Name "ServicioPrueba"

# Eliminar el servicio temporal
sc.exe delete "ServicioPrueba"
```

#### Método 3: Simular con Jobs de PowerShell

Crear trabajos de PowerShell que simulen el comportamiento de servicios:

```powershell
# Función para simular un servicio
function Start-ServicioSimulado {
    param(
        [string]$NombreServicio,
        [int]$Puerto
    )
    
    $job = Start-Job -ScriptBlock {
        param($nombre, $puerto)
        while ($true) {
            Write-Output "$nombre ejecutándose en puerto $puerto"
            Start-Sleep -Seconds 5
        }
    } -ArgumentList $NombreServicio, $Puerto
    
    Write-Host "Servicio simulado '$NombreServicio' iniciado (Job ID: $($job.Id))"
    return $job
}

# Iniciar servicio simulado
$servicio1 = Start-ServicioSimulado -NombreServicio "WebService" -Puerto 8080

# Detener servicio simulado
Stop-Job -Id $servicio1.Id
Remove-Job -Id $servicio1.Id
```

#### Método 4: Simular Estados con Variables

Crear un sistema de seguimiento que simule servicios usando variables y objetos personalizados:

```powershell
# Crear objeto de servicio simulado
$servicioSimulado = [PSCustomObject]@{
    Nombre = "ServicioWebSimulado"
    DisplayName = "Servicio Web Simulado"
    Estado = "Running"
    TipoInicio = "Automatic"
    Descripcion = "Servicio simulado para pruebas"
    PID = $null
    FechaCreacion = Get-Date
}

# Función para cambiar estado simulado
function Set-EstadoServicioSimulado {
    param(
        [PSCustomObject]$Servicio,
        [ValidateSet("Running", "Stopped", "Paused")]
        [string]$NuevoEstado
    )
    
    $Servicio.Estado = $NuevoEstado
    Write-Host "Estado de $($Servicio.Nombre) cambiado a: $NuevoEstado"
}

# Cambiar estado
Set-EstadoServicioSimulado -Servicio $servicioSimulado -NuevoEstado "Stopped"
```

<!-- ### Implementación Recomendada

#### Script de Simulación de Servicios

```powershell
# Simulador-Servicios.ps1
# Script para simular servicios de Windows

function Initialize-ServiciosSimulados {
    # Crear array de servicios simulados
    $serviciosSimulados = @()
    
    # Servicios simulados predefinidos
    # El operador += agrega un nuevo objeto al arreglo $serviciosSimulados
    $serviciosSimulados += [PSCustomObject]@{
        Nombre = "WebServiceSimulado"
        DisplayName = "Servicio Web Simulado"
        Estado = "Running"
        TipoInicio = "Automatic"
        Descripcion = "Servicio web simulado para pruebas"
    }
    
    $serviciosSimulados += [PSCustomObject]@{
        Nombre = "DatabaseServiceSimulado"
        DisplayName = "Servicio Base de Datos Simulado"
        Estado = "Stopped"
        TipoInicio = "Manual"
        Descripcion = "Servicio de base de datos simulado"
    }
    
    return $serviciosSimulados
}

function Get-ServiciosSimulados {
    $servicios = Initialize-ServiciosSimulados
    return $servicios
}

function Start-ServicioSimulado {
    param([string]$NombreServicio)
    
    $servicios = Get-ServiciosSimulados
    $servicio = $servicios | Where-Object {$_.Nombre -eq $NombreServicio}
    
    if ($servicio) {
        $servicio.Estado = "Running"
        Write-Host "Servicio simulado '$NombreServicio' iniciado" -ForegroundColor Green
    } else {
        Write-Host "Servicio simulado '$NombreServicio' no encontrado" -ForegroundColor Red
    }
}

function Stop-ServicioSimulado {
    param([string]$NombreServicio)
    
    $servicios = Get-ServiciosSimulados
    $servicio = $servicios | Where-Object {$_.Nombre -eq $NombreServicio}
    
    if ($servicio) {
        $servicio.Estado = "Stopped"
        Write-Host "Servicio simulado '$NombreServicio' detenido" -ForegroundColor Yellow
    } else {
        Write-Host "Servicio simulado '$NombreServicio' no encontrado" -ForegroundColor Red
    }
}

# Exportar funciones
Export-ModuleMember -Function Get-ServiciosSimulados, Start-ServicioSimulado, Stop-ServicioSimulado
``` -->

### Integración con el Sistema

Los servicios simulados pueden añadirse al archivo `Servicios-Seguimiento.csv`:

```csv
Nombre,DisplayName,Estado,TipoInicio,Descripcion,PID
WebServiceSimulado,Servicio Web Simulado,Running,Automatic,Servicio web simulado para pruebas,
DatabaseServiceSimulado,Servicio Base de Datos Simulado,Stopped,Manual,Servicio de base de datos simulado,
```

### Técnicas PowerShell Utilizadas

#### Trabajo con Objetos Personalizados:

```powershell
$objeto = [PSCustomObject]@{
    Propiedad1 = "Valor1"
    Propiedad2 = "Valor2"
}
```

#### Filtrado de Objetos:

```powershell
$servicios = Get-ServiciosSimulados | Where-Object {$_.Estado -eq "Running"}
```

#### Exportación a CSV:

```powershell
$servicios | Export-Csv -Path "Servicios-Seguimiento.csv" -NoTypeInformation
```

#### Jobs de PowerShell:

```powershell
$job = Start-Job -ScriptBlock { # código }
Get-Job
Stop-Job -Id $job.Id
```

### Comandos de Uso

#### Iniciar Servicios Simulados:

```powershell
# Cargar módulo de simulación
. .\Simulador-Servicios.ps1

# Listar servicios simulados
Get-ServiciosSimulados

# Iniciar servicio simulado
Start-ServicioSimulado -NombreServicio "WebServiceSimulado"
```

#### Verificar Servicios Simulados:

```powershell
# Ver todos los servicios simulados
Get-ServiciosSimulados | Format-Table

# Filtrar por estado
Get-ServiciosSimulados | Where-Object {$_.Estado -eq "Running"}
```

#### Detener Servicios Simulados:

```powershell
# Detener servicio simulado
Stop-ServicioSimulado -NombreServicio "WebServiceSimulado"
```

### Consideraciones Importantes

- **Permisos:** Algunos métodos requieren permisos de administrador
- **Seguridad:** No modificar servicios críticos del sistema
- **Limpieza:** Eliminar servicios temporales después de las pruebas
- **Documentación:** Documentar qué servicios se están usando para pruebas

### Ventajas de la Simulación

- Permite probar el sistema sin riesgo
- Facilita el desarrollo y depuración
- No afecta servicios reales del sistema
- Demuestra conocimiento de técnicas avanzadas de PowerShell
- Permite crear escenarios de prueba específicos

---

<!-- ## Integración con Active Directory (Opcional)

### Descripción

**Active Directory Domain Services (AD DS)** es un servicio crítico de Windows Server que gestiona la información de usuarios, equipos y recursos de red en un dominio. Esta sección muestra cómo monitorizar si el servicio de Active Directory está instalado y corriendo.

!!! note "Configuración detallada"
    Para información completa sobre instalación y configuración de Active Directory, consulta el documento [Configuración de Active Directory](ActiveDirectory_Configuracion.md).

### Monitoreo del Servicio de Active Directory

El sistema debe verificar si el servicio de Active Directory está instalado y en ejecución:

```powershell
# Verificar si el servicio NTDS (Active Directory Domain Services) está instalado y corriendo
function Test-ServicioActiveDirectory {
    $ntdsService = Get-Service -Name "NTDS" -ErrorAction SilentlyContinue
    
    if ($ntdsService) {
        Write-Host "Servicio Active Directory encontrado" -ForegroundColor Green
        Write-Host "Estado: $($ntdsService.Status)" -ForegroundColor $(if ($ntdsService.Status -eq "Running") { "Green" } else { "Yellow" })
        Write-Host "Tipo de inicio: $($ntdsService.StartType)" -ForegroundColor Yellow
        return $ntdsService
    } else {
        Write-Host "Servicio Active Directory no encontrado" -ForegroundColor Red
        Write-Host "Active Directory puede no estar instalado en este servidor." -ForegroundColor Yellow
        return $null
    }
}

# Verificar servicios relacionados con Active Directory
function Get-ServiciosActiveDirectory {
    $serviciosAD = Get-Service | Where-Object {
        $_.Name -like "*NTDS*" -or 
        $_.Name -like "*DNS*" -or 
        $_.Name -like "*Netlogon*" -or
        $_.DisplayName -like "*Active Directory*"
    }
    
    if ($serviciosAD) {
        Write-Host "Servicios de Active Directory encontrados:" -ForegroundColor Cyan
        $serviciosAD | Format-Table Name, DisplayName, Status, StartType -AutoSize
        return $serviciosAD
    } else {
        Write-Host "No se encontraron servicios de Active Directory" -ForegroundColor Yellow
        return $null
    }
}
```

### Integración con el Sistema de Monitoreo

Los servicios de Active Directory pueden añadirse al sistema de seguimiento para su monitoreo continuo:

```powershell
# Añadir servicios de AD al seguimiento
$serviciosAD = @(
    [PSCustomObject]@{
        Nombre = "NTDS"
        DisplayName = "Active Directory Domain Services"
        Estado = (Get-Service -Name "NTDS" -ErrorAction SilentlyContinue).Status
        TipoInicio = (Get-Service -Name "NTDS" -ErrorAction SilentlyContinue).StartType
        Descripcion = "Servicio principal de Active Directory Domain Services"
        PID = (Get-CimInstance Win32_Service -Filter "Name='NTDS'" -ErrorAction SilentlyContinue).ProcessId
    },
    [PSCustomObject]@{
        Nombre = "DNS"
        DisplayName = "DNS Server"
        Estado = (Get-Service -Name "DNS" -ErrorAction SilentlyContinue).Status
        TipoInicio = (Get-Service -Name "DNS" -ErrorAction SilentlyContinue).StartType
        Descripcion = "Servicio DNS necesario para Active Directory"
        PID = (Get-CimInstance Win32_Service -Filter "Name='DNS'" -ErrorAction SilentlyContinue).ProcessId
    },
    [PSCustomObject]@{
        Nombre = "Netlogon"
        DisplayName = "Netlogon"
        Estado = (Get-Service -Name "Netlogon" -ErrorAction SilentlyContinue).Status
        TipoInicio = (Get-Service -Name "Netlogon" -ErrorAction SilentlyContinue).StartType
        Descripcion = "Servicio de autenticación de dominio"
        PID = (Get-CimInstance Win32_Service -Filter "Name='Netlogon'" -ErrorAction SilentlyContinue).ProcessId
    }
)

# Exportar a CSV
$serviciosAD | Export-Csv -Path "Servicios-Seguimiento.csv" -Append -NoTypeInformation
```

--- -->

## Criterios de Evaluación

<!-- El proyecto será evaluado según los siguientes criterios (ver [Rúbrica de Evaluación](Rubrica_Evaluacion_RetoPowerShell.md) para más detalles): -->

1. **Funcionalidad (15 puntos)**

   - Sistema completamente funcional
   - Todas las funcionalidades requeridas implementadas
   - Sin errores de ejecución
   - Manejo correcto de errores con `try-catch`

2. **Estructura del Código (5 puntos)**

   - Código organizado y modular
   - Comentarios detallados en cada línea
   - Separación clara de responsabilidades
   - Nombres descriptivos siguiendo convenciones PowerShell (Verbo-Sustantivo)

3. **Uso de Conceptos PowerShell (5 puntos)**

   - Uso correcto de todas las técnicas aprendidas
   - Variables tipadas correctamente
   - Bucles, funciones y estructuras bien implementadas
   - Uso adecuado de cmdlets de PowerShell
   - Trabajo correcto con objetos y colecciones

4. **Documentación (3 puntos)**

   - README.md completo y profesional
   - Instrucciones claras de instalación y uso
   - Documentación de cada módulo
   - Capturas de pantalla

5. **Defensa del Proyecto y Testing (2 puntos)**

   - Demostración fluida y completa del sistema funcionando
   - Testing exhaustivo de todas las funcionalidades principales
   - Explicación clara del código y decisiones de diseño
   - Respuestas precisas a las preguntas del profesor
   - Duración adecuada (20-30 minutos)
   - Preparación previa evidente

**Total: 30 puntos**

### Puntos Extra (Hasta +8 puntos)

- **Interfaz gráfica con Windows Forms** (+3 puntos)
- **Integración con Event Viewer** (+2 puntos)
- **Gráficos ASCII con estadísticas** (+2 puntos)
- **Notificaciones del sistema** (+1 punto)
- **Exportación a HTML/XML** (+1 punto)

---

## Instrucciones de Entrega

### Estructura de Entrega

1. **Crear directorio** con el nombre: `reto_grupal_[nombre1]_[nombre2]`
2. **Incluir todos los archivos** del proyecto:

   - Scripts `.ps1` con permisos de ejecución
   - Archivo de configuración `.csv`
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

- Todos los scripts deben tener extensión `.ps1`
- Todos los scripts deben seguir la política de ejecución de PowerShell
- El código debe estar completamente comentado
- El sistema debe funcionar sin errores
- Debe incluir manejo de errores con `try-catch`
- Usar nombres de funciones siguiendo convención Verbo-Sustantivo (ej: `Get-Servicio`, `Start-Servicio`)

### Política de Ejecución de Scripts

Si encuentras problemas con la política de ejecución, puedes usar:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

O ejecutar scripts individuales con:

```powershell
powershell -ExecutionPolicy Bypass -File .\Menu-Principal.ps1
```

### Defensa del Proyecto

Además de los requisitos de entrega mencionados anteriormente, **se debe preparar la defensa del proyecto con testing**. La defensa tendrá una duración de **entre 20 y 30 minutos** y debe incluir:

- **Demostración en vivo** del sistema funcionando
- **Testing de las funcionalidades** principales del sistema
- **Explicación del código** y decisiones de diseño
- **Respuesta a preguntas** del profesor sobre la implementación

**Preparación recomendada:**

- Probar todas las funcionalidades antes de la defensa
- Preparar ejemplos de uso para cada módulo
- Documentar casos de prueba y resultados esperados
- Estar preparado para explicar cualquier parte del código

---

## Ejemplo de Funcionamiento

### Menú Principal

```
==========================================
    SISTEMA DE GESTIÓN DE SERVICIOS
==========================================

1) Gestión de servicios
2) Monitoreo del sistema
3) Copias de seguridad
4) Configuración del sistema
5) Salir

Selecciona una opción:
```

### Gestión de Servicios

```
==========================================
    GESTIÓN DE SERVICIOS
==========================================

1) Listar servicios
2) Añadir servicio al seguimiento
3) Buscar servicio
4) Modificar seguimiento
5) Eliminar de seguimiento
6) Controlar servicio (Iniciar/Detener)
7) Volver al menú principal

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

- Usar nombres descriptivos siguiendo convención Verbo-Sustantivo
- Comentar cada línea de código importante
- Validar entradas del usuario con operadores de comparación
- Manejar errores de forma adecuada con `try-catch`
- Mantener el código organizado y limpio
- Usar tipado explícito cuando sea necesario
- Trabajar con objetos en lugar de texto cuando sea posible

### Depuración

- Usar `Set-PSBreakpoint` para establecer puntos de interrupción
- Usar `Write-Host` con colores para depuración visual
- Probar cada función individualmente
- Verificar permisos de ejecución de scripts
- Usar `Get-Help` para consultar ayuda de cmdlets

### Cmdlets Útiles

- `Get-Help <cmdlet>` - Obtener ayuda de un cmdlet
- `Get-Command` - Listar comandos disponibles
- `Get-Member` - Ver propiedades y métodos de objetos
- `Format-Table`, `Format-List` - Formatear salida
- `Where-Object`, `Select-Object` - Filtrar y seleccionar objetos

---

## Recursos y Referencias

- [Documentación del tema PowerShell](02PowerShell.md)
- [Microsoft PowerShell Documentation](https://docs.microsoft.com/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)


<!-- ## Fechas Importantes

- **Fecha de inicio:** Sesión 4
- **Fecha de entrega:** Sesión 6
- **Presentación:** Sesión 6 -->

---

!!! success "¡Éxito en el reto!"
    Este reto te permitirá demostrar todos los conocimientos adquiridos durante la unidad de PowerShell. ¡Trabaja en equipo, planifica bien y documenta todo!

