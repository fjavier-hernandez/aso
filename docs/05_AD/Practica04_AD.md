# Instalación de Active Directory I

Objetivos de esta práctica:

- Instalar y promocionar un servidor a controlador de dominio
- Crear estructuras centralizadas de administración de redes
- Unir equipos cliente al dominio

## Creación de un dominio

El primer paso para la creación del Active directory es crear un dominio; en el equipo **Controlador de Dominio**, y debe ser un equipo preparado para aguantar altas cargas de trabajo con una alta disponibilidad, y con un sistema operativo servidor instalado. 

- Para crear un dominio hay que acceder al **Administrador del Servidor** y accedemos a ->  **Agregar Roles y Características**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/001.png" width="900"/>
  <figcaption>Creación de un dominio I.</figcaption>
</figure>

- Nos aparecerá el asistente para comenzar con la creación del dominio:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/002.png" width="900"/>
  <figcaption>Creación de un dominio II.</figcaption>
</figure>

Seleccionaremos una **instalación basada en características y roles**. También podemos hacer una instalación a través de
servicios de acceso remoto, pero en nuestro caso realizaremos la instalación en local.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/003.png" width="900"/>
  <figcaption>Creación de un dominio III.</figcaption>
</figure>

Una vez seleccionada la **instalación basada en roles**, seleccionaremos nuestro servidor que será donde vamos a instalar
nuestro Active Directory:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/004.png" width="900"/>
  <figcaption>Creación de un dominio IV.</figcaption>
</figure>

Seleccionaremos el rol **Servicios de Dominio de Active Directory**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/005.png" width="900"/>
  <figcaption>Creación de un dominio V.</figcaption>
</figure>

Y nos aparecerá marcado el rol tal y como muestra la siguiente figura:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/006.png" width="900"/>
  <figcaption>Creación de un dominio VI.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/007.png" width="900"/>
  <figcaption>Creación de un dominio VII.</figcaption>
</figure>

Y procedemos a realizar la instalación. Cuando se agrega un nuevo rol, podemos hacer clic en la opción de reiniciar en caso
de que fuera necesario. En caso que el rol o la característica no fuera necesario un reinicio, no lo haría.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/008.png" width="900"/>
  <figcaption>Creación de un dominio VIII.</figcaption>
</figure>

Un vez instalado, el asistente nos dice que es necesario realizar una configuración. En este caso hay que promover nuestro
servidor a un servidor de controlador de dominio. Así que haremos clic en la opción de **promover servidor a controlador de
dominio** :

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/009.png" width="900"/>
  <figcaption>Creación de un dominio IX.</figcaption>
</figure>

Ejecutamos el asistente, y las primeras pantallas nos ofrecen información útil para la creación del dominio.

- **Seleccionamos Agregar un nuevo bosque**.

!!! Note
    Un conjunto de dominios agrupados lógicamente conforman un árbol de dominios y un conjunto de árboles de dominio agrupados lógicamente conforman un bosque. **En nuestro caso pondremos el dominio ASO2122.LOCAL en lugar de CEFIRE2019.LOCAL como indica en la imagen**:


<figure>
  <img src="./imagenes/02/PracticasAD/PR04/010.png" width="900"/>
  <figcaption>Agregar un nuevo Bosque.</figcaption>
</figure>


A continuación, nos aparece información sobre el nivel funcional del nuevo bosque. Según el nivel funcional que
establezcamos, implementaremos un directorio activo compatible con versiones anteriores de Windows Server, pero más
limitado en cuanto a funciones, o menos compatible con versiones antiguas, pero con mayores funcionalidades. 

!!! tip 
    En nuestro caso, seleccionaremos el mayor nivel funcional (**Windows Server 2016**) ya que todos los controladores del dominio tendrán instalado, al menos, **Windows Server 2016**. También añadiremos la contraseña para la restauración de nuestro dominio, por defecto la misma que la del administrador.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/011.png" width="900"/>
  <figcaption>Creación de un dominio X.</figcaption>
</figure>

La siguiente tarea que llevará a cabo el asistente para la creación del dominio, será preguntar por ciertas opciones adicionales
del servidor, como por ejemplo la **configuración del servicio DNS**. Como en nuestro caso no tenemos DNS, dejaremos que el
asistente cree una zona de DNS para que nuestro dominio pueda funcionar.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/012.png" width="900"/>
  <figcaption>Creación de un dominio XI.</figcaption>
</figure>

A continuación nos aparece la ubicación donde se guardará los objetos de nuestro AD, es decir, **la base de datos**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/013.png" width="900"/>
  <figcaption>Creación de un dominio XII.</figcaption>
</figure>

Seguidamente nos muestra las configuraciones que se van a realizar. 

!!! Note 
    Como podéis observar también se puede exportar el script para poder ejecutar los mismos comandos a través de **PowerShell**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/014.png" width="900"/>
  <figcaption>Creación de un dominio XIII.</figcaption>
</figure>

En el siguiente paso se muestra un resumen de los **Requisitos previos**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/015.png" width="900"/>
  <figcaption>Comprobación de requisitos previos.</figcaption>
</figure>

Y finalmente realizaríamos la instalación. Nuestra pantalla de inicio de sesión, ahora será diferente, ya que nos aparece el
dominio al que vamos a iniciar la sesión del usuario:

!!! Note
    Nos aparecerá **ASO2122** en lugar de **CEFIRE2019**

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/016.png" width="900"/>
  <figcaption>Nueva pantalla inicio de sesión con Dominio.</figcaption>
</figure>

Una vez instalado, podemos iniciar sesión con el Administrador del dominio. Podemos comprobar que en el panel de
Administrador de Servidor aparece nuestro dominio configurado **ASO2122.LOCAL** en lugar de **CEFIRE2019.LOCAL**

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/017.png" width="900"/>
  <figcaption>Comprobación Dominio n Administrador de Servidor.</figcaption>
</figure>

# Creación de dominio en Server Core

Se podría hacer una instalación sin experiencia de escritorio del Windows Server 2019 esto es una instalación mucho más liviana que permite tener un servidor sin entorno gráfico. A esta versión se le conoce como el nombre de **Server Core**. En este punto vamos a mostrar a realizar una instalación de un dominio en una máquina Server Core.

Para hacer la instalación, debemos seleccionar la opción de instalación sin experiencia de escritorio:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/018.png" width="900"/>
  <figcaption>Instalación Server Core.</figcaption>
</figure>

## PowerShell para configurar un dominio

Para configurar el dominio con PowerShell vamos a presentar unos scripts que permitirán realizar la configuración tanto de la máquina como del Active
Directory. Para entrar dentro del shell de PowerShell, teclearemos el comando **powershell** en la consola:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/019.png" width="900"/>
  <figcaption>Entrar al PowerShell en el Server Core.</figcaption>
</figure>


### Configuración inicial

Primero realizaremos la configuración de la máquina, a través del siguiente script. 

`ConfiguracionInicial.ps1`
```yaml
$nombreServer="ASO2122"
$dirIP="192.168.5.1X"
$redInterna="Ethernet 2"
Rename-Computer -NewName $nombreServer
Get-NetAdapter –name $redInterna | Remove-NetIPAddress -Confirm:$false
Get-NetAdapter –name $redInterna | New-NetIPAddress –addressfamily IPv4 –ipaddress $dirIP –prefixlength 24 –type unicast
```

!!! Warming
    Después de la captura se debe reiniciar para aplicar los cambios.

**Donde se Puede observar:**

- El nombre de máquina en la variable `$nombreServer`
- El adaptador de la red interna en $redInterna (Ejemplo en el script) y también la dirección IP de la red interna en `$dirIP`. 
- El comando` _Rename-Computer -NewName $nombreServer` cambia el nombre del servidor. 
- Los comandos: 
    - `_Get-NetAdapter –__name $redInterna | Remove-NetIPAddress -Confirm:$false` 
    - `_Get-NetAdapter –name $redInterna | New-NetIPAddress –addressfamily IPv4 –ipaddress`
    - `$dirIP –prefixlength 24 –type unicast` 
  Nos permiten añadir la dirección IP de nuestra red interna.
- Finalmente con `_Restart-Computer -force` reiniciamos la máquina y tendremos configurado el nombre y el interfaz de la red interna.

### Instalar Controlador de dominio con powershell

Ahora vamos a promover nuestro servidor a controlador de dominio. Esto también lo vamos a realizar a través de powershell
mediante scripts. 

`creaciondominio.ps1`
``` yaml
$dominioFQDN = "ASO2122CORE.LOCAL"
$dominioNETBIOS = "ASO2122CORE"
$adminPass = "aso2122."
Install-WindowsFeature AD-Domain-Services,DNS
Import-module addsdeployment
Install-ADDSForest -DomainName $dominioFQDN -DomainNetBiosName $dominioNETBIOS -SafeModeAdministratorPassword (ConvertTo-SecureString -string $adminPass -AsPlainText -Force) -DomainMode WinThreshold -ForestMode WinThreshold -InstallDNS -Confirm:$false
```

**Donde se Puede observar:**

- En la variable `_$dominioFQDN_` pondremos nuestro nombre de dominio 
- y en `_$dominioNETBIOS_` el nombre de dominio NETBIOS. 
- El comando `_Install-WindowsFeature AD-Domain-Services,DNS_` instala los roles de AD y también de DNS.
- El comando` _Install-ADDSForest_` realiza la configuración del dominio.

Al ejecutarlo mostraría por pantalla:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/020.png" width="900"/>
  <figcaption>Creación de dominio en Server Core.</figcaption>
</figure>

Finalmente reiniciamos la máquina y ya tenemos instalado nuestro controlador de dominio en una máquina core con
powershell. Notad que el inicio de sesión ahora ya es es ASO2122.LOCAL.
<figure>
  <img src="./imagenes/02/PracticasAD/PR04/021.png" width="900"/>
  <figcaption>Nuevo Inicio Sesión en Server Core.</figcaption>
</figure>

Para comprobar que todo se ha configurado de manera correcta, podemos iniciar sesión y ejecutar el comando **sconfig**. Nos
muestra información relativa al nombre de máquina, dominio y algunas otras opciones:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/022.png" width="900"/>
  <figcaption>Utilidad de inspección sconfig.</figcaption>
</figure>

### Apagado de la máquina

!!! Note
    Para poder apagar la máquina podemos hacer uso del comando `shutdown /p` o bien a través de la `opción 14` de la utilidad `sconfig`.

## Unir clientes al dominio

### Añadir máquinas clientes al dominio

Para incluir en el dominio los equipos que actuarán como cliente hay que configurar las propiedades de Internet de cada una
de las máquinas que vamos a unir al dominio, teniendo en cuenta que:

La dirección del controlador de dominio (que implementa funciones de DNS) es la 192.168.5.1X. La máscara de subred es de
24 bits. 

!!! Note
    En la red que se ha montado **como ejemplo** hay un elemento de interconexión con **IP 192.168.100.1** que implementa las funciones de puerta de enlace y de DNS, por ese motivo se ha incluido como puerta de enlace predeterminada y como DNS secundario, sin embargo estos dos campos no son necesarios si únicamente queremos trabajar en el interior de una única red. Más adelante veremos instalación de un **servicio de DHCP** y el enrutamiento, para que nuestro servidor pueda ofrecer a los clientes de la red interna una dirección de manera dinámica.

A continuación, en el siguiente ejemplo, se revisa la configuración de la máquina cliente **Windows 10** que vamos a validar en el dominio Windows Server 2019 (utilizaremos la máquina con interfaz gráfica):

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/023.png" width="900"/>
  <figcaption>Configuración red cliente Windows 10.</figcaption>
</figure>

!!! Note
    La figura anterior es un ejemplo de configuración, habrá que adapatarlo al rango utilizado en el Aula.

Comprobaremos también que desde la máquina cliente podamos hacer ping a nuestro dominio, esto es al dominio
**ASO2122.LOCAL**. Para ello abrimos una terminal en la máquina **Windows 10 (Tecla Windows + R y luego cmd)** y
comprobamos que el ping al dominio funcione. 

!!! Warning
    **Es importante que este ping funcione, en caso contrario no se podrá realizar la validación en nuestro dominio**.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/024.png" width="900"/>
  <figcaption>ping al dominio.</figcaption>
</figure>

Y ahora sí, ya podemos unir nuestra máquina al dominio. Para ello, en Windows 10, seleccionaremos el botón de inicio y con
el botón de la derecha del ratón, seleccionaremos Sistema:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/025.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio I.</figcaption>
</figure>

Seleccionamos Conectar a la red del trabajo o colegio y nos aparecerá la siguiente información:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/026.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio II.</figcaption>
</figure>

Hacemos clic en Conectar:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/027.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio III.</figcaption>
</figure>

Seleccionamos la opción de Unir este dispositivo a un dominio local de Active Directory. Nos aparecerá una ventana para
introducir el nombre de dominio al que nos queremos conectar:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/028.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio IV.</figcaption>
</figure>

En nuestro caso, introduciremos nuestro nombre de nominio, **ASO2122.LOCAL** en lugar de **CEFIRE2019.LOCAL**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/029.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio V.</figcaption>
</figure>

Para poder realizar la validación, hay que introducir la cuenta del Administrador del dominio y su contraseña, en nuestro caso,
será Administrador y como contraseña cefire2019.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/030.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio VI.</figcaption>
</figure>

Seleccionamos que nuestro administrador tenga los privilegios de administrador en la máquina cliente, para ello selecionamos
Tipo Cuenta y marcamos la opción de Administrador. Reiniciamos la máquina y ya tenemos nuestro cliente Windows 10
validado en el dominio.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/030.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio VI.</figcaption>
</figure>

A partir de este momento, ya podemos iniciar sesión con cualquier usuario del dominio. En nuestro caso solo tenemos el
usuario Administrador, podemos probar a iniciar sesión en la máquina con la cuenta del Administrador del dominio.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/031.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio VII.</figcaption>
</figure>

También podemos ver en nuestro servidor, desde el panel del Administrador de Servidor nuestra máquina. Para ello, desde la
máquina Windows Server 2019, accedemos al **Administrador de Servidor --> Herramientas --> Usuarios y Equipos de Active
Directory**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/032.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio VIII.</figcaption>
</figure>

Seleccionamos nuestro dominio ASO2122.LOCAL y luego Computers. Aparecerá nuestra máquina cliente PC01, si la
seleccionamos, con el botón de la derecha del ratón --> propiedades. Aquí podemos ver alguna información relativa a la
máquina conectada.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/033.png" width="900"/>
  <figcaption>Unir cliente windows 10 a dominio IX.</figcaption>
</figure>

## Errores en la unión

En caso de que haya habido algún error en la unión del equipo cliente al dominio se deben comprobar algunos
aspectos:

- La configuración de la interfaz de red está en modo 'Adaptador puente', no en 'NAT'.
- El equipo cliente y el equipo servidor se hallan en la misma red.
- El nombre del dominio puede resolverse desde el equipo cliente (ping ASO2122.LOCAL )
- La dirección del servidor **DNS** está correctamente configurada en el equipo cliente.

## Ejercicios

En esta actividad vamos a realizar la configuración de un dominio y la validación de una máquina Windows 10 en el
mismo.

1. **Creación de un dominio**: 

- En este apartado habrá que instalar y configurar un dominio. El dominio que hay que instalar y configurar será **ASO2122.LOCAL**. Para ello habrá que entregar un único archivo PDF con la captura de pantalla de nuestro **Panel de Administrador del Servidor**, donde aparezca claramente el nombre de máquina y también el nombre de dominio.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/034.png" width="900"/>
  <figcaption>Ejemplo Práctica 05_AD Ejercicio1.</figcaption>
</figure>

2. **Validar una máquina Windows 10 en el dominio**:

- Una vez instalado y configurado el domino, habrá que validar nuestra máquina Windows 10 cliente en el dominio.
Una vez unida al dominio, habrá que añadir al documento a entregar, una captura de pantalla donde se aprecie
en el servidor que el equipo está dado correctamente de alta (**Inicio → Herramientas Administrativas → Usuarios
y Equipos de Active Directory → ASO2122.LOCAL → Computer/Equipos**). Añade también alguna captura de
pantalla de las propiedades del equipo donde se identifique el sistema operativo de los equipos que has unido al
dominio.

<figure>
  <img src="./imagenes/02/PracticasAD/PR04/035.png" width="900"/>
  <figcaption>Ejemplo Práctica 05_AD Ejercicio2.</figcaption>
</figure>

