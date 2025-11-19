---
title: Configuración de Active Directory
description: Guía completa de instalación y configuración de Active Directory Domain Services
---

# Configuración de Active Directory Domain Services

## Descripción

**Active Directory Domain Services (AD DS)** es un servicio crítico de Windows Server que gestiona la información de usuarios, equipos y recursos de red en un dominio. Esta guía muestra cómo instalar y configurar Active Directory usando PowerShell.

## Paso 1: Instalación de Active Directory Domain Services

Para instalar el rol de Active Directory Domain Services en Windows Server, utiliza el siguiente comando de PowerShell:

```powershell
# Instalar el rol de Active Directory Domain Services
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# O usando el módulo ServerManager (método alternativo)
Add-WindowsFeature AD-Domain-Services
```

**Explicación del comando:**

- `Install-WindowsFeature`: Cmdlet de PowerShell para instalar roles y características de Windows Server
- `-Name AD-Domain-Services`: Especifica el nombre del rol a instalar
- `-IncludeManagementTools`: Incluye las herramientas de administración (RSAT) necesarias para gestionar AD DS

**Requisitos previos:**

- Sistema operativo Windows Server (no funciona en Windows 10/11 cliente)
- Permisos de administrador
- Acceso a los archivos de instalación de Windows Server

## Paso 2: Verificación del Funcionamiento

Una vez instalado, verifica que Active Directory está funcionando correctamente con los siguientes comandos:

### Verificar que el servicio está instalado:

```powershell
# Verificar que el rol está instalado
Get-WindowsFeature -Name AD-Domain-Services

# Verificar servicios relacionados con Active Directory
Get-Service | Where-Object {$_.DisplayName -like "*Active Directory*" -or $_.DisplayName -like "*Domain*"}
```

### Verificar servicios de Active Directory:

```powershell
# Listar todos los servicios de Active Directory
Get-Service | Where-Object {
    $_.Name -like "*NTDS*" -or 
    $_.Name -like "*DNS*" -or 
    $_.Name -like "*Netlogon*" -or
    $_.DisplayName -like "*Active Directory*"
} | Format-Table Name, DisplayName, Status, StartType -AutoSize
```

### Verificar estado del servicio NTDS (Active Directory Domain Services):

```powershell
# Verificar el servicio principal de AD DS
$ntdsService = Get-Service -Name "NTDS" -ErrorAction SilentlyContinue

if ($ntdsService) {
    Write-Host "Servicio NTDS encontrado" -ForegroundColor Green
    Write-Host "Estado: $($ntdsService.Status)" -ForegroundColor Yellow
    Write-Host "Tipo de inicio: $($ntdsService.StartType)" -ForegroundColor Yellow
} else {
    Write-Host "Servicio NTDS no encontrado. Active Directory puede no estar configurado." -ForegroundColor Red
}
```

### Verificar configuración del dominio:

```powershell
# Verificar si el servidor es un controlador de dominio
$domainController = (Get-WmiObject Win32_ComputerSystem).DomainRole

switch ($domainController) {
    0 { Write-Host "Equipo independiente" -ForegroundColor Yellow }
    1 { Write-Host "Miembro del dominio" -ForegroundColor Yellow }
    4 { Write-Host "Controlador de dominio de respaldo" -ForegroundColor Green }
    5 { Write-Host "Controlador de dominio principal" -ForegroundColor Green }
    default { Write-Host "Estado desconocido" -ForegroundColor Red }
}

# Obtener información del dominio
try {
    $domain = Get-ADDomain -ErrorAction Stop
    Write-Host "Nombre del dominio: $($domain.Name)" -ForegroundColor Green
    Write-Host "Nombre NetBIOS: $($domain.NetBIOSName)" -ForegroundColor Green
    Write-Host "Nivel funcional del dominio: $($domain.DomainMode)" -ForegroundColor Green
} catch {
    Write-Host "No se pudo obtener información del dominio. Verifica que AD DS esté configurado." -ForegroundColor Red
}
```

### Verificar módulo de Active Directory:

```powershell
# Verificar si el módulo de Active Directory está disponible
$adModule = Get-Module -ListAvailable -Name ActiveDirectory

if ($adModule) {
    Write-Host "Módulo Active Directory encontrado" -ForegroundColor Green
    Write-Host "Versión: $($adModule.Version)" -ForegroundColor Yellow
    
    # Importar el módulo
    Import-Module ActiveDirectory
    
    # Listar cmdlets disponibles
    Write-Host "`nCmdlets disponibles:" -ForegroundColor Cyan
    Get-Command -Module ActiveDirectory | Select-Object -First 10 Name
} else {
    Write-Host "Módulo Active Directory no encontrado. Instálalo con:" -ForegroundColor Red
    Write-Host "Install-WindowsFeature RSAT-AD-PowerShell" -ForegroundColor Yellow
}
```

## Script Completo de Verificación

```powershell
# Verificar-ADDS.ps1
# Script completo para verificar la instalación y funcionamiento de Active Directory

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "VERIFICACIÓN DE ACTIVE DIRECTORY" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Paso 1: Verificar instalación del rol
Write-Host "1. Verificando instalación del rol AD-DS..." -ForegroundColor Yellow
$feature = Get-WindowsFeature -Name AD-Domain-Services

if ($feature.InstallState -eq "Installed") {
    Write-Host "   ✓ Rol AD-Domain-Services instalado" -ForegroundColor Green
} else {
    Write-Host "   ✗ Rol AD-Domain-Services NO instalado" -ForegroundColor Red
    Write-Host "   Para instalar ejecuta: Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools" -ForegroundColor Yellow
}

Write-Host ""

# Paso 2: Verificar servicios
Write-Host "2. Verificando servicios de Active Directory..." -ForegroundColor Yellow
$services = Get-Service | Where-Object {
    $_.Name -like "*NTDS*" -or 
    $_.Name -like "*DNS*" -or 
    $_.Name -like "*Netlogon*"
}

if ($services) {
    foreach ($service in $services) {
        $color = if ($service.Status -eq "Running") { "Green" } else { "Red" }
        Write-Host "   $($service.Name): $($service.Status)" -ForegroundColor $color
    }
} else {
    Write-Host "   ✗ No se encontraron servicios de Active Directory" -ForegroundColor Red
}

Write-Host ""

# Paso 3: Verificar si es controlador de dominio
Write-Host "3. Verificando rol del servidor..." -ForegroundColor Yellow
$domainRole = (Get-CimInstance Win32_ComputerSystem).DomainRole

switch ($domainRole) {
    {$_ -in 4, 5} { 
        Write-Host "   ✓ Este servidor es un Controlador de Dominio" -ForegroundColor Green 
    }
    default { 
        Write-Host "   ✗ Este servidor NO es un Controlador de Dominio" -ForegroundColor Red 
    }
}

Write-Host ""

# Paso 4: Verificar módulo de PowerShell
Write-Host "4. Verificando módulo de Active Directory..." -ForegroundColor Yellow
$adModule = Get-Module -ListAvailable -Name ActiveDirectory

if ($adModule) {
    Write-Host "   ✓ Módulo Active Directory disponible" -ForegroundColor Green
    Import-Module ActiveDirectory -ErrorAction SilentlyContinue
    
    # Intentar obtener información del dominio
    try {
        $domain = Get-ADDomain -ErrorAction Stop
        Write-Host "   ✓ Dominio configurado: $($domain.Name)" -ForegroundColor Green
    } catch {
        Write-Host "   ⚠ Dominio no configurado o no accesible" -ForegroundColor Yellow
    }
} else {
    Write-Host "   ✗ Módulo Active Directory no encontrado" -ForegroundColor Red
    Write-Host "   Para instalar ejecuta: Install-WindowsFeature RSAT-AD-PowerShell" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
```

## Integración con el Sistema de Gestión

Los servicios de Active Directory pueden añadirse al sistema de seguimiento:

```powershell
# Añadir servicios de AD al seguimiento
$serviciosAD = @(
    [PSCustomObject]@{
        Nombre = "NTDS"
        DisplayName = "Active Directory Domain Services"
        Estado = (Get-Service -Name "NTDS" -ErrorAction SilentlyContinue).Status
        TipoInicio = (Get-Service -Name "NTDS" -ErrorAction SilentlyContinue).StartType
        Descripcion = "Servicio principal de Active Directory Domain Services"
        PID = (Get-CimInstance Win32_Service -Filter "Name='NTDS'").ProcessId
    },
    [PSCustomObject]@{
        Nombre = "DNS"
        DisplayName = "DNS Server"
        Estado = (Get-Service -Name "DNS" -ErrorAction SilentlyContinue).Status
        TipoInicio = (Get-Service -Name "DNS" -ErrorAction SilentlyContinue).StartType
        Descripcion = "Servicio DNS necesario para Active Directory"
        PID = (Get-CimInstance Win32_Service -Filter "Name='DNS'").ProcessId
    },
    [PSCustomObject]@{
        Nombre = "Netlogon"
        DisplayName = "Netlogon"
        Estado = (Get-Service -Name "Netlogon" -ErrorAction SilentlyContinue).Status
        TipoInicio = (Get-Service -Name "Netlogon" -ErrorAction SilentlyContinue).StartType
        Descripcion = "Servicio de autenticación de dominio"
        PID = (Get-CimInstance Win32_Service -Filter "Name='Netlogon'").ProcessId
    }
)

# Exportar a CSV
$serviciosAD | Export-Csv -Path "Servicios-Seguimiento.csv" -Append -NoTypeInformation
```

## Cmdlets Útiles de Active Directory

Una vez instalado y configurado, puedes usar estos cmdlets:

```powershell
# Gestión de usuarios
Get-ADUser -Filter *
New-ADUser -Name "UsuarioPrueba" -SamAccountName "usuario.prueba"
Remove-ADUser -Identity "usuario.prueba"

# Gestión de grupos
Get-ADGroup -Filter *
New-ADGroup -Name "GrupoPrueba" -GroupScope Global
Add-ADGroupMember -Identity "GrupoPrueba" -Members "usuario.prueba"

# Gestión de equipos
Get-ADComputer -Filter *
New-ADComputer -Name "EquipoPrueba"

# Información del dominio
Get-ADDomain
Get-ADForest
Get-ADDomainController
```

## Consideraciones Importantes

- **Solo en Windows Server:** Active Directory solo está disponible en Windows Server, no en Windows 10/11
- **Permisos de administrador:** Se requieren permisos elevados para instalar y configurar
- **Reinicio necesario:** Puede requerir reinicio después de la instalación
- **Configuración adicional:** Después de instalar el rol, se debe ejecutar `dcpromo` o usar `Install-ADDSForest` para configurar el dominio
- **Entorno de pruebas:** Se recomienda usar una máquina virtual para pruebas

