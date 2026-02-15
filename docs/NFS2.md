# PT62. INSTALACIÓN Y CONFIGURACIÓN DE NFS EN CLIENTE UBUNTU Y WINDOWS 10

## Introducción

En esta práctica se realiza la instalación y configuración de NFS en un cliente Lubuntu con el objetivo de acceder a la carpeta compartida en el servidor NFS.

!!! tip "Referencia teórica"
    Para consultar la teoría de NFS (protocolo, características, versiones, ventajas y desventajas): [NFS — Teoría y referencia](067_NFS.md).

## Entrega

En esta práctica se debe entregar un breve informe en **pdf**, en el "moodle", con capturas explicativas de:

!!! note "Nota"
    Las capturas deben ser realizadas del servidor ubuntu 22.04, pero de los resultados ejecutados desde una carpeta personal de un usuario creado por el alumnado, es decir, desde `/home/NombreAlumna` o `/home/NombreAlumno`.

- **Figura 3:** Creación carpeta en "UbuntuClient".
- **Figura 4:** Cambio de permisos en las carpetas compartidas.
- **Figura 5:** Montaje de las carpetas y comprobación.
- **Figura 7:** Configuración automática de montaje de carpetas en fstab.
- **Figura 9:** Instalación NFS en "WindowsClient".
- **Figura 10:** Acceso a las carpetas compartidas de NFS.

## Instalación de NFS en Cliente Lubuntu

Los siguiente pasos muestran los comandos a realizar para instalar NFS en un cliente.

1. El primer paso para cualquier instalación es la actualización de paquetes del sistema:

``` bash
sudo apt update -y
```

<figure>
  <img src="./imagenes/07/073/gifs/007G.gif"/>
  <figcaption><b>Figura 1:</b> Actualización Lubuntu.</figcaption>
</figure>

2. Instalación de NFS. Se deben instalar los paquetes **nfs-common** y **rpcbind**.

``` bash
sudo apt install nfs-common -y
```

!!! note "Ubuntu 24.04"
    El paquete `nfs-common` incluye el cliente NFS. `rpcbind` se instala como dependencia si es necesario.

<figure>
  <img src="./imagenes/07/073/gifs/008G.gif"/>
  <figcaption><b>Figura 2:</b> Instalación NFS en Lubuntu.</figcaption>
</figure>

## Acceder a la carpeta compartida en el servidor NFS desde un cliente Lubuntu

En este apartado se va a realizar:

- Crear el punto de montaje, en la estructura de directorios local, donde se montarán las carpetas compartidas.

- Realizar el montaje y comprobarlo.

- Crear algún archivo en las carpetas compartidas.

- Conseguir que las carpetas compartidas se monten automáticamente al arrancar el cliente.

##  Crear el punto de montaje para las carpetas compartidas

1. Se crea una subcarpeta, dentro de `/mnt` llamada `nfs`. En su interior, se reproduce la ruta original de las carpetas compartidas, en este caso de la carpeta compartida en el servidor NFS. Se hace con los siguientes comandos:

``` bash
sudo mkdir -p /mnt/nfs/home/sor/compartida
```

<figure>
  <img src="./imagenes/07/073/gifs/009G.gif"/>
  <figcaption><b>Figura 3:</b> Creación carpeta en Lubuntu.</figcaption>
</figure>

!!! note "Nota"
    Cabe destacar de la sintaxis anterior sea el uso del argumento -p (también se puede escribir –parents). Su cometido es doble: por un lado evitar que se produzca un error si alguna de las carpetas ya existiese (aunque este no es el caso); por el otro, crea automáticamente la parte de la estructura del árbol que sea necesaria.

!!! warning "Advertencia"
    Aunque se haya dado permisos de escritura sobre las carpetas compartidas en la configuración NFS del servidor, no se puede escribir en ellas si no se dispone de permisos sobre los puntos de montaje donde se van a montar dichas carpetas en los clientes. Por lo tanto se deben dar permisos en las carpetas.

2. Se cambian los permisos.

``` bash
sudo chmod -R 777 /mnt/nfs
```

<figure>
  <img src="./imagenes/07/073/gifs/010G.gif"/>
  <figcaption><b>Figura 4:</b> Cambio de permisos en las carpetas.</figcaption>
</figure>

##  Montaje para las carpetas compartidas

1. El siguiente paso será montar las carpetas compartidas por el servidor, en el punto montaje que hemos creado en el apartado anterior. Para ello, como es natural, recurrimos al comando mount.

Por otra parte para comprobar que l montaje se ha realizado correctamente se utiliza el comando `df`, el cual nos ofrece información sobre el espacio en disco utilizado y el que tenemos disponible en los sistemas de archivos que se tengan montados en estos momentos:

``` bash
sudo mount 192.168.2.4:/home/sor/compartida /mnt/nfs/home/sor/compartida
df -h
```

<figure>
  <img src="./imagenes/07/073/gifs/011G.gif"/>
  <figcaption><b>Figura 5:</b> Montaje de las carpetas y comprobación.</figcaption>
</figure>

## Crear archivos en las carpetas compartidas

Para comprobar que todo funciona correctamente, se puede crear un par de archivos vacíos y después comprobar que se han creado.

``` bash
sudo touch /mnt/nfs/home/sor/compartida/ejemplo.txt
ls /mnt/nfs/home/sor/compartida
```

<figure>
  <img src="./imagenes/07/073/gifs/012G.gif"/>
  <figcaption><b>Figura 6:</b> Crear archivos y comprobación.</figcaption>
</figure>

## Montar automáticamente las carpetas compartidas al iniciar el cliente

La configuración de montaje de esta forma tiene un gran inconveniente, si se reinicia el cliente la configuración se pierde. Para solucionarlo se dispone de un archivo denominado `/etc/fstab` (file systems table) donde se guarda la información necesaria sobre los diferentes volúmenes que se montarán durante el arranque del sistema.

Para modificar este archivo se debe tener en cuenta:

- Cada línea del archivo representa un volumen diferente y atiende al siguiente formato:

- **Dispositivo**: Referencia al volumen que vamos a montar. En este caso su valor será 192.168.2.4:/home/sor/compartida.

- **Punto de montaje**: La carpeta donde se montarán los datos del volumen. Su valor para la primera carpeta será /mnt/nfs/home/sor/compartida.

- **Sistema de archivos**: Indica el sistema de archivos utilizado en el volumen. En ambos casos, el valor será `nfs`.

- **Opciones**: Indica los parámetros que usará mount para montar el dispositivo. Estarán separadas por comas y no incluirán espacios. En este caso las opciones serán auto,noatime,nolock,bg,nfsvers=3,intr,tcp,actimeo=1800. Estas opciones son explicadas en detalle en la documentación oficial de ubuntu [Enlace](https://manpages.ubuntu.com/manpages/xenial/es/man5/nfs.5.html).

- **Frecuencia de respaldo**: Frecuencia con la que se utiliza la herramienta dump para respaldar (copiar) el sistema de archivos. Si su valor es cero, el volumen no se respalda.

- **Orden de revisión**: Orden en el que la herramienta `fsck` revisa el volumen en busca de posibles errores durante el proceso de inicio. Si su valor es cero, el volumen no se revisa.

Por lo tanto se debe incluir la línea indicada abajo para realizar la configuración automática del montaje:

``` bash
sudo nano /etc/fstab
```

Añadir la línea (sustituir `192.168.2.4` por la IP del servidor NFS):

```
192.168.2.4:/home/sor/compartida /mnt/nfs/home/sor/compartida nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
```

!!! tip "Ubuntu 24.04"
    La opción `nofail` evita que el sistema falle al arrancar si el servidor NFS no está disponible. Para NFSv4 (predeterminado en Ubuntu 24.04) se puede usar `nfs4` como tipo.

<figure>
  <img src="./imagenes/07/073/gifs/013G.gif"/>
  <figcaption><b>Figura 7:</b> Configuración automática de montaje de carpetas en fstab.</figcaption>
</figure>

!!! tip "Comprobación"
    Por último solo quedaría comprobar tras el reinicio que se monta automáticamente la carpeta compartida.

## Instalación NFS en Windows 10/11

A continuación se muestran los pasos para la instalación:

1. Ejecutar `appwiz.cpl` (Win+R) o acceder a **Panel de control** → **Programas y características**.

<figure>
  <img src="./imagenes/07/073/gifs/014G.gif"/>
  <figcaption><b>Figura 8:</b> Acceso a Programas y características.</figcaption>
</figure>

2. A continuación se hace clic sobre el enlace **Activar o desactivar las características de Windows**, en el panel izquierdo de la ventana.

- De este modo, se consigue que se abra una nueva ventana, en este caso, titulada **Características de Windows**. En ella, se debe desplazar hacia abajo, hasta encontrar una categoría titulada Servicios para NFS.

- Una vez localizada, se despliega para mostrar su contenido y, en su interior, se debe marcar las opciones Cliente para **NFS** y **Herramientas administrativas**.

<figure>
  <img src="./imagenes/07/073/gifs/015G.gif"/>
  <figcaption><b>Figura 9:</b> Marcado NFS y Herramientas administrativas.</figcaption>
</figure>

!!! note "Nota"
    Después de este paso se queda instalado NFS en el cliente.

## Acceso desde W10 a la carpeta compartida del servidor NFS

Para acceder a los datos compartidos por el servidor NFS de un modo esporádico, se puede abriendo una nueva ventana del explorador de archivos y, en su barra de direcciones, escribir la dirección IP del servidor precedida de dos barras inclinadas (\\). En este caso:

``` bash
\\192.168.2.4
``` 

<figure>
  <img src="./imagenes/07/073/gifs/016G.gif"/>
  <figcaption><b>Figura 10:</b> Acceso a las carpetas compartidas de  NFS de forma esporádica.</figcaption>
</figure>

!!! warning "Advertencia"
    - Si existen problemas de acceso se puede revisar:
    - Permisos carpetas superiores a la /compartida, configurar a 755, son los predeterminados del NFS nativo de Windows.
    - Añadir la ruta completa de /compartida si esta configurada en /etc/exports con la virgulilla.