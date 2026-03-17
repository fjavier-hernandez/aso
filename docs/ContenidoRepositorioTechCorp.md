---
title: Contenido del repositorio TechCorp AD IaC
description: Guía detallada de los archivos del repositorio techcorp-ad-iac, con explicación de comandos y uso
---

# Contenido detallado del repositorio techcorp-ad-iac

Esta página describe **todos los archivos** del repositorio de referencia [techcorp-ad-iac](https://github.com/fjavier-hernandez/techcorp-ad-iac), su función y los comandos o bloques que utilizan, para que puedas entender y depurar el despliegue automatizado con Terraform y PowerShell.

---

## Estructura general

```
techcorp-ad-iac/
├── terraform/                    # Infraestructura como código (AWS)
│   ├── provider.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   ├── userdata_dc01.ps1.tpl
│   └── userdata_cliente.ps1.tpl
└── scripts/                      # Configuración interna de las instancias
    ├── dc01/
    │   ├── 01-xxxx.ps1            # Instalación AD y promoción a DC
    │   ├── 02-xxxx.ps1            # OUs, usuarios desde CSV, grupos
    │   ├── 03-xxxx.ps1            # Usuario admin dominio / RDP
    │   ├── 04-xxxx.ps1            # Carpetas compartidas y carpetas personales
    │   ├── 05-xxxx.ps1            # GPO (directivas de grupo)
    │   └── techcorp_usuarios.csv
    └── cliente/
        └── 01-join-domain.ps1     # Unir al dominio
```

Los nombres concretos de los scripts en `dc01/` pueden variar (por ejemplo `01-Install-AD.ps1`, `02-CrearEstructuraAD.ps1`), pero el **orden numérico** indica la secuencia de ejecución.

---

## Carpeta `terraform/`

### `provider.tf`

**Propósito:** Configurar el proveedor de AWS que usará Terraform.

**Contenido típico:**

- Bloque `terraform` con `required_providers` para fijar la versión del provider `hashicorp/aws`.
- Bloque `provider "aws"` con `region = var.aws_region` (u otra variable) para que todos los recursos se creen en la región indicada.

**Por qué se usa:** Sin este archivo, Terraform no sabría con qué nube trabajar ni en qué región crear los recursos.

---

### `variables.tf`

**Propósito:** Declarar las variables que parametrizan el despliegue (región, AMI, tipo de instancia, contraseñas, nombre del key pair, etc.).

**Variables típicas:**

| Variable | Uso |
|----------|-----|
| `aws_region` | Región AWS (p. ej. `us-east-1`). |
| `key_name` | Nombre del key pair en EC2 para conectarse por RDP y obtener contraseña Windows. |
| `safe_mode_password` | Contraseña DSRM (recuperación del modo seguro de Active Directory). |
| `domain_admin_password` | Contraseña del usuario administrador del dominio. |
| `instance_type` | Tipo de instancia EC2 (p. ej. `t3.medium`). |
| `windows_ami` o `ami_id` | ID de la AMI de Windows Server. |

**Por qué se usa:** Permite cambiar región, AMI o contraseñas sin tocar el código; además, las contraseñas se pueden pasar mediante `terraform.tfvars` (que no debe subirse a un repositorio público).

---

### `main.tf`

**Propósito:** Definir la infraestructura en AWS: VPC, subred, grupos de seguridad, instancias EC2 (DC01 y cliente) y opcionalmente DHCP Options para el nombre de dominio.

**Recursos típicos y comandos/bloques:**

1. **VPC**  
   - `resource "aws_vpc"` con `cidr_block` (p. ej. `10.0.0.0/16`).  
   - Sirve para aislar la red de las instancias.

2. **Subred**  
   - `resource "aws_subnet"` asociada a la VPC, con `cidr_block` (p. ej. `10.0.1.0/24`) y `map_public_ip_on_launch = true` si las instancias deben tener IP pública.  
   - Las instancias se lanzan en esta subred.

3. **Internet Gateway y tabla de rutas**  
   - `aws_internet_gateway` y `aws_route_table` con ruta `0.0.0.0/0` al gateway.  
   - Permiten que las instancias accedan a internet (actualizaciones, descargas).

4. **Grupos de seguridad (Security Groups)**  
   - Reglas de entrada: RDP (3389), tráfico entre instancias (puertos de AD: 53, 88, 135, 389, 445, 636, 3268, 3269, 49152-65535), etc.  
   - Sin estos puertos, el dominio y el RDP no funcionarían correctamente.

5. **Instancia EC2 — DC01 (controlador de dominio)**  
   - `resource "aws_instance" "dc01"` con:
     - `ami`, `instance_type`, `subnet_id`, `vpc_security_group_ids`, `key_name`.
     - **`user_data`** = `templatefile("${path.module}/userdata_dc01.ps1.tpl", { ... })`.  
   - Terraform sustituye las variables en la plantilla y pasa el script de PowerShell como *user data*; AWS lo ejecuta al primer arranque de la instancia.

6. **Instancia EC2 — Cliente**  
   - `resource "aws_instance" "cliente"` con:
     - `user_data` = `templatefile("${path.module}/userdata_cliente.ps1.tpl", { ... })`.  
   - Suele incluir dependencia de `aws_instance.dc01` (`depends_on` o referencia a la IP del DC en el script) para que el cliente se configure después de que el DC esté disponible.

**Por qué se usa:** Todo el entorno (red + dos máquinas) se define en código y se puede repetir en otra cuenta o región cambiando solo variables.

---

### `outputs.tf`

**Propósito:** Exponer valores útiles tras `terraform apply`: IP pública del DC01, IP del cliente, etc., para poder conectarse por RDP.

**Contenido típico:**

- `output "dc01_public_ip" { value = aws_instance.dc01.public_ip }`
- `output "cliente_public_ip" { value = aws_instance.cliente.public_ip }`

**Por qué se usa:** No hace falta entrar en la consola de AWS para saber las IP; con `terraform output` las obtienes en la terminal.

---

### `terraform.tfvars.example`

**Propósito:** Plantilla de ejemplo de variables para que el usuario copie a `terraform.tfvars` y rellene sus propios valores (key pair, contraseñas, región).

**Contenido típico:** Mismas variables que en `variables.tf`, con valores de ejemplo o vacíos. El archivo real `terraform.tfvars` no debe subirse si contiene contraseñas.

---

### `userdata_dc01.ps1.tpl`

**Propósito:** Plantilla de script PowerShell que se ejecuta en la instancia **DC01** en el primer arranque (*user data*). Prepara el entorno (por ejemplo descargar scripts desde S3 o ejecutarlos inline) y ejecuta los scripts de `scripts/dc01/` en orden.

**Comandos/bloques típicos:**

- **Variables Terraform en la plantilla:** `<%= ... %>` para inyectar, por ejemplo, contraseña DSRM, contraseña del admin del dominio o rutas. Ejemplo: `$safeModePassword = '<%= safe_mode_password %>'`.
- **Descarga de scripts:** Si los scripts están en S3, uso de `aws s3 cp` o de `Invoke-WebRequest` para bajarlos a una carpeta local (p. ej. `C:\Scripts`).
- **Ejecución en orden:** Llamadas a `& "C:\Scripts\01-xxxx.ps1"`, `& "C:\Scripts\02-xxxx.ps1"`, etc., o un bucle que ejecute todos los `.ps1` por orden.
- **Reinicio:** Tras promover a DC, el sistema suele reiniciar; el *user data* puede programarse para que tras el reinicio continúe con los scripts siguientes (por ejemplo mediante tarea programada o comprobando si ya está promovido).

**Por qué se usa:** Terraform no ejecuta PowerShell dentro del Windows; solo envía este script. La plantilla permite pasar contraseñas y parámetros desde Terraform de forma segura (sin hardcodear en el repo).

---

### `userdata_cliente.ps1.tpl`

**Propósito:** Script de primer arranque de la instancia **cliente**. Espera a que el DC esté disponible (por nombre o IP inyectada por Terraform), une la máquina al dominio y puede habilitar RDP o ejecutar más configuración.

**Comandos/bloques típicos:**

- **Esperar al DC:** Bucle que hace `Test-NetConnection` o `nslookup` al dominio o IP del DC hasta que responda, para no ejecutar *join* antes de que AD esté listo.
- **Unir al dominio:**  
  `Add-Computer -DomainName "techcorp.local" -Credential (New-Object PSCredential("techcorp\admin.dominio", $pass)) -Restart`  
  (la contraseña puede venir de la plantilla `<%= domain_admin_password %>` convertida a `SecureString`).
- **Reinicio:** `Add-Computer` con `-Restart` reinicia la máquina para aplicar la unión al dominio.

**Por qué se usa:** El cliente debe unirse al dominio solo cuando el DC ya está promovido y operativo; este script automatiza la espera y la unión.

---

## Carpeta `scripts/dc01/`

Estos scripts se ejecutan **en el servidor DC01**, normalmente en el orden 01 → 05, tal como los invoca el *user data*.

---

### `01-xxxx.ps1` (instalación de AD y promoción a DC)

**Propósito:** Renombrar el equipo a DC01, instalar el rol AD DS y promover la máquina a controlador de dominio (crear bosque).

**Comandos principales:**

| Comando | Uso |
|---------|-----|
| `Rename-Computer -NewName "DC01" -Restart` | Opcional; si el nombre ya viene por imagen, puede no ser necesario. |
| `Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools` | Instala el rol de Active Directory y las herramientas de gestión. |
| `Install-ADDSForest -DomainName $dominio -DomainMode ... -ForestMode ... -SafeModeAdministratorPassword $contraseñaSafeMode -Force` | Crea el bosque y promueve el servidor a DC. La contraseña DSRM se pasa como `SecureString`. Tras esto, el servidor se reinicia. |

**Por qué se usan:** Sin este paso no hay dominio; el resto de scripts (OUs, usuarios, recursos compartidos) dependen de que exista el dominio.

---

### `02-xxxx.ps1` (OUs, usuarios desde CSV, grupos)

**Propósito:** Crear la estructura de OUs de TechCorp, crear los usuarios a partir del CSV y crear grupos por departamento y asignar usuarios.

**Comandos principales:**

| Comando / bloque | Uso |
|------------------|-----|
| `Import-Module ActiveDirectory` | Carga el módulo de AD para usar cmdlets de OUs y usuarios. |
| `Get-ADDomain` / `$domainDN` | Obtiene el DN del dominio para construir rutas como `OU=TechCorp,$domainDN`. |
| `New-ADOrganizationalUnit -Name "TechCorp" -Path $domainDN` | Crea la OU raíz. |
| `New-ADOrganizationalUnit -Name $dept -Path $baseOU` | Crea sub-OUs por departamento (Gerencia, IT, Administracion, Comercial, RRHH). |
| `Import-Csv -Path $csvPath` | Lee el archivo CSV de usuarios. |
| `New-ADUser -Name ... -SamAccountName ... -Path $ouPath -AccountPassword $pass ...` | Crea cada usuario en la OU que indique el CSV. |
| `New-ADGroup -Name $g -GroupScope Global -GroupCategory Security -Path $baseOU` | Crea grupos de seguridad por departamento. |
| `Add-ADGroupMember -Identity $grupo -Members $user` | Añade cada usuario al grupo de su departamento. |

**Por qué se usan:** Automatizan la creación de decenas de usuarios y la estructura organizativa sin hacerlo manualmente en la consola de AD.

---

### `03-xxxx.ps1` (usuario administrador del dominio y RDP)

**Propósito:** Crear el usuario administrador del dominio (p. ej. `admin.dominio`) y habilitar RDP para los usuarios del dominio.

**Comandos principales:**

| Comando | Uso |
|---------|-----|
| `New-ADUser -Name "admin.dominio" -SamAccountName "admin.dominio" -AccountPassword $pass -Enabled $true ...` | Crea el usuario admin del dominio. |
| `Add-ADGroupMember -Identity "Domain Admins" -Members "admin.dominio"` | Lo añade al grupo Domain Admins. |
| `Set-ItemProperty -Path 'HKLM:\...\Terminal Server' -Name "fDenyTSConnections" -Value 0` | Habilita conexiones RDP en el servidor. |
| `Enable-NetFirewallRule -DisplayGroup "Remote Desktop"` | Abre el firewall para RDP. |
| `Add-LocalGroupMember -Group "Remote Desktop Users" -Member "Domain Users"` | Permite a los usuarios del dominio conectarse por RDP. |

**Por qué se usan:** El usuario `admin.dominio` es el que se usa en el script del cliente para unir la máquina al dominio; RDP es necesario para administrar y verificar.

---

### `04-xxxx.ps1` (carpetas compartidas y carpetas personales)

**Propósito:** Crear carpetas compartidas (por ejemplo `TechCorp_Users` y `TechCorp_Datos` con subcarpetas por departamento), asignar permisos y configurar carpetas personales (home drive) para cada usuario.

**Comandos principales:**

| Comando | Uso |
|---------|-----|
| `New-Item -Path "C:\TechCorp_Users" -ItemType Directory -Force` | Crea la carpeta base de perfiles/carpetas personales. |
| `New-Item -Path "C:\TechCorp_Datos\$_" ...` | Crea subcarpetas por departamento en datos compartidos. |
| `New-SmbShare -Name "TechCorp_Users" -Path "C:\TechCorp_Users" -ChangeAccess "Domain Users"` | Comparte la carpeta y da permisos de cambio a Domain Users. |
| `New-SmbShare -Name "TechCorp_Datos" -Path "C:\TechCorp_Datos" -ReadAccess "Domain Users"` | Comparte datos con lectura para el dominio. |
| `Get-Acl` / `Set-Acl` + `FileSystemAccessRule` | Asigna permisos NTFS por usuario en su carpeta personal. |
| `Set-ADUser -Identity $u.SamAccountName -HomeDrive "X:" -HomeDirectory "\\$servidor\TechCorp_Users\$($u.SamAccountName)"` | Define la unidad de red y la ruta de la carpeta personal para cada usuario. |

**Por qué se usan:** Centralizan datos y perfiles en el servidor y permiten que cada usuario tenga su carpeta personal asignada automáticamente.

---

### `05-xxxx.ps1` (GPO — directivas de grupo)

**Propósito:** Aplicar directivas de grupo mediante PowerShell (por ejemplo política de contraseñas y de bloqueo de cuenta), en lugar de hacerlo solo desde la consola gráfica.

**Comandos principales:**

- Creación/vinculación de GPO con cmdlets de **GroupPolicy**: `New-GPO`, `New-GPLink` para enlazar la GPO al dominio o a una OU.
- Configuración de parámetros de contraseña y bloqueo mediante **registro** o **configuración de GPO** (por ejemplo `Set-GPRegistryValue` o importar una GPO de plantilla). Los valores típicos son: vigencia de contraseña, historial, longitud mínima, número de intentos de bloqueo y duración del bloqueo.

**Por qué se usa:** Garantiza que las directivas de contraseña y bloqueo queden aplicadas de forma repetible en cada despliegue.

---

### `techcorp_usuarios.csv`

**Propósito:** Lista de usuarios a crear en AD: nombre, apellido, nombre de inicio de sesión (SamAccountName), posición, contraseña inicial y OU de destino.

**Columnas típicas:** `Nombre`, `Apellido`, `InicioSesion`, `Posicion`, `Contraseña`, `OU`.

El script `02-xxxx.ps1` hace `Import-Csv` de este archivo y recorre las filas para crear cada usuario en la OU indicada. Así se pueden añadir o modificar usuarios editando solo el CSV.

---

## Carpeta `scripts/cliente/`

### `01-join-domain.ps1`

**Propósito:** Unir la máquina cliente al dominio `techcorp.local` usando las credenciales del administrador del dominio.

**Comandos principales:**

| Comando | Uso |
|---------|-----|
| `Add-Computer -DomainName "techcorp.local" -Credential $cred -Restart` | Une el equipo al dominio y reinicia. La credencial suele construirse con la contraseña inyectada por el *user data* (plantilla). |

Antes de este paso, el *user data* del cliente suele incluir una espera a que el DC responda (p. ej. comprobando conectividad o resolución DNS al nombre del dominio o IP del DC).

**Por qué se usa:** Es el paso mínimo necesario para que el cliente forme parte del dominio y los usuarios puedan iniciar sesión con cuentas de AD.

---

## Flujo de ejecución resumido

1. **Terraform** crea VPC, subred, security groups y lanza las dos instancias EC2 con `user_data` generado desde las plantillas.
2. **DC01:** Al primer arranque, Windows ejecuta `userdata_dc01.ps1.tpl` (con variables ya sustituidas), que descarga o ejecuta los scripts en `scripts/dc01/` en orden: 01 (AD + DC) → reinicio → 02 (OUs, usuarios, grupos) → 03 (admin + RDP) → 04 (recursos compartidos) → 05 (GPO).
3. **Cliente:** Al primer arranque, ejecuta `userdata_cliente.ps1.tpl`, que espera al DC, ejecuta `01-join-domain.ps1` y reinicia.
4. Tras todo el proceso, puedes conectarte por RDP a ambas instancias usando las IP que muestra `terraform output` y verificar el dominio, los usuarios y los recursos compartidos.

Para más contexto sobre el reto práctico y la corrección de errores, consulta el [RG701 — TechCorp (Fase 0 y 1)](RetoPracticoTechCorp.md).
