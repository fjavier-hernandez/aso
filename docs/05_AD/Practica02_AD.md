# Configuración Básica Windows Server

## Puntos de guía

1. Crea un usuario con permisos de administrador.
2. Configura el Escritorio Remoto para que el nuevo usuario pueda acceder y que además solo se pueda acceder desde una red privada. Añade una captura con el nuevo usuario accediendo en remoto al servidor y de la configuración del firewall.
3. ¿Qué dos formas de gestión remota hay para Windows Server?
4. ¿Podríamos gestionar a través de Escritorio remoto 2 personas Windows Server a la vez con la misma cuenta?
5. Explica la diferencia entre una regla de entrada del firewall y una regla de salida.
6. Activa la regla de Entrada “Supervisión de máquina virtual (Solicitud de eco – ICMPv4 de entrada). Además debes modificar dicha regla para que solo acepte solicitudes de equipos del dominio. Adjunta pantalla de ambas tareas.
7. Comprueba que efectivamente puedes navegar desde el Windows Server. Crea una regla de salida que corte el tráfico TCP a los puertos 80 y 443. A continuación prueba a navegar. ¿Qué sucede? ¿A qué hacen referencia los puertos 80 y 443? Adjunta pantallas de la configuración de la regla. Finalmente deshabilita la regla para poder navegar, aunque un servidor Windows no tiene por qué tener ninguna necesidad de navegación web.

## Rastreador de eventos

Un servidor, habitualmente, no debe apagarse o reiniciarse, al no ser que sea por un motivo de avería o mantenimiento. Es por ello que cada vez que necesitemos reiniciarlo/apagarlo dejemos anotado a que es debido dicha acción.

En Windows Server es recomendable usar “**alt + f4**” para apagar, ya que nos permitirá dejar una descripción de la razón por la que vamos a reiniciar/apagar el servidor. Obviamente esta descripción quedará almacenada en los logs y registros del sistema. 

<figure>
  <img src="./imagenes/02/PracticasAD/RastreadorEventos.png" width="500"/>
</figure>

## Actualizaciones

En un servidor es muy importante que se mantenga actualizado, de lo contrario tendremos fallos de seguridad. No obstante, es importante que estas actualizaciones se realicen en horario de bajo impacto, ya que:

- Pueden ocupar parte del **ancho de banda** de nuestro servidor y los clientes pueden notar por ello una bajada del rendimiento.
- Vas a tener la **CPU/RAM** ocupada en actualizar los servicios en vez de atender las peticiones de clientes.
- Es posible que tras la actualización se realice un **reinicio**, si este reinicio no lo programamos en horas de bajo impacto, por ejemplo a las 03:00 am, supondrá un corte en el servicio.

## Configurar horarios de reinicio 

* Se pueden configurar en **“Configuración de Windows Update”** y en **“Cambiar horas activas”**


<figure>
  <img src="./imagenes/02/PracticasAD/ConfHorRein.png" width="800"/>
</figure>

En las **horas activas** elegiremos las horas en las que **NO** queremos que se reinicie el servidor, es decir, si estamos en una empresa que trabaja de 07:00 a 20:00,  éstas serán las horas activas. En caso de que sea una empresa 24/365, habría que informar de un corte de servicio o tener duplicadas las máquinas y que una soporte todo el trabajo mientras la otra se actualiza y viceversa.

<figure>
  <img src="./imagenes/02/PracticasAD/HorasActivasWS.png" width="500"/>
</figure>


## Configurar los horarios de descarga de actualizaciones

Se ejecutan las políticas de grupo del equipo local. Para que salga la ventana de **“Ejecutar”** lo más rápido es tocar la tecla de **Windows+R**.

Aunque lo veremos más adelante es importante que tengáis claro que las políticas de grupo de un dominio prevalecen o tienen prioridad sobre las políticas de grupo locales.

<figure>
  <img src="./imagenes/02/PracticasAD/AccesoGpedit.png" width="500"/>
</figure>

Dentro de las directivas de grupo vamos a ir a:

- Configuración del equipo local -> **Plantillas Administrativas** -> **Componentes de Windows** -> **Windows Update**.
- Dentro de Windows Update elegiremos -> **Configurar Actualizaciones Automáticas**.

<figure>
  <img src="./imagenes/02/PracticasAD/ActulizacioneaAut.png" width="700"/>
</figure>

## Cuentas locales en el servidor

En un servidor, por defecto, únicamente la cuenta administrador activa. Las cuentas por defecto o de invitado están deshabilitadas (representadas con una flecha negra apuntando hacia abajo) por seguridad.

No obstante, es posible que en nuestra empresa seamos más de un administrador del sistema y por tanto, es posible que cada administrador tenga su propia cuenta, por ejemplo para que quede registrado quien ha hecho cada acción dentro del servidor.

Para **crear cuentas locales** vamos al icono de Windows de la barra de inicio y hacemos click en el botón derecho, eligiendo **“Administración de equipos”**.

<figure>
  <img src="./imagenes/02/PracticasAD/Cuentaslocales1.png" width="900"/>
</figure>

Seleccionando botón derecho se puede crear un usuario nuevo.

<figure>
  <img src="./imagenes/02/PracticasAD/CreacionUser.png" width="500"/>
</figure>
Una vez creado el usuario, hay dos cosas que tenemos que tener en cuenta:

- Que tenga habilitado el acceso por **escritorio remoto**. Habitualmente los servidores de Windows Server se gestionan en remoto, ya que el servidor se encontrará en el CPD y el administrador en la oficina.

<figure>
  <img src="./imagenes/02/PracticasAD/ControlRemoto.png" width="500"/>
</figure>

- Que tenga **permisos de administrador**, ya que al servidor solo accederán habitualmente nuestros compañeros que sean también administradores del sistema.


<figure>
  <img src="./imagenes/02/PracticasAD/PermisosAd.png" width="900"/>
</figure>

Buscaremos el grupo **“Administradores”** y lo agregaremos al usuario.

<figure>
  <img src="./imagenes/02/PracticasAD/AdalUser.png" width="900"/>
</figure>

## Administrador de servidor

En el administrador de servidor podremos administrar todo:

- Servidores remotos.
- Servicios: DNS, NTP, DHCP, …
- Notificaciones y alertas.
- Almacenamiento.
- Gestionar Copias de Seguridad.
- Monitorización del estado del servidor.
- Administración de equipos / dispositivos.

<figure>
  <img src="./imagenes/02/PracticasAD/13.png" width="900"/>
</figure>

## Cambiar nombre al servidor

Es importante indicar el nombre de nuestros equipos para que sea fácil identificarlos. Debemos darles un **nombre significativo,** por ejemplo si este equipo va a ser un Controlador de Dominio y va a ser el primero, podemos ponerle “DC01…” 

!!! Tip
    Se recomienda no usar caracteres especiales en el nombre y por supuesto nada de espacios en blanco.

!!! Warning
    **Es importante cambiar el nombre antes de tener configurado el Directorio Activo, ya que si no habrá que cambiar todo lo relacionado con la resolución de nombres (DNS).**


<figure>
  <img src="./imagenes/02/PracticasAD/14.png" width="900"/>
</figure>

## Escritorio Remoto.

Habitualmente nuestro servidor estará en un CPD, posiblemente será un servidor virtualizado. Lo que hace esencial configurar correctamente la herramienta pertinente para su administración remota. En el caso de Windows Server, que cuenta con una buena interfaz gráfica, haremos uso de **Escritorio Remoto (RDP)**, del cual tenemos que ser consciente que es un servicio bastante atacado por ciberdelincuentes. También se puede gestionar por **consola a través de PowerShell**.

<figure>
  <img src="./imagenes/02/PracticasAD/15.png" width="900"/>
</figure>

Obviamente aparte de tener habilitado el Escritorio remoto, el usuario debe tener permisos de acceso remoto al servidor.

<figure>
  <img src="./imagenes/02/PracticasAD/16.png" width="900"/>
</figure>

Por defecto una misma cuenta de usuario solo puede conectarse una vez de forma simultánea.

## Configuración de Red

La configuración de red se hace igual que un Windows Cliente. 

En cuanto a la máquina virtual dependerá de nuestros recursos (memoria, CPU, discos SSD, gráfica):

- Máquina virtual para  Windows 10 y para Windows Server 2019.

## Seguridad (Firewall)

Cada vez que arrancamos un servicio (Remote Desktop Protocol, DHCP, DNS, … ) se abren una serie de puertas (puertos de red). Los ciberdelincuentes atacan estos puertos “abiertos” para intentar conseguir acceso indebido.

Por todo ello, es importante tener abiertas solo las puertas (puertos) estrictamente necesario, es decir, si nuestro servidor no va a hacer uso de un servicio DNS, no lo actives.

Además, una herramienta muy importante para controlar esto es el **“Firewall”**:

<figure>
  <img src="./imagenes/02/PracticasAD/17.png" width="900"/>
</figure>

Existirán unas reglas diferentes dependiendo de la IP del equipo que realiza la petición:

- Si la IP viene de Internet (**Red Pública**).
- Si la IP viene de mi red local (**Red Privada**).
- Si la IP viene de un equipo asociado al dominio (**Red Dominio**).

En la configuración podemos decirle que bloquee el acceso a las aplicaciones dependiendo de la red  de  donde provengan, por ejemplo si en la red pública bloqueamos todas las conexiones, querrá decir que solo podremos administrar el servidor desde una red privada o red del dominio.

<figure>
  <img src="./imagenes/02/PracticasAD/18.png" width="300"/>
</figure>

No obstante, quizá queramos que ciertas aplicaciones sí sean accesibles desde la red pública y otras no. En tal caso, deberemos añadir reglas por aplicaciones:

<figure>
  <img src="./imagenes/02/PracticasAD/19.png" width="900"/>
</figure>

Por ejemplo indicar que solo se puede gestionar este equipo de forma remota desde una red privada.

<figure>
  <img src="./imagenes/02/PracticasAD/20.png" width="900"/>
</figure>

También se pueden crear filtros avanzados:

<figure>
  <img src="./imagenes/02/PracticasAD/21.png" width="300"/>
</figure>

Por ejemplo aquí vemos que el Escritorio Remoto actualmente está usando el puerto 3389 mediante UDP. Si no tiene el icono verde, es que no está habilitada la regla.

<figure>
  <img src="./imagenes/02/PracticasAD/22.png" width="1300"/>
</figure>

Si hacemos doble click en cualquier regla podremos manipular:

- La aplicación a la que afecta.
- Filtrar por usuarios, interfaces (alámbricas, inalámbricas, remotas), tipos de red (pública, privada, dominio) o direccionamiento IP.
- Puerto y Protocolo (TCP o UDP) usado.

Podemos crear nuestras propias reglas:

<figure>
  <img src="./imagenes/02/PracticasAD/23.png" width="900"/>
</figure>


