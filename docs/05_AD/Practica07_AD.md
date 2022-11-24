# Caso Práctico: Creación de una estructura en AD

La administración del dominio es una tarea sencilla mediante la interfaz gráfica, pero puede ser muy tediosa si hay que repetir
en innumerables ocasiones secuencias de acciones.

- Pensemos por ejemplo en el caso típico en el que hay que dar de alta a una cantidad muy grande de usuarios, creando la estructura completa de la organización. Este tipo de procesos puede facilitarse enormemente mediante la utilización de **scripts**.

- Concretamente, **en este ejemplo se plantea la creación de las cuentas de usuario de una organización, así como sus grupos y
unidades organizativas**.

Vamos a suponer que tenemos que crear la siguiente estructura de AD:

<figure>
  <img src="./imagenes/02/PracticasAD/PR07/001.png" width="400"/>
  <figcaption>Estructura AD.</figcaption>
</figure>

Es decir que tendremos 3 secciones y cada sección tiene un conjunto de departamentos.

De manera que tengamos **Administración**, **Almacén y Dirección**. Y cada sección tenga los departamentos que se indican.

Para ello vamos a disponer de los ficheros: secciones.csv, departamentos.csv y personal.csv. **Subidos en aules**.

## Creación de OU y Grupos

Lo primero que vamos a crear es la Unidad Organizativa raíz. Para ello se utiliza: `New-ADOrganizationalUnit` y `New-ADGroup`

``` yaml
Write-Output "Creando Estructura de OU y Grupos..."
New-ADOrganizationalUnit -Name "Pistonazo" -Path "DC=CEFIRE2019, DC=LOCAL" -Description "Unidad organizativa Pistonazo" -ProtectedFromAccidentalDeletion $false 
New-ADGroup -Name "Pistonazo" -GroupScope Global -Path "OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL"
```

Después crearemos cada una de las unidades organizativas y grupos a partir de los ficheros secciones.csv. Para ello se hará uso del comando `foreach`:

``` yaml
$secciones = Import-CSV -Path "./secciones.csv"
$group = Get-ADGroup "CN=Pistonazo,OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL"
foreach ($ou in $secciones) {
    New-ADOrganizationalUnit -Name ($ou.seccion) -Path "OU=Pistonazo, DC=CEFIRE2019, DC=LOCAL"
    $path="OU="+($ou.seccion)+",OU=Pistonazo, DC=CEFIRE2019, DC=LOCAL"
    New-ADGroup -Name $ou.seccion -GroupScope Global -Path $path
    $member = "CN="+($ou.seccion)+","+$path 
    Add-ADGroupMember $group -Members $member       
    Write-Output "Unidad $($ou.seccion) creada!"
}
```

Con esto ya tendremos la estructura de **Unidades Organizativas** y **grupos** creados.

<figure>
  <img src="./imagenes/02/PracticasAD/PR07/002.png" width="800"/>
  <figcaption>OU y grupos creados.</figcaption>
</figure>

## Creación de Usuarios

Ahora queda crear los usuarios de nuestra organización. Para ello leeremos del archivo **personal.csv**. Este archivo tiene 3
columnas, una para el login, otra para el departamento y otra para la sección. Crearemos una contraseña para todos y
haremos que el usuario cuando inicie la sesión se la tenga que cambiar.

``` yaml
$usuarios = Import-CSV -Path "./personal.csv"
Write-Output "Creando usuarios...."
foreach ($user in $usuarios) {
    $login = $user.login
    $path="OU="+$user.departamento+",OU="+$user.seccion+",OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL"
    New-ADUser -Name $login  -Path $path -SamAccountName $login -UserPrincipalName ($login+"@CEFIRE2019.LOCAL") -AccountPassword (ConvertTo-SecureString "cefire2019." -AsPlainText -Force) -GivenName $login -ChangePasswordAtLogon $true-Enabled $true
    $group = Get-ADGroup ("CN="+$user.departamento+",OU="+$user.departamento+",OU="+$user.seccion+",OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL")
    $member = "CN="+$login+","+$path
    Add-ADGroupMember $group -Members $member       
    Write-Output "Usuario $($user.login) creado!"
}
```

Así ya tenemos la estructura de AD creada con los usuarios:

<figure>
  <img src="./imagenes/02/PracticasAD/PR07/003.png" width="800"/>
  <figcaption>Usuarios creados.</figcaption>
</figure>

## Script de creación de estructura

``` yaml
Write-Output "Creando Estructura de OU y Grupos..."
New-ADOrganizationalUnit -Name "Pistonazo" -Path "DC=CEFIRE2019, DC=LOCAL" -Description "Unidad organizativa Pistonazo" -ProtectedFromAccidentalDeletion $false 
New-ADGroup -Name "Pistonazo" -GroupScope Global -Path "OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL"
$secciones = Import-CSV -Path "./secciones.csv"
$group = Get-ADGroup "CN=Pistonazo,OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL"
foreach ($ou in $secciones) {
    New-ADOrganizationalUnit -Name ($ou.seccion) -Path "OU=Pistonazo, DC=CEFIRE2019, DC=LOCAL"
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
    $path="OU="+($ou.departamento)+",OU="+$ou.seccion+",OU=Pistonazo, DC=CEFIRE2019, DC=LOCAL"
    New-ADGroup -Name $ou.departamento -GroupScope Global -Path $path
    $group = Get-ADGroup ("CN="+$ou.seccion+",OU="+$ou.seccion+",OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL")
    $member = "CN="+($ou.departamento)+","+$path
    Add-ADGroupMember $group -Members $member       
    Write-Output "Unidad $($ou.departamento) - $($ou.seccion) creada!"
}

$usuarios = Import-CSV -Path "./personal.csv"
Write-Output "Creando usuarios...."
foreach ($user in $usuarios) {
    $login = $user.login
    $path="OU="+$user.departamento+",OU="+$user.seccion+",OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL"
    New-ADUser -Name $login  -Path $path -SamAccountName $login -UserPrincipalName ($login+"@CEFIRE2019.LOCAL") -AccountPassword (ConvertTo-SecureString "cefire2019." -AsPlainText -Force) -GivenName $login -ChangePasswordAtLogon $true -Enabled $true
    $group = Get-ADGroup ("CN="+$user.departamento+",OU="+$user.departamento+",OU="+$user.seccion+",OU=Pistonazo,DC=CEFIRE2019,DC=LOCAL")
    $member = "CN="+$login+","+$path
    Add-ADGroupMember $group -Members $member       
    Write-Output "Usuario $($user.login) creado!"
}
```
Se prueba a iniciar sesión con un usuario, por ejemplo **usudir1@isca2019.local** (su contraseña será **cefire2019**.):

<figure>
  <img src="./imagenes/02/PracticasAD/PR07/004.png" width="800"/>
  <figcaption>Inicio sesión Post-Script.</figcaption>
</figure>

## Consultas sobre objetos del dominio

### Get-AdObject

El cmdlet **Get-AdObject** de PowerShell obtiene un objeto de Active Directory o realiza una búsqueda para obtener varios objetos según los criterios de búsqueda. Puede obtener todos los objetos en Active Directory mediante el parámetro **-Filter**.

- La sintaxis es:

``` yaml
Get-ADObject
   [-AuthType <ADAuthType>]
   [-Credential <PSCredential>]
   -Filter <String>
   [-IncludeDeletedObjects]
   [-Properties <String[]>]
   [-ResultPageSize <Int32>]
   [-ResultSetSize <Int32>]
   [-SearchBase <String>]
   [-SearchScope <ADSearchScope>]
   [-Server <String>]
   [<CommonParameters>]
}
```

``` yaml
Get-ADObject
   [-AuthType <ADAuthType>]
   [-Credential <PSCredential>]
   [-Identity] <ADObject>
   [-IncludeDeletedObjects]
   [-Partition <String>]
   [-Properties <String[]>]
   [-Server <String>]
   [<CommonParameters>]
}
```

``` yaml
Get-ADObject
   [-AuthType <ADAuthType>]
   [-Credential <PSCredential>]
   [-IncludeDeletedObjects]
   -LDAPFilter <String>
   [-Properties <String[]>]
   [-ResultPageSize <Int32>]
   [-ResultSetSize <Int32>]
   [-SearchBase <String>]
   [-SearchScope <ADSearchScope>]
   [-Server <String>]
   [<CommonParameters>]
}
```

Se pueden observar ejemplos en el enlace de la fuente oficial [Get-ADObject](https://docs.microsoft.com/en-us/powershell/module/activedirectory/get-adobject?view=windowsserver2019-ps)

## Actividad 1

Crea una estructura de AD mediante comandos **PowerShell** de la Empresa ASO2122. **Se deben crear dos archivos csv** con cuatro departamentos a definir (por ejemplo Finanzas, RRHH, Compras, TIC), y con 5 empleados; los csv deben contener:

1. departamentos.csv: Contiene los departamentos de la empresa. El archivo departamentos.csv contiene 2 columnas, el
departamento y una descripción.
2. empleados.csv: Contiene los empleados de la empresa. El archivo departamento contiene 3 columnas, una para el
departamento, otra para el nombre y otra el apellido.

De manera que el usuario tendrá el login compuesto por el nombre y el apellido, de manera que si existiera una empleada llamada **Carla Mateu**, tendrá un login **carla.mateu:**
