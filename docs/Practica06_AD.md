# Práctica06_AD

# Administración de Usuarios y Grupos

Objetivos de esta práctica:

- Crear y configurar usuarios
- Crear y configurar grupos
- Crear y configurar unidades organizativas


## Creación de usuarios

Los usuarios del dominio deben tener una cuenta para poder acceder a los recursos del mismo tras su autenticación frente al
controlador de dominio. 

Para crear una cuenta de usuario mediante la interfaz gráfica accederemos a la herramienta: 
'**Usuarios y equipos de Active Directory**' desde el Panel del **Administrador** --> **Herramientas:**

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/001.png" width="850"/>
  <figcaption>Usuarios y Equipos de AD.</figcaption>
</figure>

Una vez abierto el administrador de '**Usuarios y equipos de Active Director**y', se hace clic con el botón derecho sobre '**Users**' y
en el menú que aparece, se selecciona '**Nuevo**' y a continuación '**Usuario**' :

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/002.png" width="850"/>
  <figcaption>Creación Nuevo Usuario I.</figcaption>
</figure>

Nos aparece el asistente para la creación del nuevo usuario:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/003.png" width="550"/>
  <figcaption>Creación Nuevo Usuario II.</figcaption>
</figure>

En la primera parte del cuadro de diálogo anterior se puede introducir el nombre, la(s) inicial(es) del segundo nombre y los apellidos del usuario.
Hasta aquí toda esta información es meramente informativa, podría haber, por ejemplo, dos usuarios cuyo nombre completo fuera "Fº Javier Hernández Illán".

!!! Note
    - Como **normas generales al crear un nombre** de usuario hay que observar que:
        - Las cuentas de usuario **deben ser únicas**.
        - Los nombres de inicio de sesión se pueden formar con una **combinación de letras, mayúsculas o minúsculas, y caracteres alfanuméricos**.
        - No se aceptan los caracteres: `/, |, :, ;, =, <, > ni *`. La cuenta de usuario puede tener **hasta 20 caracteres**.


Por lo tanto en la segunda parte del cuadro de texto dode se indica '**Nombre de inicio de sesión de usuario**' se introduce el nombre de usuario
siguiendo la estructura que haya predefinido el administrador del sistema y como se ha indicado anteriormente, **este nombre debe ser único en todo el dominio**.

Algunos ejemplos de criterios para la creación del nombre de usuario podrían ser los siguientes:

- Dos primeras letras del nombre y apellidos.
- El nombre de inicio de sesión del usuario **Fº Javier Hernández Illán** sería: `fjhernandez`.
- Diferentes caracteres para separar la inicial del primer nombre y el apellido completo: `fj.hernandez`.
- Primer nombre completo y primer apellido completo separados por un punto: `francisco.hernandez`.

A continuación se solicitará que se introduzca la contraseña del usuario. Esta debe cumplir con los criterios de complejidad
establecidos. Además aparecen una serie de opciones para configurar las propiedades de la contraseña:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/004.png" width="550"/>
  <figcaption>Creación Nuevo Usuario III.</figcaption>
</figure>

En la figura anterior aparecen cuatro opciones para la contraseña

- El usuario debe cambiar la contraseña en el siguiente inicio de sesión.
- El usuario no puede cambiar la contraseña.
- La contraseña nunca expira.
- La cuenta está deshabilitada.

**La primera de las opciones** es útil para que el administrador cree el nuevo usuario con una contraseña convencional. El
usuario cuando se autentifique por primera vez en el sistema entrará con la contraseña que le ha proporcionado el
administrador, pero automáticamente, el sistema le indicará que debe ser cambiada. De esta manera, el administrador ya no
conocerá la contraseña del usuario, garantizándose la privacidad de esta.

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/005.png" width="850"/>
  <figcaption>Mensaje para cambio de contraseña.</figcaption>
</figure>

- El **segundo de los casos** ('El usuario no puede cambiar la contraseña') está pensado para crear **usuarios genéricos**, supongamos que creamos una cuenta de usuario para utilizar un ordenador conectado a un escáner, y queremos que los Usuarios que deseen utilizar ese escáner, siempre entren con la misma cuenta al equipo asociado al escáner.

- La inhabilitación del **tercer caso** ('La contraseña nunca expira'), tiene por objetivo evitar que el sistema pida al usuario que
cambie la contraseña periódicamente. Resulta interesante mantener esta opción, aunque pueda resultar incómodo cambiar la
contraseña cada, por ejemplo, seis meses. De esta manera estamos protegiéndonos de posibles accesos indebidos por parte
de alguien que haya averiguado la contraseña de alguna manera.

- Finalmente, **la cuarta opción** ('La cuenta está deshabilitada') sirve para bloquear usuarios que no queremos que tengan acceso
al sistema, pero tampoco queremos eliminarlos, ya que se invalidarían los permisos referidos a este usuario. También puede
servir para crear usuarios que no queremos que estén operativos hasta un momento determinado.

# Creación de usuarios por comandos

### DSADD USER -> CMD

Una opción para poder crear usuarios del dominio es mediante el comando `dsadd user`. Este comando nos va a permitir
definir la ubicación en la que se creará el usuario en lo referente a:

- Dominio o subdominio.
- Unidad Organizativa.

`dsadd` es una herramienta de línea de comandos que está integrada a partir de Windows Server 2008.

- Está disponible si tiene instalada la **función de servidor de servicios de dominio de Active Directory** (AD DS). 
- Para utilizar `dsadd`, debe ejecutar el comando `dsadd` desde un símbolo del sistema con privilegios de administrador. 
- Para una referencia más amplia del comando, se puede acceder al siguiente [enlace](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731279(v=ws.10)?redirectedfrom=MSDN).

#### Sintaxis dsadd user

``` yaml
dsadd user <UserDN> [-samid <SAMName>] [-upn <UPN>] [-fn <FirstName>] [-mi <Initial>] [-ln <LastName>] [-display <DisplayName>] [-empid <EmployeeID>] [-pwd {<Password> | *}] [-desc <Description>] [-memberof <Group> ...] [-office <Office>] [-tel <PhoneNumber>] [-email <Email>] [-hometel <HomePhoneNumber>] [-pager <PagerNumber>] [-mobile <CellPhoneNumber>] [-fax <FaxNumber>] [-iptel <IPPhoneNumber>] [-webpg <WebPage>] [-title <Title>] [-dept <Department>] [-company <Company>] [-mgr <Manager>] [-hmdir <HomeDirectory>] [-hmdrv <DriveLetter>:][-profile <ProfilePath>] [-loscr <ScriptPath>] [-mustchpwd {yes | no}] [-canchpwd {yes | no}] [-reversiblepwd {yes | no}] [-pwdneverexpires {yes | no}] [-acctexpires <NumberOfDays>] [-disabled {yes | no}] [{-s <Server> | -d <Domain>}] [-u <UserName>] [-p {<Password> | *}] [-q] [{-uc | -uco | -uci}]
```

!!! Observaciones
    - Si no proporciona un objeto de destino en el símbolo del sistema, `dsadd` Obtiene el objeto de destino de la entrada estándar (`stdin`).
    - `Dsadd` puede aceptar `stdin` desde el teclado, desde un archivo redirigido o como salida canalizada desde otro comando. 
    - Para marcar el final de los datos `stdin` desde el teclado o en un archivo redirigido, utilice el carácter de fin de archivo (**CTRL+Z**).
    - Si un valor que se proporciona contiene espacios, use comillas alrededor del texto, por ejemplo, "CN = Javier Hernández, CN = Users, DC = ASO2122, DC = LOCAL".
    - Si proporciona múltiples valores para un parámetro, utilice espacios para separar los valores, por ejemplo, una lista de nombres completos.
    - Uso de contraseñas seguras en todas las cuentas de usuario ayuda a minimizar los riesgos de seguridad.

### Crear usuarios con PowerShell: New-ADUser

Otra de las formas con las que podemos crear usuarios es mediante **PowerShell**, cada vez más utilizado en los sistemas
Windows Server. Para poder crear usuarios con **PowerShell**, vamos a utilizar el comando `New-ADUser`. 

- Desde el siguiente [enlace](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617253(v=technet.10)?redirectedfrom=MSDN) podéis obtener más información de este comando. 

#### La sintaxis del mismo es la siguiente:

``` yaml
New-ADUser [-Name] <string> [-AccountExpirationDate <System.Nullable[System.DateTime]>] [-AccountNotDelegated <System.Nullable[bool]>] [-AccountPassword <SecureString>] [-AllowReversiblePasswordEncryption <System.Nullable[bool]>] [-AuthType {<Negotiate> | <Basic>}] [-CannotChangePassword <System.Nullable[bool]>] [-Certificates <X509Certificate[]>] [-ChangePasswordAtLogon <System.Nullable[bool]>] [-City <string>] [-Company <string>] [-Country <string>] [-Credential <PSCredential>] [-Department <string>] [-Description <string>] [-DisplayName <string>] [-Division <string>] [-EmailAddress <string>] [-EmployeeID <string>] [-EmployeeNumber <string>] [-Enabled <System.Nullable[bool]>] [-Fax <string>] [-GivenName <string>] [-HomeDirectory <string>] [-HomeDrive <string>] [-HomePage <string>] [-HomePhone <string>] [-Initials <string>] [-Instance <ADUser>] [-LogonWorkstations <string>] [-Manager <ADUser>] [-MobilePhone <string>] [-Office <string>] [-OfficePhone <string>] [-Organization <string>] [-OtherAttributes <hashtable>] [-OtherName <string>] [-PassThru <switch>] [-PasswordNeverExpires <System.Nullable[bool]>] [-PasswordNotRequired <System.Nullable[bool]>] [-Path <string>] [-POBox <string>] [-PostalCode <string>] [-ProfilePath <string>] [-SamAccountName <string>] [-ScriptPath <string>] [-Server <string>] [-ServicePrincipalNames <string[]>] [-SmartcardLogonRequired <System.Nullable[bool]>] [-State <string>] [-StreetAddress <string>] [-Surname <string>] [-Title <string>] [-TrustedForDelegation <System.Nullable[bool]>] [-Type <string>] [-UserPrincipalName <string>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

!!! Example
    ``` yaml
    New-ADUser -Name "Javier Hernandez" -Path "CN=Users,DC=ASO2122,DC=LOCAL" -SamAccountName "fjhernandez" -UserPrincipalName "fjhernandez@CASO2122.LOCAL" -AccountPassword (ConvertTo-SecureString"ASO2122." -AsPlainText -Force) -GivenName "Francisco Javier" -Surname "Hernandez Illan" -ChangePasswordAtLogon $true -Enabled $true
    ```

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/006.png" width="450"/>
  <figcaption>Parámetros New-ADUser I.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/007.png" width="450"/>
  <figcaption>Parámetros New-ADUser II.</figcaption>
</figure>

# Eliminación y deshabilitación de usuarios

!!! Note
    - Cada cuenta de usuario creada en un dominio tiene un identificador de seguridad (**SID**) único. Si eliminamos una cuenta de usuario y después volvemos a crearla exactamente igual, el identificador **SID** será diferente. 
    - Esto se traduce en que **no se podrán recuperar los permisos y privilegios de la cuenta eliminada**.

Si finalmente decidimos eliminar la cuenta, accederemos a '**Usuarios y equipos de Active Directory**', seleccionaremos el usuario a eliminar, haremos clic con el botón derecho y luego 'Eliminar':

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/008.png" width="950"/>
  <figcaption>Eliminar usuario de AD.</figcaption>
</figure>

### Comandos

- Para eliminar una cuenta de usuario mediante la línea de comandos utilizaremos el comando [dsrm](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731865(v=ws.10))
- Para eliminar una cuenta con PoweShell, entramos dentro del entorno powershell y ejecutamos [Remove-ADUser](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ee617206(v=technet.10))

## Deshabilitar cuentas

Para evitar posibles problemas con la eliminación de cuentas, el cual es un proceso definitivo, se suele optar por la deshabilitación de cuentas.

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/009.png" width="950"/>
  <figcaption>Deshabilitar cuenta.</figcaption>
</figure>

!!! Example
    - Supongamos una empresa en la que un trabajador va a cesar su actividad. El administrador de sistemas deshabilitará su cuenta en la fecha en la que el trabajador vaya a dejar de prestar sus servicios. De esta manera el trabajador cesado ya no podrá iniciar sesión en el dominio, pero si pasado un tiempo hiciera falta volver a iniciar sesión, bastaría con habilitar de nuevo la cuenta.
    - Otro ejemplo real podría ser una universidad, en la que cada alumno tiene una cuenta de usuario. Cuando finaliza sus estudios, la cuenta es deshabilitada, pero si posteriormente cursa otros estudios, la cuenta volvería a habilitarse.

Como antes, accederemos a '**Usuarios y equipos de Active Directory**' y haciendo clic con el botón secundario sobre el usuario
a bloquear, seleccionaremos la opción 'Deshabilitar la cuenta'.

### Comandos

- Para deshabilitar una cuenta de usuario mediante la línea de comandos utilizaremos el comando [dsmod](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc732954(v=ws.10)) con el modificador `disabled` con valor **yes**.

- Desde el entorno **powershell** también podemos deshabilitar una cuenta de usuario con [Disable-ADAccount](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ee617197(v=technet.10))

## Configuración de la cuenta de usuario

Las cuentas de usuarios creadas en el domino se pueden configurar de una manera detallada en la ventana ‘**Propiedades de
la cuenta**’, para ello se hace clic con el **botón derecho del ratón sobre la cuenta de usuario que se desea editar**:

Las propiedades de la cuenta de usuario qué más utilizaremos durante este curso serán:

- **General**: Se puede modificar el Nombre, Apellido, etc. y además modificar información administrativa como la
descripción, oficina, teléfono, email y página web.
- **Cuenta**: Se puede configurar algunas características de la contraseña de usuario, las horas de inicio de sesión, la
caducidad de la cuenta, desbloquear la cuenta, etc.
- **Perfil**: En esta ficha se pueden editar aspectos importantes como son la ubicación física del perfil del usuario y el
fichero de comandos de inicio de sesión.
- **Miembro de**: Se muestra el listado de grupos a los que el usuario pertenece.


## Configuración de inicio de sesión

A partir de Windows Server 2008 se permite configurar los horarios en los que se puede iniciar sesión. Esta funcionalidad
puede ser útil para controlar accesos al sistema a horas ‘anómalas’, o para evitar que usuarios de, por ejemplo, el turno de
tarde, puedan acceder al sistema con la cuenta de un usuario del turno de mañana.

Para establecer los horarios en los que se puede iniciar sesión se seguirán los siguientes pasos.

En ‘**Usuarios y Equipos de Active Directory**’ se selecciona el usuario buscado, y haciendo clic con el botón derecho se accede
a ‘Propiedades’.

- Se abre el cuadro de diálogo ‘**Propiedades**’ de la cuenta seleccionada.
- Se hace clic en la ficha ‘**Cuenta**’ y después se hace clic en el botón ‘**Horas de inicio de sesión**’

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/010.png" width="450"/>
  <figcaption>Horas de inicio de sesión I.</figcaption>
</figure>

En color azul se muestran las horas de inicio permitidas. Para denegar el acceso basta con seleccionar las horas a las que se
desea limitar el acceso y se marca la opción ‘Inicio de sesión denegado’:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/011.png" width="550"/>
  <figcaption>Horas de inicio de sesión II.</figcaption>
</figure>

También es posible configurar el inicio de sesión en determinados equipos. Para ello basta con hacer clic en el botón ‘**Iniciar
sesión en...**’. Se puede seleccionar si el usuario puede iniciar sesión en ‘Todos los equipos’ o solo en algunos equipos determinados:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/012.png" width="750"/>
  <figcaption>Iniciar sesión en...</figcaption>
</figure>

# Creación de grupos

Los grupos son un tipo de contenedor que permiten definir conjuntos de usuarios y definir permisos basándonos en esa pertenencia al grupo, en lugar de hacerlo de modo individual, usuario por usuario. 

Eso no sólo facilita la administración del dominio sino que también permite trabajar de un modo menos propenso a errores. Como pauta general, la agrupación de objetos suele facilitar las tareas de administración reduciendo las posibilidades de error.

Existen dos grandes tipos de grupos en el Directorio Activo de Windows:

- **Grupos de seguridad**: este tipo de grupos permite definir permisos para recursos del dominio. Son los utilizados en las
listas de control de accesos (ACLs) que se estudiarán más adelante. Este tipo de grupos son los que se utilizarán en la
administración de la red.
- **Grupos de distribución**: no poseen características de seguridad, únicamente son un listado de usuarios para
mensajería.

Dentro de los grupos de seguridad existen a su vez tres ámbitos:

- **Grupo Universal**: es un grupo cuyos permisos se extienden a diversos dominios. Además este tipo de grupos puede
estar formado por usuarios o grupos de usuarios de diferentes dominios.
- **Grupo Global**: es muy similar a los grupos universales, es decir pueden permitir el acceso a recursos de cualquiera de
los dominios del árbol del Directorio Activo, pero con la salvedad de que todos los miembros del grupo deben
pertenecer al mismo dominio.
- **Grupo Local del Dominio**: es un grupo creado en un dominio con miembros que pueden provenir de otros dominios y
que únicamente puede tener acceso a recursos dentro de su dominio.

## ¿En qué casos utilizar un ámbito y otro de grupo?

Los grupos universales suelen tener su utilidad en grandes empresas en las que se ha definido un bosque de dominios
asignando dominios a cada uno de sus departamentos o divisiones. En este tipo de estructuras, cuando se realiza una
modificación en el grupo, esta debe replicarse en todos los controladores de domino que estén configurados como catálogo
global.

En redes de dominio único se pueden aplicar grupos globales que tendrán mayor sentido cuando se defina un segundo
dominio, lo que puede ocurrir en el momento en el que haya una ampliación de la organización.

Como pautas generales para la administración de redes tendremos en cuenta las siguientes consideraciones

1. No se debe asignar un ámbito más amplio del necesario.
2. Los grupos locales de dominio no se pueden procesar en otros dominios.
3. Un grupo global no se replica fuera del dominio ya que no forma parte del plan de replicación del catálogo global.
4. Los grupos universales se replican por toda la red generando tráfico que puede tener una cierta incidencia en el
rendimiento de esta (aunque este aspecto se ha optimizado a partir de Windows Server 2008).
5. Si un grupo universal está compuesto por grupos globales y se producen cambios dentro de los grupos globales, no se
produce un cambio en el catálogo global, y por tanto esa modificación no conlleva una replicación en todos los
controladores de domino del bosque.

## Grupos predefinidos

Al instalar el Directorio Activo podemos comprobar que se han generado automáticamente una serie de grupos predefinidos
con unos permisos acorde a sus funciones asignadas:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/013.png" width="900"/>
  <figcaption>Grupos predefinidos</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/014.png" width="900"/>
  <figcaption>Grupos Builtin</figcaption>
</figure>

Examinemos las funciones de algunos de los grupos más utilizados:

- **Usuarios del dominio**: grupo global que contiene todas las cuentas de usuarios el domino.
- **Administradores del dominio**: grupo global que permite a sus miembros realizar tareas de administración del dominio.
- **Administradores de empresa**: grupo universal que permite a sus miembros realizar tareas de administración en todos
los dominios de la red.
- **Administradores de esquema**: grupo universal que permite a sus miembros modificar la estructura de los objetos del
Directorio Activo.
- **Administradores**: grupo local que permite a sus miembros realizar tareas de administración en el controlador de
dominio.
- **Operadores de copias de seguridad**: grupo local que permite a sus miembros realizar copias de seguridad o restaurar
archivos dentro del dominio.
- **Operadores de cuenta**: grupo local que permite a sus miembros crear, editar y eliminar cuentas de usuario y grupos.
- **Operadores de impresión**: grupo local que permite a sus miembros configurar y administrar el uso de impresoras de
red.
- **Operadores de servidor**: grupo local que permite a sus miembros crear carpetas compartidas en el servidor y realizar
copias de seguridad o restaurar archivos en el controlador de dominio.
- **Usuarios**: grupo local que limita las posibilidades de que un usuario haga un cambio accidental en el sistema pero sí
permite ejecutar la mayoría de las aplicaciones.

Es **importante** darse cuenta del considerable ahorro de tiempo para el administrador que permite la existencia de grupos
predefinidos para tareas muy concretas.

## Creación de grupos

La forma de crear los grupos es muy parecida a la que hacíamos para crear a los usuarios. Para ello desde la opción de
**Usuarios y equipos de Active Directory**, con el botón de la derecha del ratón, **nuevo** --> **Grupo**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/015.png" width="900"/>
  <figcaption>Creación de Grupos I</figcaption>
</figure>

Se abrirá el siguiente cuadro de dialogo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/016.png" width="450"/>
  <figcaption>Creación de Grupos II</figcaption>
</figure>

Por defecto se nos indica que el ámbito del grupo será ‘**Global**’ y el tipo de grupo será de ‘**Seguridad**’. En principio, si no
tenemos unas necesidades que justifiquen lo contrario, crearemos los grupos con esas propiedades. Tras pulsar ‘**Aceptar**’ nos
aparecerá el nuevo grupo en el listado de ‘**Usuarios y equipos de Active Directory**’:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/017.png" width="450"/>
  <figcaption>Creación de Grupos III</figcaption>
</figure>

## Añadir usuarios a grupos

Para poder añadir un usuario a un grupo, lo podemos hacer de varias maneras. La primera de ellas mediante basta con
seleccionar el usuario y en el menú que se abrirá al hacer clic con el botón derecho, acceder a la opción ‘**Agregar a un grupo**’:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/018.png" width="450"/>
  <figcaption>Añadir usuario a grupo I</figcaption>
</figure>

Se abrirá un cuadro en el que podremos indicar/buscar el grupo al que queremos añadir el usuario. Mediante comprobar
nombres nos mostrará las coincidencias del grupo que hemos añadido. Con las opciones avanzadas podemos hacer una
búsqueda del grupo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/019.png" width="550"/>
  <figcaption>Añadir usuario a grupo II</figcaption>
</figure>

Tras aceptar, aparecerá un mensaje indicando que la operación se ha realizado con éxito y podremos comprobar en las
propiedades del usuario que efectivamente es miembro del grupo ‘Profesores’ :

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/020.png" width="550"/>
  <figcaption>Añadir usuario a grupo III</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/021.png" width="550"/>
  <figcaption>Miembro de ...</figcaption>
</figure>

También podemos añadir usuarios a un grupo a partir del grupo. Para ello podemos seleccionar el grupo y con el botón de la
derecha propiedades, accedemos a la pestaña miembros:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/022.png" width="850"/>
  <figcaption>Añadir usuario a grupo IV</figcaption>
</figure>

Y accedemos a la pestaña miembros:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/023.png" width="850"/>
  <figcaption>Añadir usuario a grupo IV</figcaption>
</figure>

Y desde la opción Agregar podemos añadir los usuarios miembros del grupo.

## Creación de grupos por comandos

### DSADD GROUP

Para crear un grupo desde la consola, el comando utilizado es: [dsaddgroup](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc754037(v=ws.10))

- Para especificar si el grupo es de seguridad o de distribución se utiliza la opción: `secgrp yes` ( o `–secgrp` no si se trata de un grupo de distribución). 
- Para especificar el ámbito del grupo como universal, global o local se utiliza `–scope` seguido de `u , g o l` , respectivamente. Si no se
especifica nada por defecto se creará un grupo global y de seguridad.

#### Sintaxis:

``` yaml
dsadd group <GroupDN> [-secgrp {yes | no}] [-scope {l | g | u}] [-samid <SAMName>] [-desc <Description>] [-memberof <Group> ...] [-members <Member> ...] [{-s Server> | -d <Domain>}] [-u <UserName>] [-p {<Password> | *}] [-q] [{-uc | -uco | -uci}]
```

### New-ADGroup: Creación de grupos en powershell

También podemos realizar la creación de grupos desde powershell con el comando [New-AdGroup](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ee617258(v=technet.10)) 

#### La sintaxis del comando es la siguiente:

``` yaml
New-ADGroup [-Name] <string> [-GroupScope] <System.Nullable[Microsoft.ActiveDirectory.Management.ADGroupScope]> [-AuthType {<Negotiate> | <Basic>}] [-Credential <PSCredential>] [-Description <string>] [-DisplayName <string>] [-GroupCategory <System.Nullable[Microsoft.ActiveDirectory.Management.ADGroupCategory]>] [-HomePage <string>] [-Instance <ADGroup>] [-ManagedBy <ADPrincipal>] [-OtherAttributes <hashtable>] [-PassThru <switch>] [-Path <string>] [-SamAccountName <string>] [-Server <string>] [-Confirm] [-WhatIf] [<CommonParameters>]
```


## Unidades Organizativas

Una unidad organizativa es un contenedor de objetos (usuarios, grupos, equipos, otras unidades organizativas, etc.)
pertenecientes a un mismo dominio. Son especialmente útiles para reproducir la estructura de la empresa donde se halle el
dominio. Es decir, si por ejemplo, una empresa está dividida en tres departamentos (dirección, ventas y producción), podemos
crear tres unidades organizativas correspondientes a estos tres departamentos, donde incluyamos todos los objetos del
dominio correspondientes a cada una de las áreas de la empresa.

Su utilidad radica en dos aspectos fundamentales:

1. De esta manera es muy sencillo establecer directivas de seguridad (las veremos en el siguiente tema) que se apliquen
a todos los objetos de cada departamento.
2. Como dentro de la unidad organizativa, se pueden introducir otras unidades organizativas, se puede replicar la
estructura jerárquica de la empresa sin necesidad de crear más dominios o subdominios.

### Creación de Unidades Organizativas

Para crear una unidad organizativa abriremos la ventana '**Usuarios y Equipos de Active Directory**' (desde el Panel del
Administrador, '**Herramientas Administrativas**'). A continuación, nos situamos sobre el dominio y haciendo clic con el botón
secundario seleccionamos '**Nuevo**' y '**Unidad Organizativa**'

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/024.png" width="850"/>
  <figcaption>Unidades Organizativas</figcaption>
</figure>

A continuación se abrirá el diálogo que nos permite indicar el nombre del nuevo objeto:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/025.png" width="650"/>
  <figcaption>Creación OU (Organizational Unit)</figcaption>
</figure>

Al pulsar en Aceptar, se creará la Unidad Organizativa (OU) dentro de nuestro dominio. Notad también que por defecto se crea
una protección contra posibles errores de eliminación. Por defecto la unidad no se podrá eliminar de manera de manera
accidental.

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/026.png" width="550"/>
  <figcaption>Creación de una OU</figcaption>
</figure>

Dentro de una Unidad Organizativa podemos añadir objetos, usuarios, grupos, más unidades organizativas, etc... para ello
seleccionamos la OU y con el botón derecho del ratón accedemos a la opción Nuevo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/027.png" width="850"/>
  <figcaption>Añadir objetos a una OU</figcaption>
</figure>

Podemos añadir dos unidades organizativas dentro, una para Alumnos y otra para Profesores:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/028.png" width="850"/>
  <figcaption>Crear elementos dentro de una OU</figcaption>
</figure>

También podemos arrastras elementos de una unidad a otra, por ejemplo, vamos a arrastras los grupos de Alumnos y
Profesores y los usuarios que hemos creado. Seleccionamos el grupo Profesores y lo arrastramos a la unidad organizativa
Profesores:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/029.png" width="850"/>
  <figcaption>Mover objetos a OU</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/030.png" width="850"/>
  <figcaption>Mover objetos entre OU</figcaption>
</figure>

### Borrar una OU

Si tratamos de borrar una OU, veremos que nos aparece un mensaje de que no tenemos los suficientes privilegios para poder
realizar la acción de borrado. Esto es debido a la protección contra eliminaciones accidentales de las que hemos comentado
anteriormente:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/031.png" width="450"/>
  <figcaption>Borrar OU</figcaption>
</figure>

Para eliminar las unidades organizativas, en primer lugar deberemos activar las 'características avanzadas' seleccionando en
el menú 'Ver' la opción 'Características Avanzadas'.

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/032.png" width="750"/>
  <figcaption>Borrado de una OU</figcaption>
</figure>

Nos aparecerá la ventana de la OU:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/033.png" width="650"/>
  <figcaption>Desproteger una OU</figcaption>
</figure>

Desmarcamos el check de protección contra eliminaciones accidentales:

<figure>
  <img src="./imagenes/02/PracticasAD/PR06/034.png" width="650"/>
  <figcaption>Desactivar protección</figcaption>
</figure>

Ahora ya sí podemos eliminar la OU. Dejamos de nuevo desactivadas las opciones avanzadas desde la opción menú. En la próxima práctica, utilizaremos las unidades organizativas para gestionar de manera eficaz el dominio, aplicando directivas de seguridad específicas a cada unidad organizativa.

### Comandos


#### dsadd ou
Mediante el comando `dsadd ou` en `cmd` podemos crear una unidad organizativa. [ENLACE](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc770883(v=ws.10)) 

#### La sintaxis del comando es:

``` yaml
dsadd ou <OrganizationalUnitDN> [-desc <Description>] [{-s <Server> | -d <Domain>}][-u <UserName>] [-p {<Password> | *}] [-q] [{-uc | -uco | -uci}]
```

#### New-ADOrganizationalUnit

En PowerShell [New-ADOrganizationalUnit](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ee617237(v=technet.10)).

#### La sintaxis del comando es:

``` yaml
New-ADOrganizationalUnit [-Name] <string> [-AuthType {<Negotiate> | <Basic>}] [-City <string>] [-Country <string>] [-Credential <PSCredential>] [-Description <string>] [-DisplayName <string>] [-Instance <ADOrganizationalUnit>] [-ManagedBy <ADPrincipal>] [-OtherAttributes <hashtable>] [-PassThru <switch>] [-Path <string>] [-PostalCode <string>] [-ProtectedFromAccidentalDeletion <System.Nullable[bool]>] [-Server <string>] [-State <string>] [-StreetAddress <string>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

## Actividad 1

Crea dos usuarios con el nombre usuario1 y usuario2. Ponles a ambos la contraseña "Abc123!" y configura las cuentas de
usuario para que no tengan que cambiar la contraseña al iniciar sesión por primera vez. Agrega estos usuarios al grupo global
Alumnos y deshabilita la cuenta de usuario2.


1. Adjunta una captura de pantalla del error que sale al intentar acceder desde un equipo cliente con el usuario2. Habilita
de nuevo la cuenta de usuario2. Configura la cuenta usuario1 para que solamente pueda iniciar sesión desde el
equipo W10. Valida en el dominio otro equipo Windows 10 y comprueba que el usuario1 no puede iniciar sesión.
2. Configura la cuenta de usuario2 para que pueda iniciar sesión en cualquier equipo del dominio solamente de lunes a viernes de
8.00 a 18.00. Adjunta una captura de la pantalla de la configuración de los horarios de acceso al sistema del usuario2.
3. Intenta iniciar sesión en el equipo controlador de dominio con usuario2. ¿Por qué no puedes?¿Qué podrías hacer para
que usuario2 pudiera iniciar sesión en el controlador de dominio?