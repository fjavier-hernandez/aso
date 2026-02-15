# Instalación y configuración en un cliente Windows 10/11

En esta práctica se realiza la instalación y configuración de NFS en un cliente Windows 10 u 11 con el objetivo de acceder a la carpeta compartida en el servidor NFS.

!!! tip "Referencia teórica"
    Para consultar la teoría de NFS (protocolo, características, versiones, ventajas y desventajas): [NFS — Teoría y referencia](067_NFS.md).

## Entrega

En esta práctica se debe entregar un breve informe en **pdf**, en el "moodle", con capturas explicativas de:

!!! note "Nota"
    Las capturas deben ser realizadas del servidor ubuntu 22.04, pero de los resultados ejecutados desde una carpeta personal de un usuario creado por el alumnado, es decir, desde `/home/NombreAlumna` o `/home/NombreAlumno`.

- **Figura 2:** Instalación NFS en "WindowsClient".
- **Figura 3:** Acceso a las carpetas compartidas de  NFS de forma esporádica.
- **Figura 5:** Edición **nfs.bat**.
- Comprobación se crea automáticamente la carpeta compartida.

## Instalación NFS en Windows 10/11

A continuación se muestran los pasos para la instalación:

1. Ejecutar `appwiz.cpl` (Win+R) o acceder a **Panel de control** → **Programas y características** → **Activar o desactivar características de Windows**.

<figure>
  <img src="./imagenes/07/073/gifs/014G.gif"/>
  <figcaption><b>Figura 1:</b> Acceso a Programas y características.</figcaption>
</figure>

2. A continuación se hace clic sobre el enlace **Activar o desactivar las características de Windows**, en el panel izquierdo de la ventana.

- De este modo, se consigue que se abra una nueva ventana, en este caso, titulada **Características de Windows**. En ella, se debe desplazar hacia abajo, hasta encontrar una categoría titulada Servicios para NFS.

- Una vez localizada, se despliega para mostrar su contenido y, en su interior, se debe marcar las opciones Cliente para **NFS** y **Herramientas administrativas**.

<figure>
  <img src="./imagenes/07/073/gifs/015G.gif"/>
  <figcaption><b>Figura 2:</b> Marcado NFS y Herramientas administrativas.</figcaption>
</figure>

!!! note "Nota"
    Después de este paso se queda instalado NFS en el cliente.

## Acceso puntual a la carpeta compartida

Para acceder a los datos compartidos por el servidor NFS de un modo esporádico, se puede abriendo una nueva ventana del explorador de archivos y, en su barra de direcciones, escribir la dirección IP del servidor precedida de dos barras inclinadas (\\). En este caso:

``` bash
\\192.168.2.4
``` 

<figure>
  <img src="./imagenes/07/073/gifs/016G.gif"/>
  <figcaption><b>Figura 3:</b> Acceso a las carpetas compartidas de  NFS de forma esporádica.</figcaption>
</figure>

!!! warning "Advertencia"
    - Si existen problemas de acceso se puede revisar:
    - Permisos carpetas superiores a la /compartida, configurar a 755, son los predeterminados del NFS nativo de Windows.
    - añadir la ruta completa de /compartida si esta configurada en /etc/exports con la virgulilla.

## Montar las carpetas NFS automáticamente durante el inicio de Windows

El sistema operativo Windows dispone de una carpeta especial, llamada Inicio, donde se pueden incluir archivos para que se ejecuten durante el arranque del equipo.

1. Para abrirla, se usa la combinación de teclas `Windows + R` o escribir en la barra de búsqueda ejecutar, para obtener la ventana Ejecutar. En ella, se escribe la siguiente orden:

``` bash
shell:startup
```

2. Al hacerlo, se abrirá el Explorador de archivos, mostrando el contenido de la carpeta Inicio. Interesa que se muestren las extensiones de los archivos, a continuación se hace clic sobre el menú `Vista`, y se debe marcar la opción de `Mostrar extensiones de los archivos`

3. A continuación, clic con el botón derecho del ratón, sobre cualquier espacio libre de la ventana, para crear un nuevo archivo de texto con el nombre `nfs.bat`.

<figure>
  <img src="./imagenes/07/073/gifs/017G.gif"/>
  <figcaption><b>Figura 4:</b> Creación <b>nfs.bat</b> en carpeta <b>Inicio</b></figcaption>
</figure>

4. Se edita el archivo para darle contenido. Se hace clic, con el botón derecho del ratón, sobre su nombre y en el menú de contexto que aparece, hacemos clic sobre la opción Editar.

5. El resultado será una nueva ventana del `Bloc de notas`, con su espacio de trabajo completamente limpio. En él, se escribe lo siguiente:

``` bash
mount -o anon 192.168.2.4:/home/sor/compartida N:
```

- Donde:

- El argumento -o anon hará que la carpeta se monte usando un usuario anónimo.

- A continuación, se incluye la dirección IP del servidor y la ruta de la carpeta compartida.

- Por último, se incluye la letra de unidad que usará Windows para referirse a la carpeta.

<figure>
  <img src="./imagenes/07/073/gifs/018G.gif"/>
  <figcaption><b>Figura 5:</b> Edición <b>nfs.bat</b></figcaption>
</figure>

!!! tip "Consejo"
    Por último solo quedaría comprobar tras el reinicio que se monta automáticamente la carpeta compartida.