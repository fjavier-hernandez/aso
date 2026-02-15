---
title: Reto Grupal - Active Directory Completo
description: Reto que integra todas las prácticas de Active Directory en un único ejercicio de 2 horas con automatización mediante PowerShell
subtitle: Reto Grupal Active Directory
---

# RETO: Active Directory Completo — TechCorp Solutions

**Módulo:** Administración de Sistemas Operativos (ASO)  
**Unidad:** Servicios de Directorio (Active Directory)  
**Modalidad:** Trabajo en grupo (individual)  
**Puntuación:** 30 puntos — [Ver rúbrica de evaluación](Rubrica_RetoGrupalActiveDirectory.md)  
**Criterios evaluados:** CE3a, CE3b, CE3c, CE3d, CE3e, CE3f, CE3g y CE3h  
**Duración estimada:** 2 horas  

Este reto integra en un único ejercicio las prácticas [PR401](PracticaActiveDirectoryAWS.md), [PR402](PracticaUsuariosGruposAD.md), [PR403](PracticaGestionGruposAD.md) y [PR404](PracticaRecursosCompartidosAD.md).

---

## Contexto: TechCorp Solutions

**TechCorp Solutions** es una empresa ficticia de consultoría tecnológica con **20 empleados** distribuidos en 5 departamentos. Necesitas configurar desde cero su infraestructura de Active Directory en AWS Academy: dominio, usuarios, grupos, recursos compartidos y directivas de grupo.

### Estructura organizativa

| Departamento | Usuarios | Descripción |
|--------------|----------|-------------|
| **Gerencia** | 2 | Dirección y gestión |
| **IT** | 5 | Soporte técnico y sistemas |
| **Administracion** | 4 | Contabilidad y administración |
| **Comercial** | 5 | Ventas y atención al cliente |
| **RRHH** | 4 | Recursos humanos |

**Total: 20 usuarios**

---

## Distribución del tiempo (2 horas)

| Fase | Tarea | Tiempo | Automatización |
|------|-------|--------|----------------|
| **0** | AWS: Instancias, DHCP, Security Groups | 15 min | Manual (consola AWS) |
| **1** | AD: Instalación, DC, usuario admin | 15 min | Parcial (PowerShell) |
| **2** | OUs, 20 usuarios, grupos | 20 min | **PowerShell (CSV)** |
| **3** | Unir cliente al dominio, RDP | 15 min | Manual + PowerShell |
| **4** | Carpetas compartidas, permisos, carpetas personales | 25 min | **PowerShell** |
| **5** | GPO: contraseñas y bloqueo | 15 min | Manual (GPO) |
| **6** | Verificación y documentación | 15 min | PowerShell + capturas |

---

## Entregables

1. **Documento Markdown** con:

   - Capturas de la estructura de OUs y usuarios en AD.
   - Capturas de los recursos compartidos y permisos.
   - Capturas de las GPO configuradas.
   - Salida del script de verificación.
   - Explicación breve de cada fase y comandos utilizados.

2. **Scripts PowerShell** utilizados (02-CrearEstructuraAD.ps1, 04-RecursosCompartidos.ps1).

3. **Archivo CSV** con los 20 usuarios de TechCorp.

---

## Fase 0: Preparación en AWS (15 min)

Sigue la [PR302/PR401](PracticaActiveDirectoryAWS.md) para:

1. Crear **2 instancias** Windows Server 2025 en EC2 (servidor + cliente).
2. Configurar **DHCP** en AWS con nombre de dominio (ej: `techcorp.local`) y IP del servidor como DNS.
3. Configurar **Security Group** con puertos de AD (53, 88, 135, 389, 445, 636, 3268, 3269, 49152-65535).
4. Reiniciar instancias y anotar IP privada del servidor.

---

## Fase 1: Instalación de Active Directory (15 min)

### 1.1 Configurar nombre del servidor

```powershell
Rename-Computer -NewName "DC01" -Restart
```

### 1.2 Instalar AD y promover a DC

```powershell
# Instalar rol AD DS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promover a controlador de dominio (ajusta dominio y contraseña)
$dominio = "techcorp.local"
$contraseñaSafeMode = ConvertTo-SecureString "TechCorp2025!" -AsPlainText -Force
Install-ADDSForest -DomainName $dominio -DomainMode WinThreshold -ForestMode WinThreshold -SafeModeAdministratorPassword $contraseñaSafeMode -Force
# Reinicia automáticamente
```

### 1.3 Crear usuario administrador del dominio

Tras el reinicio, conecta por RDP y ejecuta:

```powershell
$pass = ConvertTo-SecureString "Admin2025!" -AsPlainText -Force
New-ADUser -Name "admin.dominio" -SamAccountName "admin.dominio" -AccountPassword $pass -Enabled $true -PasswordNeverExpires $true
Add-ADGroupMember -Identity "Domain Admins" -Members "admin.dominio"
```

---

## Fase 2: OUs, usuarios y grupos (20 min)

### 2.1 Crear archivo CSV de usuarios

Guarda como `C:\Scripts\techcorp_usuarios.csv`:

```csv
Nombre,Apellido,InicioSesion,Posicion,Contraseña,OU
Ana,Garcia,ana.garcia,Directora General,garcia1,Gerencia
Carlos,Ruiz,carlos.ruiz,Gerente,ruiz1,Gerencia
Pep,Terron,pep.terron,Responsable IT,terron1,IT
Laura,Mendez,laura.mendez,Tecnico IT,mendez1,IT
David,Sanz,david.sanz,Tecnico IT,sanz1,IT
Elena,Vidal,elena.vidal,Tecnico IT,vidal1,IT
Fran,Delgado,fran.delgado,Responsable Admin,delgado1,Administracion
Maria,Lopez,maria.lopez,Contable,lopez1,Administracion
Javier,Ortega,javier.ortega,Contable,ortega1,Administracion
Sofia,Navarro,sofia.navarro,Administrativa,navarro1,Administracion
Marcos,Sabates,marcos.sabates,Responsable Comercial,sabates1,Comercial
Paula,Jimenez,paula.jimenez,Comercial,jimenez1,Comercial
Roberto,Castro,roberto.castro,Comercial,castro1,Comercial
Claudia,Moreno,claudia.moreno,Comercial,moreno1,Comercial
Irene,Masot,irene.masot,Responsable RRHH,masot1,RRHH
Alberto,Diaz,alberto.diaz,Tecnico RRHH,diaz1,RRHH
Nuria,Serrano,nuria.serrano,Tecnico RRHH,serrano1,RRHH
Luis,Torres,luis.torres,Comercial,torres1,Comercial
Rosa,Iglesias,rosa.iglesias,Tecnico IT,iglesias1,IT
Pedro,Ramos,pedro.ramos,Tecnico RRHH,ramos1,RRHH
```

!!! note "20 usuarios"
    El CSV incluye 20 usuarios (2 Gerencia, 5 IT, 4 Administración, 5 Comercial, 4 RRHH).

### 2.2 Script completo: OUs, usuarios y grupos

Guarda como `C:\Scripts\02-CrearEstructuraAD.ps1`:

```powershell
# Requiere: ejecutar como Administrador tras instalar AD
Import-Module ActiveDirectory

$domain = "techcorp.local"
$domainDN = (Get-ADDomain).DistinguishedName
$baseOU = "OU=TechCorp,$domainDN"
$csvPath = "C:\Scripts\techcorp_usuarios.csv"

# 1. Crear OU raíz y sub-OUs por departamento
$departamentos = @("Gerencia", "IT", "Administracion", "Comercial", "RRHH")
New-ADOrganizationalUnit -Name "TechCorp" -Path $domainDN
foreach ($dept in $departamentos) {
    New-ADOrganizationalUnit -Name $dept -Path $baseOU -ErrorAction SilentlyContinue
}

# 2. Crear usuarios desde CSV
$usuarios = Import-Csv -Path $csvPath -Encoding UTF8
foreach ($u in $usuarios) {
    $ouPath = "OU=$($u.OU),$baseOU"
    $pass = ConvertTo-SecureString $u.Contraseña -AsPlainText -Force
    try {
        New-ADUser -Name "$($u.Nombre) $($u.Apellido)" -GivenName $u.Nombre -Surname $u.Apellido `
            -SamAccountName $u.InicioSesion -UserPrincipalName "$($u.InicioSesion)@$domain" `
            -Path $ouPath -AccountPassword $pass -PasswordNeverExpires $true -Enabled $true -Description $u.Posicion
        Write-Host "OK: $($u.InicioSesion)" -ForegroundColor Green
    } catch { Write-Host "Error $($u.InicioSesion): $_" -ForegroundColor Red }
}

# 3. Crear grupos por departamento
$grupos = @("Gerencia_Usuarios", "IT_Usuarios", "Administracion_Usuarios", "Comercial_Usuarios", "RRHH_Usuarios")
foreach ($g in $grupos) {
    New-ADGroup -Name $g -GroupScope Global -GroupCategory Security -Path $baseOU -ErrorAction SilentlyContinue
}

# 4. Añadir usuarios a sus grupos
$mapOU = @{ Gerencia = "Gerencia_Usuarios"; IT = "IT_Usuarios"; Administracion = "Administracion_Usuarios"; Comercial = "Comercial_Usuarios"; RRHH = "RRHH_Usuarios" }
foreach ($u in $usuarios) {
    $grupo = $mapOU[$u.OU]
    if ($grupo) { Add-ADGroupMember -Identity $grupo -Members $u.InicioSesion -ErrorAction SilentlyContinue }
}

Write-Host "`nEstructura creada. Usuarios: $($usuarios.Count)" -ForegroundColor Cyan
```

Ejecuta: `.\02-CrearEstructuraAD.ps1`

---

## Fase 3: Unir cliente al dominio y RDP (15 min)

1. En el **cliente**, verifica DNS: `nslookup techcorp.local`
2. Une al dominio: `Add-Computer -DomainName "techcorp.local" -Credential (Get-Credential "techcorp\admin.dominio")`
3. Reinicia: `Restart-Computer`
4. En el **servidor**, habilita RDP para Domain Users:

```powershell
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "Domain Users"
```

---

## Fase 4: Recursos compartidos y carpetas personales (25 min)

Guarda como `C:\Scripts\04-RecursosCompartidos.ps1`:

```powershell
# Requiere: ejecutar en el DC como Administrador
Import-Module ActiveDirectory
$dominio = (Get-ADDomain).NetBIOSName
$servidor = $env:COMPUTERNAME

# 1. Estructura de carpetas
New-Item -Path "C:\TechCorp_Users" -ItemType Directory -Force
New-Item -Path "C:\TechCorp_Datos" -ItemType Directory -Force
@("Gerencia", "IT", "Administracion", "Comercial", "RRHH") | ForEach-Object {
    New-Item -Path "C:\TechCorp_Datos\$_" -ItemType Directory -Force
}

# 2. Compartir carpetas
New-SmbShare -Name "TechCorp_Users" -Path "C:\TechCorp_Users" -ChangeAccess "Domain Users"
New-SmbShare -Name "TechCorp_Datos" -Path "C:\TechCorp_Datos" -ReadAccess "Domain Users"

# 3. Carpetas personales y permisos NTFS por usuario
$usuarios = Get-ADUser -Filter * -SearchBase "OU=TechCorp,$((Get-ADDomain).DistinguishedName)" -SearchScope Subtree | Where-Object { $_.Enabled }
foreach ($u in $usuarios) {
    $userPath = "C:\TechCorp_Users\$($u.SamAccountName)"
    New-Item -Path $userPath -ItemType Directory -Force
    $acl = Get-Acl $userPath
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dominio\$($u.SamAccountName)", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
    $acl.AddAccessRule($rule)
    Set-Acl $userPath $acl
    Set-ADUser -Identity $u.SamAccountName -HomeDrive "X:" -HomeDirectory "\\$servidor\TechCorp_Users\$($u.SamAccountName)"
}
Write-Host "Carpetas personales configuradas para $($usuarios.Count) usuarios" -ForegroundColor Green
```

Ejecuta: `.\04-RecursosCompartidos.ps1`

---

## Fase 5: GPO de contraseñas y bloqueo (15 min)

Abre **Administración de directivas de grupo** (`gpmc.msc`) → Editar **Default Domain Policy**:

1. **Directivas de contraseña**: Vigencia 90 días, historial 5, longitud mínima 4, sin complejidad.
2. **Directiva de bloqueo**: 4 intentos, restablecer contador 10 min, duración bloqueo 0 (manual).

En el cliente: `gpupdate /force`

---

## Fase 6: Verificación (15 min)

### Script de verificación

```powershell
# Ejecutar en el DC
Write-Host "=== VERIFICACIÓN RETO TECHCORP ===" -ForegroundColor Cyan
Write-Host "`n1. Dominio:" -ForegroundColor Yellow
Get-ADDomain | Select-Object Name, DNSRoot

Write-Host "`n2. Usuarios por OU:" -ForegroundColor Yellow
Get-ADOrganizationalUnit -Filter * -SearchBase "OU=TechCorp,$((Get-ADDomain).DistinguishedName)" | ForEach-Object {
    $count = (Get-ADUser -Filter * -SearchBase $_.DistinguishedName).Count
    Write-Host "   $($_.Name): $count usuarios"
}

Write-Host "`n3. Recursos compartidos:" -ForegroundColor Yellow
Get-SmbShare | Where-Object { $_.Name -like "TechCorp*" } | Format-Table Name, Path -AutoSize

Write-Host "`n4. Carpetas personales asignadas:" -ForegroundColor Yellow
Get-ADUser -Filter * -SearchBase "OU=TechCorp,$((Get-ADDomain).DistinguishedName)" -Properties HomeDirectory | 
    Where-Object { $_.HomeDirectory } | Select-Object SamAccountName, HomeDirectory | Format-Table -AutoSize
```

### Comprobaciones manuales

1. Inicia sesión en el cliente con `ana.garcia` (o cualquier usuario).
2. Verifica que aparece la unidad **X:** (carpeta personal).
3. Crea un archivo en X:\ y comprueba que se guarda.
4. Accede a `\\DC01\TechCorp_Datos` y verifica permisos por departamento.

---

## Criterios de evaluación

| Criterio | Puntos |
|----------|--------|
| Dominio AD instalado y DC funcionando | 3 |
| OUs creadas correctamente | 2 |
| 20 usuarios creados desde CSV en sus OUs | 5 |
| Grupos creados y usuarios asignados | 3 |
| Cliente unido al dominio y RDP funcionando | 3 |
| Recursos compartidos y carpetas personales | 5 |
| GPO de contraseñas y bloqueo configuradas | 3 |
| Verificación exitosa y documentación | 3 |
| **Uso de PowerShell** (automatización) | 3 |
| **Total** | **30** |

> **Ver rúbrica de evaluación:** [Rúbrica del reto — criterios y niveles](Rubrica_RetoGrupalActiveDirectory.md) (para conocer cómo se valorará cada criterio).

---

<!-- ## Referencias

- [PR401: Configuración de Active Directory en AWS](PracticaActiveDirectoryAWS.md)
- [PR402: Administración de Usuarios y Grupos](PracticaUsuariosGruposAD.md)
- [PR403: Gestión de Grupos y Unidades Organizativas](PracticaGestionGruposAD.md)
- [PR404: Gestión de recursos compartidos](PracticaRecursosCompartidosAD.md) -->
