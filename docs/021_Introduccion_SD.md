# Administración de servicios de directorio

??? abstract "Duración y criterios de evaluación"

    **Duración estimada: 3 sesiones (2h por sesión)**

    <hr />

    Resultado de aprendizaje y Criterios de evaluación:

    1. Administra el servicio de directorio interpretando especificaciones e integrándolo en una red.
        1. Se han identificado la función, los elementos y las estructuras lógicas del servicio de directorio.
        2. Se ha determinado y creado el esquema del servicio de directorio.
        3. Se ha realizado la instalación del servicio de directorio en el servidor.
        4. Se ha realizado la configuración y personalización del servicio de directorio.
        5. Se ha integrado el servicio de directorio con otros servicios.
        6. Se han aplicado filtros de búsqueda en el servicio de directorio.
        7. Se ha utilizado el servicio de directorio como mecanismo de acreditación centralizada de los usuarios en una red.
        8. Se ha realizado la configuración del cliente para su integración en el servicio de directorio.
        9. Se han utilizado herramientas gráficas y comandos para la administración del servicio de directorio.
        10. Se ha documentado la estructura e implantación del servicio de directorio.

## Introducción

La organización de una red de trabajo empresarial supone un reto organizativo que el administrador del sistema debe afrontar con garantias de éxito. 

* Para ello dispone de herramientas organizativas como los servicios de directorio, tanto **SAMBA** como **Active Directory**, ambas basadas en el protocolo **LDAP**, las cuales ofrecen una amplia gama de herramientas que facilitan la organización de recursos de una red.

!!! note
    Si no se concibe un ordenador sin sistema operativo que lo administre, tampoco debe existir una red de cierta entidad sin sistema operativo de red que la gestione.

* En definitiva, **un sistema operativo de red (SOR en lo sucesivo)**, está diseñado para administrar redes y todos los elementos que la componen. Sus tareas más importantes son:
    1. La gestión centralizada de los recursos.
    2. Ofrecer servicios a los clientes.
    3. Proporcionar acceso seguro a esos recursos y monitorizar todo lo que pasa en la red.

## Arquitectura de Redes

Los sistemas operativos en red pueden catalogarse en distribuidos y centralizados. Los primeros se componen de un software que controla todos los equipos informáticos de foma distribuido en modo *"cluster"*. 

Un ejemplo es el SO llamado **Amoeba** de **A.S.Tanenbaum**. Se utilizan en despliegues específicos que no competen en este módulo. por lo tanto a continuación se desarrollaran los centralizados.

### Estructura Red plana

Antes del desarrollo de las herramientas de los servicios de red, se comenzó a desarrollar la **Estructura trabajo en grupo**, la cual trataba la red en modo plano.

* **Una red plana, entre iguales o punto a punto**, es aquella en la ninguno de los equipos realiza tareas de administración de la red, sino tan sólo de sí mismo. No existe un equipo que haga las veces de administrador, por lo que en realidad, todos los clientes se convierten en administradores de los recursos que ofrecen a la red.

!!! Example
    Si un cliente decide compartir un recuso, éste estará disponible para todos los miembros de la red sin distinción. Si es necesario limitar el acceso a un subconjunto de usuarios, habrá que establecer una contraseña y hacérsela llegar a través de un medio seguro.

<figure>
  <img src="imagenes/02/grupotrabajo.png" width="400"/>
  <figcaption>Introducción de un equipo a un grupo de trabajo</figcaption>
</figure>

!!! Warning
    Si cada uno de los usuarios empieza a compartir recursos sin control, su localización puede ser una tarea complicada, ya que los usuarios de la red deben conocer en todo momento su distribución y configuración. La localización puede suponer un grave problema.

* **Microsoft** introdujo en sus sistemas operativos la posibilidad de crear **grupos** de trabajo que dividían la red en subconjuntos. De este modo, si se sabe a qué grupo pertenece el equipo que comparte un recurso será más sencillo su localización. Estas divisiones se realizaban por funciones, por ubicación física o por cualquier otro criterio de la empresa. 

!!! Warning 
    Resultaba más sencillo localizar recursos, pero **no solucionaban el problema de acceso**. Este sistema de organización de red presenta numerosos problemas de seguridad.

### Estructura cliente-servidor

Se trata de un modelo de aplicación centralizada en el que las tareas se dividen entre los proveedores de recursos o servicios. A estas máquinas se las conoce como **servidores** y a los equipos que demandan estos servicios se les conoce como **clientes**.

<figure>
  <img src="imagenes/02/ClienteServidor.png" width="400"/>
  <figcaption>Esquema de red cliente servidor</figcaption>
</figure>

En este tipo de redes:

* Los clientes están conectados a un servidor en el que se centralizan los recursos y servicios con que se cuenta la red.
* El servidor es el encargado de ponerlos a disposición de los clientes cada vez que estos son solicitados.
* Por lo tanto, todas las gestiones que se realizan se concentran en el servidor, lo que **facilita la localización de los recurso de una forma sencilla.**

!!! Warning
    * Sin embargo, agregar un **segundo servidor** puede complicar las cosas de manera significativa. El problema surge porque cada servidor individual mantiene su propia lista de usuarios y recursos. El servidor **A** ofrece alojamiento a aplicaciones, el servidor **B** al correo electrónico y las aplicaciones de contabilidad y la base de datos se encuentran en el servidor **C**.

<figure>
  <img src="imagenes/02/CS_variosServers.png" width="400"/>
  <figcaption>Red cliente-servidor con varios servidores.</figcaption>
</figure>

* Los usuarios que requieren acceso a la base de datos y utilizar las aplicaciones, necesitan una cuenta en dos se los tres servidores. Cada una de esas cuentas de usuarios debe ser creada y mantenida de manera separada. **Es fácil para los servidores perder sincronía cuando deben ser actualizados manualmente.**

!!! note
    Estas y otras cuestiones serán resueltas con el siguiente modo de organización de red.

## Servicios de directorio

**los servicios de directorios**, son un conjunto de aplicaciones que guardan y administran toda la información sobre los elementos de una red.

 * Cada **recurso** de la red se considera como un **objeto**, donde su **información se almacena como atributos**.
 * Para la gestión de esta información, el **servicio de directorio** establece una serie de **permisos de acceso y condiciones de seguridad** que la salvaguardan esta información.
 * Ofrecen una **infraestructura** para localizar, manejar, administrar, y organizar los componentes y recursos comunes de una red.

!!! note
    Los recursos pueden ser: volúmenes, carpetas, archivos, impresoras, usuarios, grupos, dispositivos, números de teléfono y un largo etcétera.

Los servicios de directorios contienen diferentes objetos relacionados entre sí, y que será conveniente familiarizarse con ellos:

1. **Directorio**, es un repositorio único para la información relativa a los objetos de una organización.
2. **Dominio**, es una colección de objetos dentro de un directorio.
3. **Objeto**, cualquiera de los elementos que forman parte del directorio. Pueden ser recursos, usuarios, equipos, relaciones de confianza, servidores, unidades organizativas entre otros. En general todos estos objetos se clasifican en tres categorías:
    1. **usuarios**, identificados a través del binomio *nombre/contraseña* y que pueden organizarse en grupos.
    2. **recursos**, elementos que los usuarios pueden usar para el correcto desarrollo de su actividad.
    3. **servicios**, que son funciones a los que el usuario tienen acceso como el *correo electrónico*, *copias de seguridad en la nube*, *conexión Internet entre otros*.
4. **Unidad organizativa**, es un contendedor de objetos que permite organizarlos en subconjuntos de forma jerárquica. Facilita la organización de los dominios.
5. **Grupo**, conjunto de objetos usuario. Al igual que las unidades organizativas, facilitan la organización y administración de los objetos, los grupos lo hacen con objetos tipo usuario.
6. **Controlador de dominio**, equipo que contiene la base de datos de objetos para un determinado dominio, incluida la información de seguridad y la responsabilidad de la autenticación de objetos de su ámbito de gobierno.
7. **Catálogo global**, base de datos con la información de todos los objetos que contiene el directorio. Esta información habitualmente se divide
entre los controladores de dominio siendo éstos responsables del mantenimiento de su parte de esta información.
8. **Maestro de operaciones**, existen un conjunto de operaciones que deben estar centralizadas para mantener la consistencia del sistema. El equipo encargado de esas operaciones obtiene este rol específico. Según el caso puede ser un equipo independiente que controle estas operaciones o asignar estas tareas a un equipo existente.
9. **Árbol**, un conjunto de dominios dependientes de una raíz común y que tienen una estructura jerárquica. Se caracterizan por tener un espacio de nombres común (un servidor DNS propio). El objetivo de esta fragmentación de la estructura es replicar sólo la información necesaria y disminuir el tráfico de red.
10. **Bosque**, se trata del mayor contenedor lógico dentro del directorio, conteniendo a todos los árboles dentro de su ámbito. Cada uno de
estos contenedores posee su propio espacio de nombres y una forma de relacionarse con el resto de bosques.
11. **Esquema**, se refiere a la estructura de los objetos que forman la base de datos. Usa la técnica clase/objeto para definir la estructura de un
objeto. Si se crean dos objetos usuarios, ambos tendrán los mismos atributos (estructura), pero diferentes valores de atributos.
12. **Sitio**, conjunto de *objetos equipo* que se encuentran relacionados de una forma lógica, geográfica o técnica particular y que necesitan un subconjunto de normas diferentes al resto.
13. **Relaciones de confianza**, son un método de comunicación segura entre dominios, árboles y bosques, que permiten a los usuarios autentificarse en
otra parte del directorio a la que no pertenece.

!!! note
    Para nombrar a todos estos objetos que componen la red, los servicios de directorio definen un espacio de nombres unívoco, e identifican a cada uno de estos objetos con un nombre único en todo el directorio.

* La tecnología utilizada para crear este espacio de nombres es la **DNS (Domain Name Server)**, y su funcionamiento es similar al de Internet. 
* Cada uno de los objetos del directorio posee un **DN (Distinguished Name)** que lo identifica de forma unívoca del resto de elementos del directorio.

### Ventajas

* los servicios de directorio, ofrecen una capa de **abstracción** para facilitar el acceso a los objetos. Se debe indicar una única ubicación en donde se dirigirán las peticiones de información. No importa si la información solicitada se encuentra o no en ese emplazamiento.
* **Autonomía**, Es posible que toda la información no esté contenida en un único equipo por cuestiones de rendimiento, escalabilidad o idiosincrasia del sistemas informático. En estos casos crear un subconjunto de la información contenida en los servicios de directorio parece una buena opción y dotarlos de las herramientas necesarias para su gestión autónoma.
* Si se permite el símil, **es el Google del sistema informático** que se gestiona.

### Servicios de directorio destacables

1. **Active Directory**, ideado por Microsoft e implementado desde su versión *Microsoft Windows 2000* que usaba tecnología propietaria, para más tarde adaptar el protocolo LDAP a su servicio.
2. **OpenLDAP**, recibe el nombre del protocolo homónimo que gestiona el intercambio de información. Es uno de los más usados en sistemas basados en *GNU/Linux*.
3. **SambaLDAP**, un servicio compuesto por un conjunto de protocolos (*OpenLDAP*, *Kerberos* y *Samba*) que permite la fácil coexistencia de entre sistemas operativos diferentes.
4. Otros: **Novell Directory Services**, **Red Hat Directory Server** o **Apache Directory Server**.

!!! note
    **En resumen**, un servicio de directorio ofrece toda la información de los recursos de la red a través de una única ubicación. Para ello convierte cada recurso en un objeto y almacena su información en una base de datos jerárquica y, opcionalmente, distribuida. La gestión de estos datos se realiza a través de un protocolo determinado por la versión del servicio de directorio escogido.



