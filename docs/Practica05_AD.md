# Práctica05_AD

# Instalación de Active DirectoryInstalación de Active Directory II

Objetivos de esta práctica:

- Eliminar Clientes de un dominio.
- Degradar Controlador de un dominio.
- Configurar un servicio de DHCP
- Acceso Remoto y NAT

# Eliminar clientes de un dominio

Habrá veces que una determinada máquina queramos sacarla de un dominio por algún motivo, para **quitar un cliente Windows
10** de un domino debemos realizar los siguientes pasos:

Accedemos a Sistema, a través del botón de **inicio de Windows** y con el ratón botón de la **derecha** --> **Sistema**.

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/001.png" width="900"/>
  <figcaption>Eliminar cliente windows 10 de dominio I.</figcaption>
</figure>

Dentro de **Sistema** --> Seleccionamos **Administrar o desconectar del trabajo o de la escuela**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/002.png" width="900"/>
  <figcaption>Eliminar cliente windows 10 de dominio II.</figcaption>
</figure>

Seleccionamos el dominio al que está conectado, en nuestro caso a **ASO2122.LOCAL** y hacemos clic en Desconectar

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/003.png" width="900"/>
  <figcaption>Eliminar cliente windows 10 de dominio III.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/004.png" width="900"/>
  <figcaption>Eliminar cliente windows 10 de dominio IV.</figcaption>
</figure>

Confirmamos la desconexión del dominio local

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/005.png" width="900"/>
  <figcaption>Eliminar cliente windows 10 de dominio V.</figcaption>
</figure>

# Degradar un controlador de dominio

En este apartado lo que vamos a ver es cómo podemos **degradar un servidor que esté actuando como controlador de dominio**,
es decir, que tenga instalado un Active Directory. Para ello iremos al Panel de Administrador del Servidor y seleccionaremos
Agregar roles y características:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/006.png" width="900"/>
  <figcaption>Degradar un controlador de dominio I.</figcaption>
</figure>

Nos aparece el asistente para quitar roles y características, seleccionamos siguiente:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/007.png" width="900"/>
  <figcaption>Degradar un controlador de dominio II.</figcaption>
</figure>

Iniciado el asistente seleccionamos el servidor en donde vamos a quitar algún rol. En nuestro caso, eliminaremos el rol
Servicios de dominio de Active Directory:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/008.png" width="900"/>
  <figcaption>Degradar un controlador de dominio III.</figcaption>
</figure>

Eliminamos las características de los servicios de Active Directory:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/009.png" width="900"/>
  <figcaption>Degradar un controlador de dominio IV.</figcaption>
</figure>

Para poder eliminar los servicios de Active Directory, es necesario disminuir el nivel del controlador de dominio:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/010.png" width="900"/>
  <figcaption>Degradar un controlador de dominio V.</figcaption>
</figure>

Forzamos la eliminación del controlador de dominio:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/011.png" width="900"/>
  <figcaption>Degradar un controlador de dominio VI.</figcaption>
</figure>
Introducimos la contraseña del administrador del dominio, en nuestro caso "cefire2017.":

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/012.png" width="900"/>
  <figcaption>Degradar un controlador de dominio VII.</figcaption>
</figure>

Y por último Disminuimos el nivel:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/013.png" width="900"/>
  <figcaption>Degradar un controlador de dominio VIII.</figcaption>
</figure>

## Servicio de DHCP

Indiscutiblemente uno de los principales roles que nos ofrece Windows Server y que son vitales en el óptimo funcionamiento
de nuestra infraestructura de red es el rol de DHCP. DHCP (Dynamic Host Configuration Protocol – Protocolo de Configuración
Dinámica de Equipos) nos permite definir rangos de direcciones IP para los equipos cliente del dominio y de este modo
administrar de forma centralizada todas las direcciones IP del dominio.

Cuando en nuestra organización tenemos disponible un **servidor DHCP** tenemos la plena confianza que todos los equipos y
dispositivos de nuestra red tendrán de forma automática su dirección IP y no es necesario ir a cada máquina a definir la
dirección de forma manual.

Con el rol DHCP proveemos los **siguientes parámetros**:

- Máscara de subred
- Dirección IP
- Puerta de enlace
- Servidores DNS, entre otros.

Para iniciar el proceso de instalación seleccionaremos la opción Agregar roles y características desde el Administrador del
servidor. La primera ventana la podemos omitir ya que es de bienvenida. Pulsamos Siguiente y en la ventana desplegada
seleccionamos la opción Instalación basada en características y roles, pulsamos Siguiente y seleccionamos el servidor donde
instalaremos el rol DHCP.

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/014.png" width="900"/>
  <figcaption>Instalación servicio de DHCP I.</figcaption>
</figure>

Una vez seleccionado el equipo buscaremos el rol Servidor de DHCP, al activar la casilla veremos la siguiente ventana donde
se indica si deseamos agregar las características de DHCP. 

Seleccionamos la opción **Agregar característica** y veremos el rol seleccionado. Llegaremos al resumen y haremos clic en **Instalar**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/015.png" width="900"/>
  <figcaption>Instalación servicio de DHCP II.</figcaption>
</figure>

Una vez instalado, hay que realizar la configuración del rol. Para ello hay que hacer clic en Completar configuración DHCP:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/016.png" width="900"/>
  <figcaption>Instalación servicio de DHCP III.</figcaption>
</figure>

## Configuración servicio de DHCP

Como vemos debemos completar la configuración del DHCP para que todo el rol quede correctamente preparado para la
organización, para ello pulsamos en la opción “Completar configuración de DHCP”. Al pulsar esta opción veremos el siguiente
asistente.

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/017.png" width="900"/>
  <figcaption>Configuración servicio de DHCP I.</figcaption>
</figure>

Pulsamos Siguiente y debemos configurar las credenciales del usuario que han de ser usadas para la configuración del
servidor DHCP:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/018.png" width="900"/>
  <figcaption>Configuración servicio de DHCP II.</figcaption>
</figure>

Una vez definidas pulsamos Confirmar y veremos el resumen del proceso. Pulsamos Cerrar para salir del asistente. Con esto
hemos instalado el rol de DHCP en Windows Server 2019:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/019.png" width="900"/>
  <figcaption>Configuración servicio de DHCP III.</figcaption>
</figure>

Ahora debemos configurar el DHCP por lo que con este paso realizado vamos a ir a la siguiente ruta para establecer la
configuración deseada para el DHCP. Para ello vamos al Panel del **Administrador** --> **Herramientas y DHCP**:

Como podemos observar contamos con dos opciones de configuración. Allí podemos configurar todos los parámetros del
direccionamiento IPv4, hasta ahora el más usado y el de IPv6.

## Creación de un nuevo ámbito

Un ámbito es un rango de direcciones que serán asignadas de forma automática a los equipos de nuestro dominio. Por tanto
seleccionaremos IPv4 y con el botón de la derecha del ratón accederemos a la opción Ámbito Nuevo...

Iniciará el asistente para creación de un ámbito nuevo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/020.png" width="900"/>
  <figcaption>Configuración servicio de DHCP IV.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/021.png" width="900"/>
  <figcaption>Configuración servicio de DHCP V.</figcaption>
</figure>

Pulsamos Siguiente y a continuación debemos establecer un nombre a este nuevo ámbito. En nuestro caso, ámbito
ASO2122.LOCAL:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/022.png" width="900"/>
  <figcaption>Configuración servicio de DHCP VI.</figcaption>
</figure>

En la siguiente ventana debemos establecer el rango de direcciones IP a asignar de forma automática, debemos indicar una
dirección IP inicial y una dirección IP final. Es muy importante que tengamos claridad sobre la cantidad de usuarios estarán
activos para no asignar direcciones de más ni quedarnos cortos con las mismas. La longitud la dejamos por defecto en 24 y la
máscara de subred dejamos la que está, clase C. En nuestro caso, introduciremos un rango desde la 192.168.100.20 -
192.168.100.250.

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/023.png" width="900"/>
  <figcaption>Configuración servicio de DHCP VII.</figcaption>
</figure>

Al pulsar Siguiente podemos establecer una o más direcciones IP que no serán distribuidas a los usuarios de manera normal,
esto es efectivo en los siguientes casos:

- Tareas de administración.
- Asignar IPs fijas a dispositivos como impresoras.
- Establecer direcciones IP a un grupo determinado de usuarios sin que ésta sea renovada.

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/024.png" width="900"/>
  <figcaption>Configuración servicio de DHCP VIII.</figcaption>
</figure>

Una vez establecido o no estas exclusiones pulsamos Siguiente y veremos que podemos configurar cuánto tiempo durará la
concesión de la dirección IP, esto hace que la dirección IP en el equipo cliente sea renovada de manera automática, podemos
definir este valor en días, horas o minutos. Lo más recomendable es que para los equipos de nuestra organización se
establezca esta concesión en días ya que al renovarse la dirección IP el usuario puede verse afectado en su navegación y uso
de la red.

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/025.png" width="900"/>
  <figcaption>Configuración servicio de DHCP IX.</figcaption>
</figure>

Pulsamos Siguiente y debemos definir si establecemos esta configuración de manera inmediata o más adelante. En nuestro
caso marcaremos la opción de configurar las opciones ahora:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/026.png" width="900"/>
  <figcaption>Configuración servicio de DHCP X.</figcaption>
</figure>

Al pulsar que las configure de manera inmediata el asistente nos solicitará que ingresemos la dirección IP del enrutador o
puerta de enlace. En nuestro caso añadiremos la ip 192.168.100.1 y le daremos a Agregar:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/027.png" width="900"/>
  <figcaption>Configuración servicio de DHCP XI.</figcaption>
</figure>

Pulsamos nuevamente Siguiente y podemos ver el nombre del dominio o especificar cuáles equipos serán usados para la
resolución de los nombres DNS. En nuestro caso, la IP de la red interna, 192.168.100.1 y como alternativo podemos poder
cualquier DNS, por ejemplo el de google 8.8.8.8:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/028.png" width="900"/>
  <figcaption>Configuración servicio de DHCP XII.</figcaption>
</figure>

Al pulsar Siguiente veremos la configuración de los servidores WINS los cuales permiten que los nombres de equipo NetBIOS
sean convertidos en direcciones IP. Nuestro caso ninguno.

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/029.png" width="900"/>
  <figcaption>Configuración servicio de DHCP XIII.</figcaption>
</figure>

Finalmente activamos nuestro ámbito.

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/030.png" width="900"/>
  <figcaption>Configuración servicio de DHCP XIV.</figcaption>
</figure>

### Configuración de IP por DHCP en máquina cliente

Para comprobar que nuestro DHCP funciona, basta con cambiar la configuración en la máquina Windows 10 cliente y
comprobar que nos asigna la primera dirección disponible de nuestro ámbito, típicamente la 192.168.100.20, en nuestro caso:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/031.png" width="900"/>
  <figcaption>Configuración IP dinámica en cliente.</figcaption>
</figure>

Y comprobamos la IP:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/032.png" width="900"/>
  <figcaption>Comprobación de asignación de IP dinámica.</figcaption>
</figure>

### Concesión de direcciones en DHCP

Desde el servidor, en la opción de DHCP, también podemos comprobar las concesiones de direcciones IPs que se han
realizado:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/033.png" width="900"/>
  <figcaption>Comprobación de las concesiones de direcciones IPs.</figcaption>
</figure>

## Acceso Remoto. NAT.

### Servicios de enrutamiento

En este punto vamos a realizar la configuración de NAT en nuestro servidor. NAT (Network Address Translation) nos permite
que nuestra interfaz externa, pueda traducir las direcciones de la red interna. De esta forma, en las máquinas clientes de la red
interna de nuestro dominio, puede tener acceso a internet. Este servicio en combinación con el anterior se suele utilizar con
mucha frecuencia. 

Para ello lo primero de debemos hacer es realizar **la instalación del rol Acceso Remoto**, desde: **el Panel del Administrador del Servidor en agregar roles y características y seleccionar Acceso Remoto**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/034.png" width="900"/>
  <figcaption>Configuración de NAT I.</figcaption>
</figure>

Marcamos y agregamos las características, NAT va acompañado también del servicio de Enrutamiento y Direct Access. En
nuestro caso, de momento solo realizaremos la configuración de NAT:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/035.png" width="900"/>
  <figcaption>Configuración de NAT II.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/036.png" width="900"/>
  <figcaption>Configuración de NAT III.</figcaption>
</figure>

Una vez instalado vamos a realizar la configuración del NAT. Para ello, dentro del Panel del Administrador del Servidor,
accedemos a Herramientas y después en Enrutamiento y Acceso Remoto:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/037.png" width="900"/>
  <figcaption>Configuración de NAT IV.</figcaption>
</figure>

Dentro de enrutamiento y acceso remoto, seleccionamos nuestro servidor y con el botón de la derecha del ratón, marcamos la
opción Configurar y habilitar el Enrutamiento y acceso remoto:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/038.png" width="900"/>
  <figcaption>Configuración de NAT V.</figcaption>
</figure>

Nos iniciará un asistente y marcaremos la opción Traducción de direcciones de red (NAT):

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/039.png" width="900"/>
  <figcaption>Configuración de NAT VI.</figcaption>
</figure>

Marcaremos nuestra interfaz externa (WAN) como interfaz de conexión a internet:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/040.png" width="900"/>
  <figcaption>Configuración de NAT VII.</figcaption>
</figure>

## Acceso a internet cliente Windows 10

Ahora desde nuestra máquina cliente Windows 10, ya tenemos nuestro acceso a internet:

<figure>
  <img src="./imagenes/02/PracticasAD/PR05/041.png" width="900"/>
  <figcaption>Configuración de NAT VIII.</figcaption>
</figure>

# Actividades

En esta actividad vamos a realizar la configuración de un servicio DHCP y el acceso remoto. NAT.

1. **Creación de DHCP**: 

- En este apartado habrá que instalar y configurar el servicio DHCP. Habrá que entregar un único archivo PDF con la captura de pantalla de nuestra **Panel de Administrador del Servidor, con las concesiones DHCP**, donde aparezca claramente el nombre de máquina; además otra captura con **la configuración de red del Windows 10**.

2. **Validar una máquina Windows 10 en el dominio**:

- Configuración del NAT. se mostrará **Panel de Administrador del Servidor, con la configuración NAT**, donde aparezca claramente el nombre de máquina; además otra captura con demostrando que el cliente tiene conexión a Internet.
