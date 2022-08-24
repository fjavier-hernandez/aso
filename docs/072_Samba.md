
<figure style="float: right;">
    <img src="imagenes/07/072/001.png" width="200"/>
</figure>


# SAMBA

## Configuración del servicio SAMBA

Como ya se ha visto con anterioridad, **Samba** es un conjunto de aplicaciones para GNU/Linux que implementan el protocolo de comunicación *SMB* utilizado por *Microsoft Windows* para compartir carpetas e impresoras. 

- Permite a sistemas GNU/ Linux compartir carpetas como si de un sistema *Microsoft Windows* se tratara.

En un servidor de archivos, el acceso a una carpeta puede estar determinado por dos conjuntos de entradas de permisos:

- los permisos de **recurso compartido** definidos tan solo a **carpetas**.
- los permisos de red o **NTFS** (*New Technology File System*) definidos tanto en **carpetas** como en **archivos**.

!!! note "**NOTA**"
    En sistemas operativos basados en GNU/Linux la gestión de los grupos y privilegios se hace a través de los comandos **samba-tool user** y **samba-tool group**.

- Los permisos de **recurso compartido** suelen utilizarse para administrar equipos con sistemas de archivos **FAT32** (*File Allocation Table*) o posterior, por lo que quedan desterrados en sistemas operativos de red. 

- Con la aparición del sistema de archivos **NTFS** (*New Technology File System*), se incluyeron nuevos tipos de permisos asignables a carpetas, y además, también a ficheros. 

!!! tip "**A tener en cuenta**"
    Ambos sistemas de permisos conviven en entornos de *Microsoft* por lo que será en el tema dedicado a ello cuando entraremos en detalle.

### Fichero Configuración

Toda la configuración de *Samba* se encuentra en el fichero **/etc/samba/smb.conf** &#8594 [DOCUMENTACIÓN OFICIAL](http://manpages.ubuntu.com/manpages/bionic/man5/smb.conf.5.html) .

!!! note "**NOTA**"
    Existen multitud de opciones pero tan solo se analizarán las imprescindibles para la compartición de recursos. Las líneas que comiencen con **#** o **;** están comentadas y el servicio no las tendrá en cuenta. 

**Este fichero tiene varios apartados, con opciones que se comentarán a continuación:**

- **[global],** se especifican opciones generales:

|Variable|Descripción|
| - | - |
|**workgroup**|Esta variable ha de almacenar el nombre del grupo de trabajo o dominio que usamos en nuestra red.|
|**server string**|Permite reconocer el equipo dentro del dominio. Por defecto tiene como valor el nombre del servidor.|
|**hosts allow**|Especifica desde qué direcciones IP se podrá acceder al servicio. Si se especifica  192.168. todas las direcciones que empiecen de ese modo tendrán acceso al recurso. Se puede establecer direcciones IP completas.|
|**hosts deny**|Especifica los rangos no permitidos, del mismo modo que **host allow**.|
|**security,**|Especifica el nivel de seguridad con el que se puede acceder.|

- **[autentication]**, donde se destaca **server role** &#8594 indica la forma en la que va a trabajar el servidor *Samba*:

|Variable|Descripción|
| - | - |
|**standalone server**|Modo por defecto, actúa como un servidor de ficheros y directorios compartidos pero no como servidor de dominio.|
|**member server**|similar al anterior con la diferencia que añadimos al equipo a un dominio ya existente y por tanto su funcionamiento se verá afectado por las reglas de éste. Esta opción requiere añadir las líneas **security=ADM**, para indicar que el control de acceso lo gestionará el  controlador de dominio, y **realm =NOMBREDOMINIO.COM** para indicar el nombre de dominio al que pertenece el servidor. Además, hay que comentar la línea **workgroup** ya que no pertenecemos a un grupo de trabajo.|
|**AD domain controler**|actúa como un controlador de dominio.|

### Creación Directorio Compartido

- Para crear un directorio compartido es necesario añadir una nueva sección del siguiente modo:

``` yaml
[compartidoUser1]
comment = Carpeta compartida 
path = /media/compartido/user1
guest ok = Yes
read only = Yes
write list = @Ceos, administrador, user1 directory mask = 0755
```

!!! note "**NOTA**"
    - Estas  líneas  crean  un  recurso  compartido  con  el  nombre **compartidoUser1**  en  el  directorio **/media/compartido/user1** de solo lectura, con acceso de invitado, los usuarios **administrador** y **user1** pueden escribir  y el grupo **@Ceos** también. 
    - Además, se aplicará una máscara de permisos automática de 0755 a los ficheros y carpetas que se creen en este recurso.

- Las opciones más relevantes son:

|Variable|Descripción|
| - | - |
|**guest ok**|Permite el acceso como usuario invitado. Su valor puede ser **Yes** o **No**.|
|**public**|Equivalente del parámetro **guest ok**.|
|**browseable**|Permitirá mostrar este recurso en las listas de recursos compartidos. Su valor puede ser **Yes** o **No**.|
|**writable**|Permitirá la escritura. Su valor puede ser **Yes** o **No**.|
|**valid users**|Especifica qué usuarios o grupos pueden acceder al recurso compartido. Mirar valores en la Nota a continuación de esta tabla.|
|**write list**|Usuarios o grupos pueden acceder con permiso de escritura.|
|**admin users**|Usuarios o grupos pueden acceder con permisos administrativos.|
|**directory mask**|Define que permisos en el sistema tendrán los subdirectorios creados dentro del recurso.|

!!! note "**NOTA: valores `valid users`**"
    - nombres de usuarios separados por comas
    - nombres de grupo precedidos por una *@*
    - **%S** indica que solo el usuario cuyo nombre sea igual al de ese directorio, tiene acceso (útil para las carpetas personales de usuario)

!!! tip "**A tener en cuenta**"
    - Una vez añadido el recurso, es necesario reiniciar el servicio para que se apliquen los cambios

``` yaml
/etc/init.d/smbd restart
```

- Por último, para acceder al recurso se realizará a través de cualquier navegador de archivos usando el protocolo **smb** especificando el usuario, la dirección del recurso y su nombre del siguiente modo:

``` yaml
smb://usuario1@servidorubuntu/compartido1
```

## Integración de permisos **GNU/Linux** – **Microsoft Windows**

Para poder utilizar los permisos **NTFS** en *GNU/Linux* es necesario realizar una serie de configuraciones descritas en el siguiente apartado. **Esto permitirá integrar de forma transparente ambos sistemas**.

!!! note "**NOTA**"
    La administración de los permisos en *Ubuntu Server* se realizan a través del conjunto de herramientas de **samba-tool**, en concreto **dsacl** y **ntacl**.  

**Hay que tener en cuenta varias cosas antes de usar los permisos NTFS en *Ubuntu Server*:**

- El volumen que contenga el recurso compartido debe disponer de las opciones **acl** durante su montaje. Estas opciones serán indicadas en el fichero `/etc/fstab` para automatizar el proceso.
- Si el sistema de ficheros del volumen no es **ext4**, será necesario la instalación de esta característica. En **ext4** viene integrada por defecto.
- los permisos que se apliquen a un recurso a través de *Samba* solo serán válidos a través de este servicio, por lo que se desaconseja el acceso en local al controlador de *Active Directory*.

!!! tip "**A tener en cuenta**"
    Será necesario ahora **ampliar los permisos**  que GNU/Linux establece a los ficheros para que sean compatibles con los de NTFS de *Microsoft Windows*. Ya que se quiere integrar este servido en una estructura de *Active Directory* será necesario que los permisos asignados a los ficheros sean entendibles por los clientes *Microsoft Windows* que accedan a este servidor.

- Para ello se necesita instalar dos paquetes el **attr** y el **acl** que juntos compatibilizan las listas de control de acceso entre ambos sistemas.

!!! note "**NOTA**"
    La parte interesante de estos paquetes es que esta ampliación de permisos se le puede asignar a tan un medio determinado o a todo el sistema, **por lo que ambos permisos de acceso pueden convivir sin conflicto alguno**.

Los pasos para realizar los dos aspectos comentados son:

1. A continuación, se debe instalar **un segundo disco duro en el servidor**. Se convertirá este disco duro en un volumen y se destinará a almacenar los ficheros compartidos del servidor, por lo tanto, será a este volumen al que se le asignará la nueva configuración de permisos. 

Para realizar esta tarea, seguiremos estos pasos:

- Se añadirá un disco duro **SATA** a la máquina virtual de **1 TB** de capacidad.
- Se asignará una partición primaria que ocupe el disco entero.

``` yaml
sudo fisk /dev/sdb
```

- Es necesario asignar un sistema de ficheros, en este caso **ext4** 

``` yaml
sudo mkfs -t ext4 /dev/sdb1
```

- Debe crearse un punto de montaje en **/media/datos**.

``` yaml
sudo mount /dev/sdb1 /media/datos
```

2. Otra acción a llevar a cabo es hacer el montaje del nuevo volumen de forma automática al iniciar el sistema. Pare ello será necesario incluir esta información en el fichero **/etc/fstab**:

``` yaml
/dev/sdb1 /media/datos ext4 defaults 0 0
```

3. Ahora se instalarán los paquetes necesarios para la asignación de los nuevos permisos:

``` yaml
sudo apt-get install acl attr
```

4. Una vez terminada la instalación, se asignará la ampliación de permisos a este nuevo volumen añadiendo **user\_xattr,acl,barrier=1** al fichero **/etc/fstab**. Debe quedar de la siguiente manera:

``` yaml
/dev/sdb1 /media/datos ext4 user\_xattr,acl,barrier=1,defaults 0 0
```

5. Por último se comprueba que todo ha ido bien reiniciando el equipo y accediendo a la carpeta **/media/datos**.

!!! note "**NOTA**"
    Antes de administrar los permisos de un recurso compartido en un servicio *Active Directory* con *Samba*, será necesario su creación y compartición. Esta tarea se realiza añadiendo el recurso al fichero `/etc/samba/smb.conf`.

El aspecto que tiene este fichero es el siguiente:

``` yaml
\# Global parameters
[global]
    dns forwarder = 8.8.8.8
    netbios name = SERVIDORUBUNTU
    realm = MIEMPRESA.LOCAL
    server role = active directory domain controller workgroup = MIEMPRESA idmap\_ldb:use rfc2307 = yes
[netlogon]
    path = /var/lib/samba/sysvol/miempresa.local/scripts read only = No
[sysvol]
    path = /var/lib/samba/sysvol
    read only = No
```

- Tanto **netlogon** como **sysvol** son recursos compartidos que han sido creados durante el proceso de instalación del directorio, y por tanto, son necesarios para el correcto funcionamiento del sistema. Será aquí dónde se crearán los nuevos recursos

``` yaml
[compartido]
    path = /media/datos 
    read only = No
```

Una vez guardado el fichero de configuración, se reinicia el servicio *Samba* para que los cambios tengan efecto

``` yaml
service smbd stop
service smbd start
```

!!! note "**NOTA**"
    A partir de este momento, el recurso **/media/datos** está accesible desde *Samba*, aunque sin ningún tipo de restricción.

- Será necesario ahora el acceso a esta carpeta desde **RSAT** con una cuenta de administración para modificar los permisos de acceso, de igual forma como se realiza en una carpeta compartido en un controlador de domino con *Microsoft Windows*.

- A medida que se vayan cambiado los permisos de este recurso a través de **RSAT**, será posible consultarlos desde el terminal con el subcomando **ntacl** o directamente con el comando **getfacl**

``` yaml
samba-tool ntacl get /media/datos
```

- El cual ofrece información detallada de los permisos o que ofrecerá información de los permisos a modo de resumen.

``` yaml
getfacl /media/datos
```

## Administración de permisos con **RSAT**

A pesar de la existencia de las herramientas ofrecidas por *Samba*, la gestión de los permisos de carpetas se realizará con **RSAT**. 

- **RSAT** **(*Remote Server Administration Tools*) es** una aplicación cuyo objetivo es administrar el servidor pensada para instalarse en clientes que replica las herramientas disponibles en el controlador del dominio. 
- Este *software* está idealmente pensado para servidores tipo **CORE** en los que no existe una GUI y toda su administración queda adscrita a un terminal. El consumo de recursos de la GUI queda traspasada al cliente. 

!!! note "**NOTA**"
    Es preciso señalar que cualquier usuario con permiso para instalar *software* podrá realizar estas acciones, pero en ningún caso administrar el servidor.

<figure>
  <img src="./imagenes/07/072/002.png" width="650"/>
  <figcaption>Actualización del sistema con el añadido de RSAT.</figcaption>
</figure>

!!! note "**NOTA**"
    - Esta tarea es más efectiva y concisa desde el GUI ya que no será necesario recordar todos los usuarios ni grupos creados en el directorio mientras se configuran los permisos. 
    - En efecto, el uso de GUI para la asignación de permisos facilita esta tarea que, en CLI, puede llegar a complicarse en demasía. Por este motivo se utilizará la administración remota que funciona de igual modo que en sistemas operativos de *Microsoft*.

- Para poder utilizar **RSAT** será necesario **iniciar sesión como administrador del dominio o una cuenta que disponga de permisos suficientes**. No obstante, por coherencia del proceso, se realizará todo con la cuenta de administrador de dominio.

Se inicia sesión en el cliente con la cuenta de administrador de dominio, descargar la versión correcta y se instala el programa. En realidad lo que hace este programa es añadir una herramienta al sistema operativo, como si de una actualización del mismo se tratase. Para ello hay que dirigirse a  `Inicio` &#8594 `Configuración` &#8594  `Aplicaciones` &#8594  `Características Opcionales` &#8594  `Agregar una característica` &#8594  `RSAT: Administrador del servidor` y pulsar el botón de  `Instalar`.

Tras el proceso de instalación y el pertinente reinicio, se comprueba que en el menú de  Inicio existe una nueva aplicación denominada **Administrador del servidor** y que la interfaz gráfica de esta herramienta es exactamente igual que la de *Microsoft Windows Server*. De esta forma será más sencillo el cambio entre una y otra forma de administrar el servidor.

El siguiente paso es conectar esta herramienta con el servidor que se debe administrar. Si en la infraestructura de red existe más de uno, es posible tener una de estas herramientas para cada uno, eso sí, en diferentes clientes.

Para enlazar esta herramienta con el servidor se pulsa el botón derecho sobre la opción  `Todos los servidores` →  `Agregar servidores` del panel de la izquierda

<figure>
  <img src="./imagenes/07/072/003.png" width="650"/>
  <figcaption>Añadir el servidor a administrar al RSAT.</figcaption>
</figure>

!!! note "**NOTA**"
    A partir de este momento toda la gestión realizada en esta herramienta tendrá su efecto en el controlador de dominio configurado.

## Perfiles de usuario y carpetas personales

Habitualmente los usuarios trabajan con la misma máquina, pero hay ocasiones en las que es necesario que cambien su ubicación de trabajo. Es buena idea entonces que el perfil de ese usuario viaje con él, ya que éste contiene gran parte de la información de trabajo.

El fichero **/etc/profile** contiene la estructura de los perfiles. Además, durante el proceso de creación de perfiles, consulta los *scripts* ubicados en la carpeta **/etc/profile.d** que también ejecutará durante la creación de un usuario.

Dentro de cada perfil es posible encontrar la siguiente información:

- **Configuración local**, que contiene datos de programa, historial y archivos temporales
- **Datos de programa**, configuraciones especificas de software de cada usuario, archivos, carpetas, accesos directos, escritorio documentos y plantillas de usuario
- **Configuración de inicio**, elementos del menú Inicio del usuario así como aplicaciones

!!! note "**NOTA**"
    No es de extrañar que si un usuario cambia de equipo y crea un nuevo perfil, eche de menos toda esta información y, aún peor, no pueda desempeñar su trabajo con normalidad.

### Perfiles

Existen diferentes tipos de perfiles, aunque en este tema se trabajará con los siguientes:

- **Perfiles locales**, creados en un equipo cuando un usuario inicia sesión. El perfil es específico de un usuario y se almacena en el disco duro del equipo local.
- **Perfiles móviles**, creados por un administrador y almacenados en un servidor. Estos perfiles siguen al usuario a cualquier máquina donde éste inicie sesión.

#### Perfiles locales

Los perfiles locales se crean en los equipos cuando los usuarios inician sesión. En GNU/Linux, los perfiles de usuario se crean en la carpeta **/home/$USER**, con la excepción del usuario **root**, que por motivos de seguridad posee su propio perfil en la ruta **/root**. 

Toda la información referida al usuario se encuentra en el directorio **/home/$USER**. Cuando se accede con usuarios distintos, tanto el usuario local como el usuario de red dispondrán de diferentes perfiles.

#### Perfiles móviles

Un perfil móvil **se almacena en un servidor** y, después de que el inicio de sesión del usuario sea autentificado, se copia al equipo local. Esto permite al usuario tener el mismo escritorio, la configuración de las aplicaciones y la configuración local en cualquier máquina. Al cerrar la sesión, el perfil se almacena tanto localmente como en la ubicación de la ruta de acceso al perfil del usuario.

- Cuando el usuario inicia sesión de nuevo, el perfil del servidor se compara con la copia en el equipo local y se carga la versión más reciente. Si el servidor no esta disponible, se utiliza la copia local. 
- Si el servidor no esta disponible y es la primera vez que el usuario ha iniciado sesión en el equipo se crea un perfil de usuario localmente utilizando la configuración por defecto.

**Para configurar un perfil móvil simplemente hay que completar las siguientes acciones:**

1. crear una **carpeta compartida** en el servidor para los perfiles.
2. asignar en la cuenta de usuario una **ruta de acceso** a la carpeta compartida.

Una vez realizadas estas acciones, el perfil de usuario se copia en el servidor y estará disponible para el usuario desde cualquier equipo.

Para poder acceder desde un equipo a una carpeta compartida por **nfs** en un servidor, será necesario instalar los paquetes `portmap` y `nfs-common` en el cliente

``` yaml
sudo apt-get install portmap nfs-common
sudo /etc/init.d/portmap restart
```

Cuando finalice la instalación será posible utilizar el sistema **nfs** como un nuevo sistema de ficheros de red, lo que permitirá gestionar carpetas remotas como si fuesen propias del sistema local.

Ahora es posible montar la carpeta compartida en nuestro sistema de archivos. De esta manera, el acceso es exactamente igual que a cualquier otra carpeta del disco duro local.

En el servidor existe la carpeta compartida **/datos/usuarios/usuario1** con los datos del usuario `usuario1`. Es posible montar esa carpeta como si fuera una más del sistema de ficheros local

``` yaml
sudo mount -t nfs ip-del-servidor:/home/MIEMPRESA.LOCAL/usuario1/datos
```

!!! note "**NOTA**"
    A  partir  de  este  momento  la  carpeta  datos  contiene  la  información  de  la  carpeta **/datos/usuarios/usuario1** del servidor.

Como ya se ha estudiado, es posible que el sistema monte de forma automática una carpeta compartida por **nfs** al iniciar sesión a través del archivo **/etc/fstab**

``` yaml
ip-del-servidor:/home/MIEMPRESA.LOCAL/usuario1/datos nfs
```

Del mismo modo que se ha creado un recurso de red para contener el perfil del usuario, es **posible repetir estos pasos para crear una carpeta personal a cada usuario**.

Para esta tarea se utilizará el servicio *Samba*, aunque es posible realizarla también con el protocolo **nfs**. Para ello habrá que crear un recurso para cada usuario del siguiente modo:

``` yaml
[usuario1]
comment = Carpeta con acceso exclusivo para usuario1 path = /media/usuarios/usuario1
guest ok = No
public = No
read only = Yes
write list = %S
```

!!! note "**NOTA**"
    La última línea del la configuración limita el acceso al recurso al usuario que se llame igual que el nombre de la carpeta.

## Cuotas de disco

Las cuotas de disco permiten controlar la **cantidad de ficheros que se introducen en un recurso compartido**. El espacio de almacenamiento de un servidor es finito y, aunque no lo parezca, si se estrangula uno de los volúmenes, es un tarea costosa asignar nuevo espacio o simplemente no es posible. Con la herramienta **Administración de cuotas**, se pueden realizar las siguientes tareas:

- Crear cuotas para limitar el espacio asignado a un volumen o carpeta y generar notificaciones cuando se esté a punto de alcanzar o superar el límite de dichas cuotas
- Generar cuotas automáticas aplicables a todas las carpetas existentes en un volumen o una carpeta y a todas las subcarpetas que se creen
- Definir plantillas de cuota que puedan aplicarse fácilmente a nuevos volúmenes o carpetas y que puedan utilizarse en toda una organización

En los sistemas operativos basados en GNU/Linux es posible establecer límites de almacenamiento por usuario e incluso por grupo de usuarios. Es factible establecer cuotas con dos enfoques diferentes:

1. Es posible **limitar el número de bloques** de disco, con lo que se limita el tamaño en disco del que el usuario dispone, tal y como ocurría en *Microsoft Windows Server*, 
2. Por otro lado, se puede limitar el **número de *nodos-i***, lo que establece un límite de ficheros por usuario, independientemente del espacio que ocupen

Además se puede fijar dos tipos de límites, el **rígido** o *hard* que impide que el límite sea sobrepasado, y el **flexible** o *soft* que no limita el espacio en disco pero sí avisa al administrador que se han excedido ciertos límites.

Desde la versión 14.04 de *Ubuntu Server* el  *kernel* viene preparado para soportar cuotas de disco, por lo que tan solo será necesario la instalación del paquete que permite gestionar las cuotas: **quota**  y **quotatool**.

``` yaml
sudo apt-get install quota quotatool
```

Al igual que ocurría en el caso anterior, las cuotas han de ser activadas para cada uno de los volúmenes del sistema. Para ello es necesario especificarlo en las opciones del fichero **/etc/fstab**.

``` yaml
/dev/sdb1 /media/Datos ext4 defaults,usrquota,grpquota    0   0
```

En las opciones de montaje se han añadido las opciones de **usrquota** y **grpquota**, que permitirán la asignación de cuotas de disco tanto a usuarios como  a  grupos  respectivamente.   Para  que  los  cambios tengan  efecto,  se monta y desmonta el volumen aplicando la nueva configuración especificada en el fichero **/etc/fstab**

``` yaml
sudo mount -o remount,rw /media/Datos
```

La unidad ya está preparada para contener cuotas de disco, por lo que será preciso crearlas a través de los comandos que se han instalado: **quotacheck**, **edquota** y **repquota**.

``` yaml
sudo quotacheck -cgu /media/Datos
```

El comando anterior activa las cuotas para el volumen. La opción **-c** crea los ficheros de configuración necesarios para guardar la información de las cuotas, mientras que las opciones **-u** y **-g** activan las cuotas de usuario y grupo respectivamente. 

Si todo ha ido bien, en la carpeta raíz del volumen montado aparecerán dos ficheros **aquota.group** y **aquota.user** que contendrán la configuración de las cuotas para los usuarios y grupos. No se trata de archivos de texto plano como es habitual, sino que estarán cifrados.

Para añadir una cuota a un usuario se utiliza el comando

``` yaml
edquota -u administrador
```

Aparecerá en pantalla el editor de texto predeterminado junto con la configuración del usuario especificado

``` yaml
Disk quotas dor user administrador (uid 1000):
Filesystem blocks soft hard inodes soft hard
/dev/sdb1   0       0   0      0    0   0
```

El significado de cada columna es:

- **Filesystem**, indica el volumen en el que se activan las cuotas
- **blocks**, señala el número de bloques que el usuario o grupo está utilizando
- **inodes**, apunta el número de nodos-i que el usuario o grupo está usando
- **soft**, representa un valor de bloques o nodos-i que permite sobrepasar durante un determinado tiempo
- **hard**, es el límite de bloques o nodos-i que no es posible superar

Modificando estos valores y guardando el fichero se establecerán las cuotas del usuario **administrador**. Además se debe tener en cuenta:

- Configurar un valor de cuota a cero significa que no existe límite alguno de almacenamiento para ese usuario.
- Las cuotas para grupos se realizan exactamente igual que con los usuarios. Si es necesario su edición, se volverá a ejecutar el mismo comando y se modificarán los valores oportunos.

En la descripción de la columna **soft** se hizo referencia a que ese valor es posible rebasarlo durante un tiempo determinado. A ese tiempo se le conoce como **periodo de gracia**, y una vez superado el límite flexible **soft** se convierte en límite rígido no pudiendo superarlo. 

Para modificar esta configuración se utiliza el comando:

``` yaml
sudo edquota -t
```

!!! note "**NOTA**"
    Establecerá un valor para el volumen que afectará a todos los usuarios y grupos que tengan una cuota configurada en dicho volumen.

Para consultar todas las cuotas disponibles se utilizará el comando:

``` yaml
sudo repquota /dev/sdb1
```

El cual ofrecerá información detallada sobre los usuarios y grupos que disponen de cuota en dicho volumen.

``` yaml
\*\*\* Report for user quotas on device /dev/sdb1
Block grace time: 7days; Inode grace time: 7days

                            Block limits                File limits
User            used    soft    hard  grace    used  soft  hard  grace 
---------------------------------------------------------------------- 
root      --      20       0       0              2     0     0       
usuario   +-     351     300       0             15     0     0
```

!!! tip "**A tener en cuenta**"
    El formato de salida del informe es autoexplicativo, a excepción de la segunda columna. Los guiones que aparecen a la derecha del nombre de usuario, representan si se ha excedido o no el límite flexible tanto de bloques como de nodos-i.

Si se excede este límite el **-**  será modificado por **+**. De esta forma es relativamente sencillo buscar aquellos usuarios que han superado el límite flexible a través del comando

``` yaml
    sudo repqutota /dev/sdb1 | grep “\+”
```

Para calcular el tamaño de la cuota a través de bloques será necesario conocer el tamaño del bloque del volumen al que se han aplicado las cuotas. Para ello se puede usar el comando **tune2fs** que ofrece amplia información sobre las características de un volumen, entre toda ella, el número de bloques:

``` yaml
tune2fs -l /dev/sdb1 | grep “Block size”
```

!!! tip "**A tener en cuenta**"
    Ahora tan solo queda multiplicar este tamaño por el número de bloques asignado a la cuota.

Por último, es posible desactivar las cuotas de forma temporal para, por ejemplo, realizar ciertas tareas de mantenimiento o administración,

``` yaml
quotaoff /dev/sdb1
```

Y volverlas a activar

``` yaml
quotaon /dev/sdb1
```

!!! note "**NOTA**"
    - Recuerda que esta desactivación es temporal. Si se desactivan las cuotas con este comando y se reinicia el sistema, volverán a estar activas ya que se inicializan a través del fichero **/etc/fstab**. 
    - Si es necesario desactivarlas de forma permanente se deben configurar con un valor de cero en el archivo de cuotas.

## Actividades Iniciales UD7

701. [Instalación Servidor Samba](./Practica14_samba.md)

## Actividades de desarrollo UD7_01

702. [Configuración de Secciones y Usuarios en SAMBA](./Practica15_SambaSecUsers.md)

## Actividades de desarrollo UD7_02

703. [Configuración de Controlador de Dominio en SAMBA](./Practica16_SambaDC.md)