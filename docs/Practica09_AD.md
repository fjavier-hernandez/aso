# Permisos, directivas de grupo y perfiles II

Objetivos de esta práctica:

- Establecimiento de carpetas particulares de los usuarios del dominio.
- Ejecución de comandos de inicio de sesión.
- Configuración del entorno de trabajo del usuario mediante perfiles.

# Carpetas Personales

Una de las opciones más utilizadas que puede configurarse en la ficha '**Perfiles**' de las propiedades de la cuenta de usuario es
el establecimiento de una unidad en red personal para cada usuario a la que únicamente él tiene acceso:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/001.png" width="550"/>
  <figcaption>Carpeta particular.</figcaption>
</figure>

Para configurarla, basta crear una carpeta a la que se tenga acceso desde la red. Esta carpeta la tenemos creada en el disco
`c:\Pistonazo_users` y dentro de esta carpeta están las carpetas de cada uno de los usuarios. Bastará asignar la ruta de esa
carpeta a cada uno de los usuarios. Por ejemplo, vamos a asignar la unidad Z: a la carpeta personal de cada uno de los
usuarios de nuestra organización Pistonazo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/002.png" width="850"/>
  <figcaption>Carpetas particulares.</figcaption>
</figure>

Asignaremos estas carpetas a cada uno de los usuarios. Para ello desde la pestaña perfil:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/003.png" width="850"/>
  <figcaption>Carpetas particulares.</figcaption>
</figure>

La carpeta del usuario debe ser una carpeta compartida y con permisos de escritura. En nuestro caso utilizaremos las carpetas
que creamos en la sección de Permisos NTFS por línea de comandos. Creamos una carpeta en `C:\Pistonazo_Users`, esta
carpeta tiene permisos de acceso el grupo Pistonazo y los Administradores. Por tanto, el recurso
`\\192.168.100.1\Pistonazo_users\%username%` será la carpeta de cada uno de los usuarios.

La variable `%username%` sustituye el valor por el identificador de usuario.

### Carpetas personales ocultas

Si quisiéramos que las carpetas personales estuvieran ocultas, bastaría con añadir un `$` al final del nombre del recurso
compartido. En nuestro caso, podíamos haber compartido el recurso Pistonazo_Users con un `$` al final y así ocultar las
carpetas de usuarios.

Podéis probar el siguiente script que elimina toda la estructura pistonazo y la regenera con carpetas ocultas asignando las
carpetas personales a los usuarios:

#### Pistonazo Completo .BAT

``` yaml
REM ELIMINANDO OU PISTONAZO
dsrm -subtree -noprompt -c "ou=Pistonazo, dc=cefire2017, dc=local"

Rem Creación de Unidades Organizativas
dsadd ou "ou=Pistonazo, dc=cefire2017, dc=local"
FOR /F "tokens=1-2 delims=, skip=1" %%a in (secciones.csv) do dsadd ou "ou=%%a, ou=Pistonazo,
dc=cefire2017, dc=local" -desc "%%b"
FOR /F "tokens=1-2 delims=, skip=1" %%a in (departamentos.csv) do dsadd ou "ou=%%b, ou=%%a,
ou=Pistonazo, dc=cefire2017, dc=local" -desc "%%b"

Rem Creacion de grupos
dsadd group "cn=Pistonazo, ou=Pistonazo, dc=cefire2017, dc=local"
FOR /F "tokens=1-2 delims=, skip=1" %%a in (secciones.csv) do dsadd group "cn=%%a, ou=%%a,
ou=Pistonazo, dc=cefire2017, dc=local" -memberof "cn=Pistonazo, ou=Pistonazo, dc=cefire2017,
dc=local"
FOR /F "tokens=1-2 delims=, skip=1" %%a in (departamentos.csv) do dsadd group "cn=%%b, ou=%%b,
ou=%%a, ou=Pistonazo, dc=cefire2017, dc=local" -memberof "cn=%%a, ou=%%a, ou=Pistonazo,
dc=cefire2017, dc=local"
REM Creacion de usuarios
FOR /F "tokens=1-3 delims=, skip=1" %%a in (personal.csv) do dsadd user "cn=%%a, ou=%%b, ou=%%c,
ou=Pistonazo, dc=cefire2017, dc=local" -memberof "cn=%%b, ou=%%b, ou=%%c, ou=Pistonazo,
dc=cefire2017, dc=local" -samid "%%a" -upn "%%a@CEFIRE2017.LOCAL" -pwd "cefire2017." -fn "%%a" -
mustchpwd "yes"
REM Borrando carpetas
rmdir c:\pistonazo
REM Creando carpetas
mkdir c:\pistonazo
FOR /F "tokens=1-2 delims=, skip=1" %%a in (secciones.csv) do mkdir c:\pistonazo\%%a
FOR /F "tokens=1-2 delims=, skip=1" %%a in (departamentos.csv) do mkdir c:\pistonazo\%%a\%%b
icacls c:\Pistonazo /inheritance:r
icacls c:\Pistonazo /GRANT Administradores:(OI)(CI)F
icacls c:\Pistonazo /GRANT Pistonazo:RX

FOR /F "tokens=1-2 delims=, skip=1" %%a in (secciones.csv) do mkdir c:\pistonazo\%%a
FOR /F "tokens=1-2 delims=, skip=1" %%a in (secciones.csv) do icacls c:\pistonazo\%%a /GRANT %%a:RX
FOR /F "tokens=1-2 delims=, skip=1" %%a in (departamentos.csv) do mkdir c:\pistonazo\%%a\%%b
FOR /F "tokens=1-2 delims=, skip=1" %%a in (departamentos.csv) do icacls c:\pistonazo\%%a\%%b
/GRANT %%b:(OI)(CI)F

net share Pistonazo /delete
net share Pistonazo=c:\Pistonazo /grant:Administradores,FULL /grant:Pistonazo,CHANGE
mkdir c:\Pistonazo_users
icacls c:\Pistonazo_users /inheritance:r
icacls c:\Pistonazo_users /grant Administradores:(OI)(CI)F
icacls c:\Pistonazo_users /grant Pistonazo:RX
REM Creacion de carpetas de usuarios
FOR /F "tokens=1-3 delims=, skip=1" %%a in (personal.csv) do mkdir c:\Pistonazo_users\%%a
FOR /F "tokens=1-3 delims=, skip=1" %%a in (personal.csv) do icacls c:\Pistonazo_users\%%a /grant
%%a:(OI)(CI)F

net share Pistonazo_users /delete
net share Pistonazo_users$ /delete
net share Pistonazo_users$=c:\Pistonazo_users /grant:Administradores,FULL /grant:Pistonazo,CHANGE

FOR /F "tokens=1-3 delims=, skip=1" %%a in (personal.csv) do dsmod user "cn=%%a, ou=%%b, ou=%%c,
ou=Pistonazo, dc=cefire2017, dc=local" -hmdrv Z: -hmdir "\\192.168.100.1\Pistonazo_users$\%%a"
```

## Version completa en POWERSHELL (pistonazoCompletoPS.ps1)

En PowerShell sería:

``` yaml
Write-Output "Creando Estructura de OU y Grupos..."
New-ADOrganizationalUnit -Name "Pistonazo" -Path "DC=CEFIRE2019, DC=LOCAL" -Description
"Unidad organizativa Pistonazo" -ProtectedFromAccidentalDeletion $false
New-ADGroup -Name "Pistonazo" -GroupScope Global -Path
"OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL"
$secciones = Import-CSV -Path "./secciones.csv"
$group = Get-ADGroup "CN=Pistonazo,OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL"
foreach ($ou in $secciones) {
New-ADOrganizationalUnit -Name ($ou.seccion) -Path "OU=Pistonazo, DC=CEFIRE2019,
DC=LOCAL"
$path="OU="+($ou.seccion)+",OU=Pistonazo, DC=CEFIRE2019, DC=LOCAL"
New-ADGroup -Name $ou.seccion -GroupScope Global -Path $path
$member = "CN="+($ou.seccion)+","+$path
Add-ADGroupMember $group -Members $member
Write-Output "Unidad $($ou.seccion) creada!"
}
$departamentos = Import-CSV -Path "./departamentos.csv"
foreach ($ou in $departamentos) {
$path="OU="+($ou.seccion)+", OU=Pistonazo, DC=CEFIRE2019, DC=LOCAL"
New-ADOrganizationalUnit -Name ($ou.departamento) -Path $path
$path="OU="+($ou.departamento)+",OU="+$ou.seccion+",OU=Pistonazo, DC=CEFIRE2019,
DC=LOCAL"
New-ADGroup -Name $ou.departamento -GroupScope Global -Path $path
$group = Get-ADGroup
("CN="+$ou.seccion+",OU="+$ou.seccion+",OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL")
$member = "CN="+($ou.departamento)+","+$path
Add-ADGroupMember $group -Members $member
Write-Output "Unidad $($ou.departamento) - $($ou.seccion) creada!"
}
$usuarios = Import-CSV -Path "./personal.csv"
Write-Output "Creando usuarios...."
foreach ($user in $usuarios) {
$login = $user.login

$path="OU="+$user.departamento+",OU="+$user.seccion+",OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL
New-ADUser -Name $login -Path $path -SamAccountName $login -UserPrincipalName
($login+"@CEFIRE2019.LOCAL") -AccountPassword (ConvertTo-SecureString "cefire2019." -
AsPlainText -Force) -GivenName $login -ChangePasswordAtLogon $true -Enabled $true
$group = Get-ADGroup
("CN="+$user.departamento+",OU="+$user.departamento+",OU="+$user.seccion+",OU=Pistonazo,D
$member = "CN="+$login+","+$path
Add-ADGroupMember $group -Members $member
Write-Output "Usuario $($user.login) creado!"

}
Write-Host "Creamos la estructura de Pistonazo..."
Remove-Item C:\Pistonazo -Force
New-Item C:\Pistonazo -Type Directory
$acl = Get-Acl C:\Pistonazo
$acl.SetAccessRuleProtection($true, $false)
$rule = New-Object


System.Security.AccessControl.FileSystemAccessRule("Administradores","FullControl",
"ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
$rule = New-Object
System.Security.AccessControl.FileSystemAccessRule("Pistonazo","ReadAndExecute", "None",
"None", "Allow")
$acl.AddAccessRule($rule)
Set-Acl -path C:\Pistonazo -AclObject $acl
Write-Host "Asignamos Permisos"
$deps = Import-CSV -Path "./departamentos.csv"
foreach ($ou in $deps) {
New-Item C:\Pistonazo\$($ou.seccion)\$($ou.departamento) -Type Directory -Force
$acl = Get-Acl C:\Pistonazo\$($ou.seccion)
$rule = New-Object
System.Security.AccessControl.FileSystemAccessRule($($ou.seccion),"ReadAndExecute",
"None", "None", "Allow")
$acl.AddAccessRule($rule)
Set-Acl -path C:\Pistonazo\$($ou.seccion) -AclObject $acl
$acl = Get-Acl C:\Pistonazo\$($ou.seccion)\$($ou.departamento)
$rule = New-Object
System.Security.AccessControl.FileSystemAccessRule($($ou.departamento),"FullControl",
"ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
Set-Acl -path C:\Pistonazo\$($ou.seccion)\\$($ou.departamento) -AclObject $acl
}

Write-Host "Creamos la estructura de Carpetas de Usuarios"
Remove-Item C:\Pistonazo_users -Force
New-Item C:\Pistonazo_users -Type Directory
$acl = Get-Acl C:\Pistonazo_users
$acl.SetAccessRuleProtection($true, $false)
$rule = New-Object
System.Security.AccessControl.FileSystemAccessRule("Administradores","FullControl",
"ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
$rule = New-Object
System.Security.AccessControl.FileSystemAccessRule("Pistonazo","ReadAndExecute", "None",
"None", "Allow")
$acl.AddAccessRule($rule)
Set-Acl -path C:\Pistonazo_users -AclObject $acl
$usuarios = Import-CSV -Path "./personal.csv"
Write-Output "Creando carpetas de usuarios...."
foreach ($user in $usuarios) {
$login = $user.login
New-Item C:\Pistonazo_users\$($user.login) -Type Directory
$acl = Get-Acl C:\Pistonazo_users\$($user.login)
$rule = New-Object
System.Security.AccessControl.FileSystemAccessRule($($user.login),"FullControl",
"ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
Set-Acl -path C:\Pistonazo_users\$($user.login) -AclObject $acl

}
New-SmbShare -Name Pistonazo_Users$ -Path c:\Pistonazo_Users -ChangeAccess Pistonazo -
FullAccess Administradores

New-SmbShare -Name Pistonazo -Path c:\Pistonazo -ChangeAccess Pistonazo -FullAccess
Administradores

$usuarios = Import-CSV -Path "./personal.csv"
Write-Output "Modificando atributos de usuarios...."
foreach ($user in $usuarios) {
$userObj =
"CN="+$user.login+",OU="+$user.departamento+",OU="+$user.seccion+",OU=Pistonazo,DC=CEFIRE
$usuario = Get-ADUser -Identity $userObj
Set-ADUser -Identity $usuario -ScriptPath "Pistonazo2.bat" -HomeDrive "Z:" -
HomeDirectory "\\192.168.100.1\Pistonazo_users$\$($user.login)"
Write-Output "Usuario $usuario encontrado!"
}
```

## Comandos de inicio de sesión

Otra opción que podemos configurar dentro de la ficha perfil consiste en indicar un script que se ejecutará en cada inicio de
sesión de manera automática y transparente al usuario. Para ello desde la pestaña perfil del usuario accedemos a Script de
inicio de sesión:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/004.png" width="450"/>
  <figcaption>Script de inicio de sesión.</figcaption>
</figure>

Estos scripts deben hallarse en la carpeta compartida NETLOGON, cuya dirección local en el controlador de dominio es:
`C:\Windows\SYSVOL\sysvolCEFIRE2017.LOCAL\scripts`. En este caso concreto, la dirección local y la dirección en red serían
respectivamente:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/005.png" width="850"/>
  <figcaption>Ruta Netlogon.</figcaption>
</figure>

Crearemos en esta carpeta un fichero llamado pistonazo.bat. Que será donde añadamos los comandos que queremos que se
ejecuten cuando un usuario inicie la sesión:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/006.png" width="850"/>
  <figcaption>Fichero pistonazo.bat</figcaption>
</figure>

Hay que tener en cuenta que por defecto están las extensiones de archivo ocultas. Para evitar confusiones con los archivos,
vamos a marcar que nos muestre las extensiones de los archivos. Para ello seleccionamos Vista y marcamos extensiones de
archivo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/007.png" width="850"/>
  <figcaption>Marcar extensiones de archivos en Netlogon</figcaption>
</figure>

### Ejemplos de scripts de inicio de sesión: Asignación de unidad de red

Vamos a hacer que se monte de manera automática la unidad P: que será la unidad donde se encuentren las carpetas de los
departamentos de los usuarios de la organización Pistonazo. 

Para ello, añadiremos a nuestro script, el comando **_Net Use P:\\192.168.100.1\Pistonazo_**

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/008.png" width="850"/>
  <figcaption>Pistonazo.bat</figcaption>
</figure>

Ahora lo que haremos será modificar el campo Script de inicio de sesión a los usuarios de la organización Pistonazo. Podemos
añadir a nuestro script el siguiente comando:

``` yaml
FOR /F "tokens=1-3 delims=, skip=1" %%a in (personal.csv) do dsmod user "cn=%%a, ou=%%b, ou=%%c, ou=Pistonazo, dc=cefire2017, dc=local" -loscr "pistonazo.bat"
```

También podemos ejecutar el siguiente comando desde la línea de comandos:

``` yaml
dsmod user "OU=Pistonazo, DC=CEFIRE2017, DC=LOCAL" | dsmod user -loscr "Pistonazo.bat"
```

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/009.png" width="850"/>
  <figcaption>dsmod user para modificar el script de inicio</figcaption>
</figure>

Esto habrá modificado el campo Script de inicio de sesión de nuestros usuarios de la organización de Pistonazo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/010.png" width="650"/>
  <figcaption>Script de inicio de sesión</figcaption>
</figure>

Y ahora si iniciamos sesión con alguno de los usuarios de Pistonazo, veremos que nos habrá añadido una nueva unidad de
red, la unidad P: que conectará a la estructura de Pistonazo que se encuentra en el servidor:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/011.png" width="850"/>
  <figcaption>Unidad de red Pistonazo</figcaption>
</figure>

### Ejemplos de scripts de inicio de sesión: Asignación de unidad de red

Supongamos que queremos enviar un mensaje a los usuarios cuando se conecten al sistema. Suele ser habitual enviar
mensajes del tipo 'Guarda los datos en red' o 'No instales software sin permiso del administrador', o simplemente avisar de
paradas planeadas en el sistema. Para enviar este tipo de mensajes automáticamente cuando el usuario inicia sesión
podemos utilizar el comando msg dentro del fichero de comandos de inicio de sesión que hemos creado en el punto anterior:

``` yaml
if NOT EXIST P: net use P: \\192.168.100.1\Pistonazo
msg %username% Recuerda guardar los datos en las unidades Z: o P:
```
<figure>
  <img src="./imagenes/02/PracticasAD/PR09/012.png" width="850"/>
  <figcaption>Mensajes de aviso a usuarios</figcaption>
</figure>

## Perfiles

Podemos definir un perfil como aquellos aspectos de configuración del equipo y del entorno de trabajo propios del usuario y
que además son exportables a otras máquinas de manera transparente al mismo. En otras palabras, mediante los perfiles
conseguimos que el usuario independientemente del equipo en el que inicie la sesión disponga de un entorno de trabajo
similar. Todo esto se entenderá mejor con los ejemplos preparados en las secciones siguientes.

Existen tres tipos de perfiles:

1. **Perfiles locales** : se almacenan en el equipo, y configuran el entorno de trabajo de cada usuario. No los abordaremos
en este curso ya que lo que nos interesa es la gestión centralizada de recursos.
2. **Perfiles móviles** : el usuario configura el entorno de trabajo a su gusto en un equipo, y al iniciar sesión en cualquier
otra estación de trabajo, la configuración se importa y aplica a ese nuevo equipo. Abordaremos este tipo de perfiles
más adelante.
3. **Perfiles obligatorios** : un usuario con permisos de administración define la configuración del entorno de trabajo, y se
aplica a los usuarios del dominio. Estos pueden modificarla durante la sesión, pero al iniciar otra sesión, se vuelve a
cargar la configuración del perfil obligatorio. En lugar de trabajar con perfiles obligatorios, en el apartado anterior
hemos visto cómo configurar entornos de trabajo definidos para los miembros de una unidad organizativa de una
manera más cómoda y potente.

### Perfiles móviles

Como se ha comentado en el apartado anterior, los perfiles consisten en una serie de ficheros de configuración del entorno de
trabajo, que se aplican a todos los equipos de la red desde donde pueda iniciar sesión el usuario. Estos ficheros de configuración deben almacenarse en una ubicación accesible por los equipos clientes, como por ejemplo el controlador de dominio.

Concretamente, almacenaremos los perfiles en una carpeta de perfil. Esta carpeta de perfil la crearemos dentro de las
carpetas particulares de los usuarios. Por ejemplo, vamos a hacer que los usuarios del departamento Gestión tengan un perfil
móvil:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/013.png" width="850"/>
  <figcaption>Perfil móvil para usuarios de departamento Gestión</figcaption>
</figure>

Esto hará que estos usuarios cuando inicien sesión en alguna de las máquinas cliente de nuestro dominio, recupere todo su
perfil de la carpeta personal del usuario. Para ello, vamos a modificar el siguiente campo de la pestaña perfil:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/014.png" width="850"/>
  <figcaption>Perfil móvil usuario usudir1</figcaption>
</figure>

Y estableceremos la ruta de acceso al perfil. En nuestro caso, vamos a establecer la ruta de acceso al perfil móvil, dentro de la
carpeta personal del usuario. Por tanto, seleccionaremos los dos usuarios y con el botón de la derecha del ratón:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/015.png" width="850"/>
  <figcaption>Perfil móvil usuarios gestion</figcaption>
</figure>

Y para la ruta del perfil móvil estableceremos la siguiente dirección: `\\192.168.100.1\Pistonazo_users$\%username%\perfil`

De esta forma cuando algún usuario de Gestión inicie sesión, se creará en la carpeta personal su perfil. Así
independientemente del equipo donde se conecte, siempre tendrá la información:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/016.png" width="850"/>
  <figcaption>Creación de carpeta de perfil móvil</figcaption>
</figure>

!!! Warning
    - **Carga en red Perfil Móvil** : Hay que tener en cuenta de que cuando un usuario con perfil móvil inicia la sesión, la información del servidor se copia al cliente. Cuando cierra la sesión se realiza la operación inversa. Un alto número de usuario con perfil móvil puede sobrecargar la red demasiado. Por tanto, hay que saber exactamente en qué usuarios debemos aplicar esta característica.

## Actividades

En esta actividad, vamos a seguir con la organización de vuestra empresa. La que realizasteis en la práctica anterior:

Un supuesto ejemplo de empresa:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/017.png" width="850"/>
  <figcaption>Estructura Empresa</figcaption>
</figure>

1. Crear la estructura de carpetas en disco y definir los siguientes permisos:

Se puede seguir el siguiente ejemplo: A la carpeta principal Empresa, sólo podrán acceder los miembros del grupo Empresa. En esta carpeta solo tendrán acceso de lectura. Cada departamento podrá entrar en su carpeta con permisos de control total y no podrá acceder al resto de departamentos de la empresa.

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/018.png" width="850"/>
  <figcaption>Estructura de carpetas Empresa</figcaption>
</figure>

2. Crear también la estructura para almacenar las carpetas particulares de los usuarios. Por ejemplo en `C:\Empresa_users`

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/019.png" width="650"/>
  <figcaption>Carpeta de usuarios</figcaption>
</figure>

3. Cuando un usuario inicie sesión, conectará de manera automática la carpeta personal en la unidad X: y la carpeta de
empresas en la unidad Y:

<figure>
  <img src="./imagenes/02/PracticasAD/PR09/020.png" width="850"/>
  <figcaption>Inicio sesión usuario Empresa</figcaption>
</figure>

Para esta actividad hay que utilizar los scripts `pistonazoCompleto.bat | pistonazoCompletoPS.ps1`; 

!!! Note
    Se debe adaptadar a la actividad y explicar cada parte del script.

- **En esta actividad se entregará un script.ps1 y script.bat con las órdenes para crear las carpetas de los departamentos, las carpetas de los usuarios y los permisos correspondientes.** 
- **También un informe con una captura de pantalla con las unidades de red montadas de un usuario.**
