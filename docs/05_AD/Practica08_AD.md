# Permisos, directivas de grupo y perfiles I

Objetivos de esta práctica:

- Creación de recursos compartidos.
- Configuración y administración de permisos de carpetas compartidas.
- Configuración y administración de permisos NTFS
- Gestión del dominio mediante directivas de grupo.

## Permisos

Los sistemas operativos de la familia Windows poseen dos niveles de permisos para los recursos compartidos:

- **Permisos para carpetas compartidas**: se aplican cada vez que un usuario quiere acceder a un archivo o carpeta de la red.
- **Permisos para archivos y carpetas (NTFS)**: se aplican sobre dispositivos con formato NTFS para definir en mayor detalle las acciones permitidas.

De lo anterior se extrae que cuando se accede en modo local a los archivos o carpetas sólo intervienen los permisos
asociados al sistema de ficheros, en este caso NTFS, sin embargo si se accede a través de la red se aplican los dos niveles
de permisos: **en primer lugar se aplican los permisos de carpetas compartidas y posteriormente los permisos NTFS**.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/001.png" width="750"/>
  <figcaption>Permisos NTFS y compartidos.</figcaption>
</figure>

### Permisos de recursos compartidos

Para acceder a la gestión de recursos compartidos, lo podemos hacer a través de la opción servicios de archivo y
almacenamiento, desde el Panel del Administrador del Servidor.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/002.png" width="750"/>
  <figcaption>Recursos compartidos I.</figcaption>
</figure>

Después accedemos a la opción recursos compartidos:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/003.png" width="750"/>
  <figcaption>Recursos compartidos II.</figcaption>
</figure>

En la parte central de la consola de administración del almacenamiento aparecen los recursos compartidos en el servidor. Para
visualizar los permisos de cada recurso compartido, basta con hacer clic con el botón secundario del ratón sobre el recurso
cuyos permisos se quieren consultar y se selecciona ‘Propiedades’:


<figure>
  <img src="./imagenes/02/PracticasAD/PR08/004.png" width="750"/>
  <figcaption>Propiedades Recursos Compartidos.</figcaption>
</figure>

Veremos como aparece un cuadro de dialogo donde podemos ver en la parte de la izquierda la opción permisos. Y bajo
Personalizar Permisos:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/005.png" width="750"/>
  <figcaption>Permisos recursos compartidos.</figcaption>
</figure>

Nos aparece después el cuadro de permisos completo del recurso seleccionado:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/006.png" width="750"/>
  <figcaption>Recursos compartidos V.</figcaption>
</figure>

Si accedemos a la pestaña compartir, podremos ver los permisos del recurso compartido. En este caso, el recurso compartido
netlogon tiene los permisos:


<figure>
  <img src="./imagenes/02/PracticasAD/PR08/007.png" width="750"/>
  <figcaption>Recursos compartidos VI.</figcaption>
</figure>

Estos pueden ser de tres tipos:

**Control total** : no solo permite cambiar y leer, sino modificar los permisos sobre el recurso compartido.
**Cambiar** : se permite crear carpetas y archivos además de modificar y borrar los archivos y directorios existentes.
**Lectura** : únicamente permite la lectura de archivos y la ejecución de archivos ejecutables que se hallen dentro del recurso compartido.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/008.png" width="750"/>
  <figcaption>Permisos de NETLOGON.</figcaption>
</figure>

Como se puede comprobar en la siguiente figura, existen dos tipos de directivas : ‘**Permitir**’ y ‘**Denegar**’. 

!!! Warning
    Es importante destacar que la opción ‘**Denegar**’ tiene prioridad sobre otros permisos asignados sobre el recurso compartido.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/009.png" width="750"/>
  <figcaption>Tipos de directivas.</figcaption>
</figure>

### Establecer permisos en recursos compartidos

Establecer permisos de recursos compartidos se puede hacer de varias maneras. Probablemente la más sencilla sea
seleccionar el recurso sobre el cual se desean configurar los permisos, y haciendo clic con el botón secundario ‘**Compartir
con...**’ y usuarios específicos.. Por ejemplo, vamos a crear una carpeta en C: llamada Empresa_users y la vamos a
compartir:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/010.png" width="750"/>
  <figcaption>Compartir recursos.</figcaption>
</figure>

Y agregamos el grupo Empresa con lectura y escritura:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/011.png" width="750"/>
  <figcaption>Agregar permisos.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/012.png" width="750"/>
  <figcaption>Agregar Permisos recurso compartido I.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/013.png" width="750"/>
  <figcaption>Agregar Permisos recurso compartido II.</figcaption>
</figure>

Y por último Compartir.

En lugar de hacer uso de este asistente, vamos a compartir mediante el uso compartido avanzado, que nos da más opciones
para asignar los permisos. Para ello, seleccionaremos la carpeta y con el botón de la derecha del ratón propiedades y pestaña
compartir:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/013.png" width="750"/>
  <figcaption>Uso compartido avanzado I.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/014.png" width="550"/>
  <figcaption>Uso compartido avanzado II.</figcaption>
</figure>

En la medida de lo posible, habrá que asignar permisos a grupos y eliminar grupos que no tengan ninguna relación con la
carpeta que queremos compartir. **Evitar el uso de grupo Todos** para eso habrá que crear los grupos correspondientes.

## Permisos NTFS

Como se ha comentado anteriormente, **los permisos NTFS** complementan y amplían los permisos de recursos compartidos,
siendo efectivo el más restrictivo.

Todos los archivos y carpetas de un volumen NTFS tienen asociada una **ACL o lista de control** de acceso que fija el nivel de
acceso de un usuario o grupo que pretenda acceder al recurso. Además, los permisos NTFS pueden ser aplicados a nivel de
archivo, a diferencia de los permisos de recursos compartidos, los cuales únicamente pueden aplicarse a nivel de carpeta.

Por otra parte, surge un nuevo concepto al aplicar los permisos NTFS que los hace más complejos aunque también más
potentes: **la herencia**, la cual determinará los permisos que se reciben sobre un determinado recurso provenientes de un nivel
superior, aunque esto lo veremos detalladamente más adelante.

### Tipos de permisos NTFS

Tal y como se muestra en la figura (para abrir ese cuadro de diálogo hacer clic con el botón secundario sobre el recurso
compartido y hacer clic en la pestaña 'Seguridad'), los permisos (predeterminados) que pueden aplicarse sobre archivos y
carpetas son:

- Control total.
- Cambiar.
- Leer y ejecutar.
- Mostrar el contenido de la carpeta.
- Leer.
- Escribir.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/015.png" width="550"/>
  <figcaption>Permisos estándar.</figcaption>
</figure>

No obstante, estos permisos en realidad representan varios aspectos mucho más concretos. Para tratar de clarificar esta
cuestión, la tabla 1 resume qué tareas pueden realizarse con cada tipo de permiso.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/016.png" width="750"/>
  <figcaption>Permisos para carpetas y archivos.</figcaption>
</figure>

Para poder acceder a estos permisos especiales, lo haremos a través de las propiedades, pestaña de Seguridad y opciones
avanzadas:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/017.png" width="550"/>
  <figcaption>Acceso a permisos especiales I.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/018.png" width="750"/>
  <figcaption>Acceso a permisos especiales II.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/019.png" width="750"/>
  <figcaption>Acceso a permisos especiales III.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/020.png" width="750"/>
  <figcaption>Acceso a permisos especiales.</figcaption>
</figure>

!!! Warning
    Es **importante** entender que los permisos predeterminados estándar, en realidad corresponden a unas combinaciones de permisos específicos, siendo estos últimos con los que trabajaremos más adelante cuando gestionemos las listas de control de acceso por línea de comandos.

### Asignación de permisos NTFS

Al definir un permiso NTFS este puede ser un permiso o una denegación:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/021.png" width="550"/>
  <figcaption>Permisos NTFS I.</figcaption>
</figure>

!!! Warning
    - **Los permisos NTFS son acumulativos**: se evalúan los permisos otorgados al usuario y a los grupos a los que pertenece el usuario. En el caso de que haya una incompatibilidad entre los permisos asignados a un usuario y los asignados a un grupo del cual sea miembro, prevalecerá la opción más restrictiva: **Denegar (si está definido explícitamente)**.

Para asignar permisos NTFS a un recurso compartido bastará con hacer clic con el botón secundario sobre el recurso y
acceder a la pestaña 'Seguridad'. A continuación pulsaremos el botón 'Opciones Avanzadas', como se muestra a continuación:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/022.png" width="550"/>
  <figcaption>Permisos NTFS II.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/023.png" width="750"/>
  <figcaption>Permisos NTFS III.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/024.png" width="750"/>
  <figcaption>Permisos NTFS IV.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/025.png" width="750"/>
  <figcaption>Permisos NTFS V.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/026.png" width="750"/>
  <figcaption>Permisos NTFS VI.</figcaption>
</figure>

!!! Warning 
    Cuidado con el grupo Usuarios (del dominio) porque aparece por defecto en los permisos NTFS (con permisos de lectura), y puede provocar que se produzcan accesos diferentes a nuestra planificación. Como norma general, si queremos limitar el acceso a un recurso compartido, eliminaremos el grupo Usuarios de los permisos NTFS y explicitaremos únicamente aquellos grupos o usuarios que efectivamente queramos que tengan acceso al recurso.

### Permisos Implícitos y permisos Explícitos

Los permisos otorgados de manera implícita o explícita son una cuestión sencilla, en la que si no nos fijamos con atención,
podemos hacer que los accesos a los recursos no funcionen como teníamos previsto. Para evitar problemas tendremos en
cuenta que:

1. Un permiso definido de manera explícita siempre prevalecerá sobre un permiso definido de manera implícita.
2. Denegar un permiso siempre prevalece sobre otorgar ese permiso, siempre y cuando ambos estén definidos de la
misma manera (implícita o explícitamente).

¿Cómo se define un permiso de manera explícita? Si nos fijamos en la siguiente figura, el grupo Compras no tiene
(aparentemente) definidos permisos de escritura. Sin embargo esa aparente indefinición, en realidad indica que el permiso de
escritura está denegado implícitamente. Si un usuario del grupo Ventas intenta escribir en la carpeta, se producirá un mensaje
de error como muestra la siguiente figura:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/027.png" width="750"/>
  <figcaption>Permisos explícitos.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/028.png" width="550"/>
  <figcaption>Error al crear archivo en recurso compartido.</figcaption>
</figure>

Sin embargo, si le otorgamos el permiso explícito de escritura, veremos que efectivamente puede escribir en el recurso, ya
que la definición explícita del permiso para escribir prevalece sobre la denegación implícita del permiso escribir:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/029.png" width="750"/>
  <figcaption>Permisos de escritura.</figcaption>
</figure>


<figure>
  <img src="./imagenes/02/PracticasAD/PR08/030.png" width="750"/>
  <figcaption>Permisos de escritura.</figcaption>
</figure>

Si explicitamos la denegación del permiso de escritura para los miembros del grupo Compras, podremos comprobar que
efectivamente el usuario usucomp1 no puede escribir en la carpeta:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/031.png" width="750"/>
  <figcaption>Denegación explicita.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/032.png" width="750"/>
  <figcaption>Denegación explicita.</figcaption>
</figure>


### Herencia de permisos

!!! Note
    Al crear un archivo o carpeta en un volumen NTFS ese objeto hereda automáticamente los permisos de su carpeta contenedora, y a la inversa: cuando asignamos permisos a una carpeta contenedora, los permisos se propagan automáticamente hacia los archivos y subcarpetas contenidas en el recurso.

Sin embargo, pueden darse ocasiones en las que queramos eliminar esa herencia de permisos. Esto puede ejecutarse de tres
maneras diferentes:

- Eliminar la herencia a nivel de la carpeta de nivel superior, los objetos contenidos en ella dejan de heredar los permisos.
- Eliminar la herencia a nivel de subcarpeta o archivo contenido dentro del recurso principal.
- Permitir o denegar explícitamente un permiso de manera diferente a como está definido en el recurso contenedor.

!!! Note
    **¿Qué utilidad práctica piensas que puede tener la herencia de permisos?**
    Fundamentalmente son dos las utilidades principales. La primera radica en que el administrador no tiene que asignar manualmente los permisos a los archivos y subcarpetas que haya contenidas dentro del recurso principal, y que fácilmente pueden ser miles. Relacionado con este aspecto, también encontramos una segunda utilidad práctica que es el aumento de la seguridad al descartar posibles errores de asignación de permisos realizados manualmente.

### Eliminación de herencia del recurso de nivel superior

Para eliminar la herencia de los permisos establecidos en la carpeta de nivel superior, se debe acceder a la ficha 'Seguridad'
del cuadro de diálogo 'Permisos' y a continuación se hace clic en 'Opciones Avanzadas' :

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/033.png" width="750"/>
  <figcaption>Denegación explicita I.</figcaption>
</figure>

En este caso vemos que la carpeta **c:\pistonazo_users** hereda los permisos de la unidad **c:\**. 

Para eliminar la herencia, debemos hacer clic en Deshabilitar herencia y nos aparecerá un diálogo para dejar los permisos explícitos o bien para eliminar todos los permisos:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/034.png" width="550"/>
  <figcaption>Denegación explicita II.</figcaption>
</figure>

Tenemos dos opciones:

- **Convertir los permisos heredados en permisos explícitos**: mantiene los permisos de todos los archivos y subcarpetas, pero no están vinculados a los del nivel superior.
- **Quitar todos los permisos**: elimina todos los permisos heredados.

!!! tip
    Como norma general marcaremos la primera opción, convertir los permisos en permisos explícitos:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/035.png" width="750"/>
  <figcaption>Denegación explicita III.</figcaption>
</figure>

### Cambio de los permisos de un objeto hijo

Si observamos los permisos de un objeto que está heredando permisos, veremos que las casillas de verificación están
(completa o parcialmente) inaccesibles. En este caso la carpeta Compras que hereda los permisos de la carpeta **Administración**, hereda también los permisos del grupo administración:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/036.png" width="750"/>
  <figcaption>Herencia de permisos.</figcaption>
</figure>

En primer lugar podemos interrumpir la herencia, denegando explícitamente los permisos. Si el permiso heredado es de
concesión, la denegación está habilitada.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/037.png" width="750"/>
  <figcaption>Interrupción de herencia.</figcaption>
</figure>

## Directivas de Grupo (GPO)

**Las directivas de grupo **(**Group Policy**) son una serie de configuraciones creadas por el administrador que se aplican a objetos
del dominio. Por medio de estas directivas, el administrador controla los entornos de trabajo de los usuarios del dominio, los
equipos y el comportamiento de distintos objetos. Son en definitiva un conjunto de reglas que facilitan las labores de
administración de los usuarios y equipos.

Algunos de los aspectos más útiles que se pueden definir por parte del administrador mediante las directivas son:

- Los comandos de inicio de sesión.
- Características de las directivas de seguridad de las cuentas de usuario.
- Configuración de la apariencia de la sesión de usuario.
- Redirección del acceso a ciertas carpetas o archivos centralizados Distribución de software a los equipos clientes.
- Permisos otorgados a las cuentas de usuarios y grupos, etc.

### Acumulación de directivas de grupo

Al existir diferentes niveles de directivas de grupo, estas pueden entrar en conflicto, haciendo que aparezcan efectos no
deseados en la gestión del dominio. Al establecer directivas de grupo hay que tener en cuenta el orden de aplicación de las
mismas:

- Directiva de grupo local.
- Directiva de grupo de sitio.
- Directiva de grupo de dominio.
- Directiva de grupo de unidad organizativa.

De manera predeterminada cuando existe una contradicción entre las directivas, la que prevalece será la que está en un nivel
inferior de la lista anterior. Obviamente, en caso de no existir contradicciones, se aplican todas las directivas.

### Directivas de usuario o equipo

Si queremos saber las directivas que están aplicandose a un usuario o equipo, ejecutaremos **rsop.msc**:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/038.png" width="850"/>
  <figcaption>rsop.msc.</figcaption>
</figure>


### Edición de las directivas de grupo predeterminadas

Para acceder a las directivas de grupo predeterminadas, accedemos desde el Panel del Servidor --> Herramientas -->
Administración de directivas de grupo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/039.png" width="850"/>
  <figcaption>Administración directivas de grupo.</figcaption>
</figure>

Cuando se pone en marcha un dominio se crean dos directivas de grupo llamadas:

- Default Domain Controllers.
- Default Domain Policy.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/040.png" width="850"/>
  <figcaption>GPOs predefinidos.</figcaption>
</figure>

Estas dos directivas establecen la configuración básica de los objetos del dominio, y están vinculadas respectivamente a:

- La unidad organizativa Domain Controllers.
- El dominio.

Estos dos GPO se componen de un conjunto muy amplio de directivas, como se puede ver al abrir el editor de directivas:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/041.png" width="850"/>
  <figcaption>GPOs predeterminadas Default Domain Policy.</figcaption>
</figure>

Supongamos que queremos cambiar la configuración de la directiva que aplica sobre el permiso para apagar el equipo. En ese
caso la buscaríamos entre todo el conjunto de directivas dentro del **GPO Default Domain Policy** y haríamos doble clic sobre
ella :

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/042.png" width="850"/>
  <figcaption>GPO Apagar el sistema.</figcaption>
</figure>

Vemos que la directiva Apagar el Sistema no está habilitada. Si la habilitamos y únicamente otorgamos permiso a los
administradores del dominio, podremos comprobar que efectivamente un usuario del dominio que inicia sesión en un equipo
cliente no puede apagarlo, solamente podría un usuario con privilegios de administración.

Para evitar generar un tráfico de gestión excesivo en la red, las directivas de grupo no se actualizan inmediatamente tras su
modificación, sino que está establecido un intervalo de 5 minutos entre actualizaciones automáticas. No obstante, este
intervalo se puede modificar en las propias directivas de grupo. De todas maneras, no es necesario modificar este intervalo
para comprobar la correcta aplicación de las directivas de grupo, basta con escribir en la consola cmd el comando **gpupdate** :

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/043.png" width="750"/>
  <figcaption>gpupdate.</figcaption>
</figure>

Y ahora iniciamos una sesión con un usuario en la máquina cliente y comprobamos que efectivamente no se puede apagar la
máquina:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/044.png" width="850"/>
  <figcaption>Denegar apagado del sistema.</figcaption>
</figure>

Tas tareas más comunes que se realizan con las GPOs son aquellas relativas a las directivas de contraseñas, de inicios de
sesión y bloqueos entre otros. Para ejemplificar todo lo anterior vamos a modificar la **Default Domain Policy** para implementar
las siguientes configuraciones en el dominio:

1. Si el usuario se equivoca tres veces al introducir su contraseña, su cuenta queda bloqueada (solo la podrá desbloquear
el administrador). Esto protege el sistema de posibles ataques.
2. La contraseña deberá tener un mínimo de 5 caracteres, pero no es necesario obligatoriamente que sean mayúsculas,
minúsculas, caracteres alfanuméricos, obligatoriamente, etc.
3. La contraseña que se haya utilizado ya, no podrá volverse a utilizar hasta pasados al menos 10 cambios de contraseña
(de esta manera forzamos al usuario a que que no 'recicle' contraseñas antiguas, incrementando la seguridad del
sistema).
4. El usuario debe cambiar la contraseña cada seis meses, al establecer una 'vida útil' de las contraseñas tenemos un
sistema más seguro, ya que en caso de que alguien haya averiguado la contraseña del usuario, y no se haya
detectado, como tarde a los seis meses, perderá el acceso a la cuenta.

En las siguientes subsecciones se examina la manera de proceder para llevar a cabo estas configuraciones del sistema.

### Bloqueo de cuenta al introducir una contraseña 3 veces una contraseña errónea

En primer lugar editaremos el GPO '**Default Domain Policy**' para configurar la directiva de bloqueo de cuenta. Esta se halla en:

'**Configuración del equipo**'→'**Directivas**'→'**Configuración de Windows**'→'**Directiva de bloqueo de cuenta**'→'**Umbral de bloqueo
de cuenta**'

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/045.png" width="850"/>
  <figcaption>Acceso a GPOs Default Domain Policy.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/046.png" width="850"/>
  <figcaption>Acceso directiva bloqueo de cuenta.</figcaption>
</figure>

Modificamos la directiva Umbral de bloqueo de cuenta a '3 intentos' de inicio de sesión erróneos:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/047.png" width="850"/>
  <figcaption>Umbral de bloqueo de cuenta.</figcaption>
</figure>

Además configuraremos la duración del bloqueo, donde un valor de 0 indica que la cuenta deberá ser desbloqueada
manualmente por el administrador:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/048.png" width="850"/>
  <figcaption>Duración de bloqueo de cuenta.</figcaption>
</figure>

Finalmente también configuraremos el tiempo que debe transcurrir entre intentos para que el contador de fallos de inicio de
sesión vuelva a cero antes de que se bloquee la cuenta. Pondremos el máximo valor permitido:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/049.png" width="850"/>
  <figcaption>Restablecer el bloqueo.</figcaption>
</figure>

### Longitud de la contraseña

Como en el caso anterior editaremos el GPO '**Default Domain Policy**' para configurar la longitud y complejidad de las
contraseñas:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/050.png" width="850"/>
  <figcaption>Directivas de contraseñas.</figcaption>
</figure>

Modificamos el valor de la longitud a 5 caracteres:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/051.png" width="850"/>
  <figcaption>Longitud de la contraseña.</figcaption>
</figure>

A continuación deshabilitamos los requisitos de complejidad de las contraseñas. En la siguiente figura aparecen las
características de complejidad que aplica esta directiva cuando está habilitada:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/052.png" width="850"/>
  <figcaption>Deshabilitar complejidad de contraseñas.</figcaption>
</figure>

### Historial de contraseñas

Editamos de nuevo el GPO 'Default Domain Policy' y accedemos a las directivas de contraseñas:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/053.png" width="850"/>
  <figcaption>Historial de contraseñas.</figcaption>
</figure>

### Vigencia máxima de la contraseña

Como en casos anteriores accedemos a las directivas de contraseña:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/054.png" width="850"/>
  <figcaption>Vigencia máxima de la contraseña.</figcaption>
</figure>

Cambiamos la duración máxima de las contraseñas a **180 días -6 meses** 

- El resultado de cada una de las directivas de la sección Directivas de contraseñas sería:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/055.png" width="850"/>
  <figcaption>Directivas de contraseñas.</figcaption>
</figure>


## Creación de directivas de grupo

Vamos a modificar ciertas directivas de la organización Pistonazo, para ello accederemos:
'**Panel del administrador**'→'**Herramientas administrativas**'→'**Administración de directivas de grupo**'

Supongamos que queremos crear una Directiva de Grupo sobre la unidad organizativa 'Pistonazo' que creamos en el tema
anterior. Hacemos clic con el botón secundario y escogemos la opción 'Crear un GPO en este dominio y vincularlo aquí'

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/056.png" width="950"/>
  <figcaption>Directivas de grupo.</figcaption>
</figure>

Aparecerá el cuadro de diálogo e introduciremos el nombre que le queremos dar, por ejemplo 'Entorno de trabajo', ya que
posteriormente utilizaremos esta directiva para configurar un entorno de trabajo homogéneo en todos los usuarios que
pertenecen a la Unidad Organizativa 'Pistonazo'.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/057.png" width="550"/>
  <figcaption>Nueva GPO I.</figcaption>
</figure>

La nueva directiva aparecerá en el panel de detalles:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/058.png" width="950"/>
  <figcaption>Nueva GPO II.</figcaption>
</figure>

Seleccionamos el GPO y hacemos clic con el botón derecho, escogiendo la opción 'Editar'. Con la nueva directiva vamos a
establecer las siguientes configuraciones:

1. Todos los miembros de la unidad organizativa 'Pistonazo' tendrán un fondo de escritorio 'corporativo' que se instalará
de manera automática y que no podrá ser modificado.
2. Los miembros de la unidad organizativa 'Trabajadores' no pueden abrir la consola de comandos.

En las siguientes subsecciones se examina la manera de proceder para llevar a cabo estas configuraciones del sistema.

### Fondo de escritorio obligatorio

Para modificar de una manera centralizada el fondo de escritorio de los usuarios de la unidad organizativa 'Pistonazo'
debemos editar la directiva '**Entorno de Trabajo**' y acceder a '**Configuración del usuario**'→'**Plantillas administrativas**'→'**Active
Desktop**'→'**Active Desktop**'

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/059.png" width="950"/>
  <figcaption>GPO Pistonazo.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/060.png" width="950"/>
  <figcaption>Personalizar Active Desktop.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/061.png" width="750"/>
  <figcaption>Habilitamos el Active Desktop.</figcaption>
</figure>

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/062.png" width="750"/>
  <figcaption>Active Desktop.</figcaption>
</figure>

Vamos a impedir también que los usuarios puedan modificar el fondo de escritorio:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/063.png" width="750"/>
  <figcaption>No permitir cambios.</figcaption>
</figure>

Indicamos la ruta en la que se halla la imagen que queremos poner como fondo de escritorio. En este caso se llama
fondopisto.jpg y hay que añadirla a una carpeta compartida que se encuentre en el servidor. En nuestro caso, la añadiremos a
la carpeta Pistonazo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/064.png" width="750"/>
  <figcaption>Tapiz de escritorio.</figcaption>
</figure>

La imagen debe hallarse en una carpeta compartida en red (preferiblemente en el servidor por cuestiones de disponibilidad)
donde todos los usuarios del dominio tengan permiso de lectura. Además, se recomienda que la ruta se introduzca en formato
UNC del tipo:

``` yaml
\\server 1\gestion\fondocorp.jpg no en formato \\192.168.0.100\gestion\fondocorp.jpg
```

### Bloqueo de la línea de comandos

Para bloquear la línea de comandos editaremos el GPO correspondiente accediendo a '**Configuración del usuario**'→'**Plantillas
administrativas**'→'**Sistema**'

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/065.png" width="750"/>
  <figcaption>Bloqueo consola.</figcaption>
</figure>

Y habilitamos el bloqueo:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/065.png" width="750"/>
  <figcaption>Habilitar el bloqueo.</figcaption>
</figure>

### Comprobación de las directivas establecidas

Ahora comprobaremos que las directivas se han aplicado correctamente. Para ello utilizaremos un usuario cualquiera dentro
de la unidad organizativa 'Pistonazo' que es sobre la que se aplican el GPO creado 'Entorno de Trabajo', y obviamente el GPO
Default Domain Policy, que hemos editado.

#### Bloqueo de cuenta

La primera directiva que hemos aplicado consistía en bloquear la cuenta indefinidamente al introducir en tres ocasiones la
contraseña incorrectamente. Nos equivocamos voluntariamente al iniciar sesión en un equipo cliente y la cuenta se acaba
bloqueando. Por ejemplo, vamos a iniciar sesión con usuario usucomp1 e introduciremos 3 veces de manera incorrecta la
contraseña:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/066.png" width="750"/>
  <figcaption>Cuenta usucomp1 bloqueada.</figcaption>
</figure>

Comprobamos en el controlador de dominio que efectivamente está bloqueada y la desbloqueamos:

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/067.png" width="750"/>
  <figcaption>Cuenta bloqueada.</figcaption>
</figure>

### Longitud de la contraseña

Para comprobar la longitud de la contraseña, vamos a cambiar la contraseña del usuario usucomp1 y vamos a poner una
contraseña que tenga 5 caracteres, por ejemplo 12345.

<figure>
  <img src="./imagenes/02/PracticasAD/PR08/068.png" width="750"/>
  <figcaption>Restablecer contraseña.</figcaption>
</figure>

Así también hemos visto que podemos introducir una contraseña sin requisitos de complejidad.

!!! Note
    Ya se podría comprobar estas restricciones.


## Actividad

Habrá que modificar las siguientes directivas para conseguir:

1. Los usuarios deben cambiar la contraseña cada 90 días y guardar el historial de 5 contraseñas. Para facilitar la gestión
no será necesaria tener una restricción en cuánto a la complejidad de la contraseña y el número mínimo de caracteres
será de 4.
2. Para evitar posibles robos de contraseña y ataques mal intencionados, cuando un usuario intenta 4 veces introducir de
manera incorrecta su contraseña, la cuenta se bloqueará hasta que se reestablezca el contador de inicios de sesión erróneos a los 10minutos.

Haced una captura de pantalla de las directivas de contraseña y de inicios de sesión.