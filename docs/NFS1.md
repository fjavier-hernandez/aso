# PT61. INSTALACIÓN Y CONFIGURACIÓN DE NFS EN SERVIDOR UBUNTU

## Introducción

En esta práctica se realiza la instalación y configuración de NFS en un servidor Ubuntu 24.04 con el objetivo de compartir una carpeta y que se acceda desde un cliente Ubuntu/Lubuntu.

!!! tip "Referencia teórica"
    Para consultar la teoría de NFS (protocolo, características, versiones, ventajas y desventajas): [NFS — Teoría y referencia](067_NFS.md).

## Entrega

En esta práctica se debe entregar un breve informe en **pdf**, en el "moodle", con capturas explicativas de:

!!! note "Nota"
    Las capturas deben ser realizadas del servidor ubuntu 22.04, pero de los resultados ejecutados desde una carpeta personal de un usuario creado por el alumnado, es decir, desde `/home/NombreAlumna` o `/home/NombreAlumno`.

- **Figura 3**: confirmación del servicio está ejecutándose correctamente (`systemctl status nfs-server`).
- **Figura 4**: creación de carpetas compartidas.
- **Figura 5**: Modificación de `/etc/exports`.
- **Figura 6**: Creación archivo de prueba en carpeta compartida.

A continuación se muestra una guía de pasos para la instalación de NFS en un servidor Ubuntu 24.04:

## Instalación de NFS en Servidor Ubuntu 24.04

1. El primer paso para cualquier instalación es la actualización de paquetes del sistema:

``` bash
sudo apt update -y
```

<figure>
  <img src="./imagenes/07/073/gifs/001G.gif"/>
  <figcaption><b>Figura 1:</b> Actualización del sistema Ubuntu 22.04.</figcaption>
</figure>

2. Se instala NFS.

El paquete que necesitamos se llama nfs-kernel-server. Además, su instalación provoca que se instalen, a modo de dependencias, dos paquetes más:

- **nfs-common**, que contiene los programas que nos permitirán usar NFS, tanto en el lado cliente como en el lado servidor. Entre ellos se encuentran los comandos lockd, statd, showmount y nfsstat.

- **rpcbind**, un servicio que convierte los identificadores de programa RPC (Remote Procedure Call) en direcciones universales.

Para instarlo se utiliza el siguiente comando:

``` bash
sudo apt install nfs-kernel-server -y
```

<figure>
  <img src="./imagenes/07/073/gifs/002G.gif"/>
  <figcaption><b>Figura 2:</b> Instalación de NFS.</figcaption>
</figure>

3. Se comprueba la instalación con el comando:

``` bash
sudo systemctl status nfs-server
```

!!! tip "Ubuntu 24.04"
    En Ubuntu 24.04, NFSv4 es la versión predeterminada. El servicio `nfs-server` agrupa los daemons necesarios (rpcbind, nfsd, mountd).

<figure>
  <img src="./imagenes/07/073/gifs/003G.gif"/>
  <figcaption><b>Figura 3:</b> Comprobación de NFS.</figcaption>
</figure>

## Configuración de NFS en Servidor Ubuntu 24.04

En este aparatado se realiza:

- Se crea una carpeta en el directorio raíz de tu servidor con el nombre almacenamiento y se asegura de que es accesible por cualquier usuario del sistema.

- Se realiza las operaciones necesarias para exportar a NFS la carpeta **/compartida** y la carpeta **/home**.

- Se crea un archivo de prueba en la carpeta **/compartida** e inicia o reinicia (según sea necesario) el servicio NFS.

1. Creación carpeta y cambio de permisos.

``` bash
sudo mkdir ~/compartida
sudo chown nobody:nogroup ~/compartida
sudo chmod -R 777 ~/compartida
```

<figure>
  <img src="./imagenes/07/073/gifs/004G.gif"/>
  <figcaption><b>Figura 4:</b> Creación carpeta de NFS.</figcaption>
</figure>

2. Compartir el contenido de las carpetas.

Para compartir el contenido de la carpeta creada se debe editar el archivo `/etc/exports`. Este es el archivo donde se indican a NFS las carpetas que se van a compartir (exportar, en la terminología NFS). Para editar el archivo se debe tener en cuenta:

- Cada carpeta exportada debe estar en una línea diferente de este archivo, aunque una línea muy larga puede continuarse en la línea siguiente poniendo al final una barra invertida (‘\’).
- Las líneas tienen el siguiente formato:

!!! quote "Formato líneas"
    ruta cliente_1(opciones) cliente_2(opciones) …

!!! warning "Cuidado"
    No hay espacios en la definición de un cliente, sólo entre un cliente y otro, y entre el primero y la ruta de la carpeta.

Se observa que cada cliente tiene dos partes:

**a)** La primera identifica al ordenador cliente, se puede utilizar rangos de direcciones de IP, un nombre DNS, caracteres comodín para representar todo el nombre del cliente o una parte. Podemos utilizar los comodines siguientes:

**"?"**, Para representar un carácter cualquiera.

**"*"**, Para representar cualquier conjunto de caracteres. 

La segunda será una lista de opciones para compartir. Entre las opciones que podemos utilizar, se encuentran las siguientes:

- **ro(read-only)**: La carpeta compartida será de sólo lectura. Es la opción predeterminada.
- **rw (read-write)**: El usuario podrá realizar cambios en el contenido de la carpeta compartida.
- **root_squash**: Evita que los usuarios con privilegios administrativos los mantengan, sobre la carpeta compartida, cuando se conectan remotamente. En su lugar, se les trata como un usuario `“nfsnobody”` que es un usuario con permisos mínimos. Es la opción predeterminada.
- **no_root_squash**: Deshabilita la característica anterior.
- **sync**: Evita responder peticiones antes de escribir los cambios pendientes en disco. De tal forma que cada cambio que recibe la escribe en disco y luego confirma que ha sido escrita correctamente. Es la opción predeterminada.
- **async**: Deshabilita la característica anterior. Mejora el rendimiento a cambio de que exista el riesgo de corrupción en los archivos o, incluso, en todo el sistema de archivos, si se produjese una interrupción del fluido eléctrico o un bloqueo del sistema. Recibe la orden de escritura y confirma al cliente que ha sido realizada con éxito (mentira, ya que no ha sido realizada), acto seguido puede recibir X órdenes de otros clientes y a todos les hará lo mismo, finalmente realiza escribe todos los cambios a la vez. Por tanto es más rápido que el método síncrono ya que no debe realizar tantos accesos a memoria.
- **subtree_check**: Cuando el directorio compartido es un subdirectorio de un sistema de archivos mayor, **NFS** comprueba los directorios por encima de éste para verificar sus permisos y características. Es la opción predeterminada.
- **no_subtree_check**: Deshabilita la característica anterior, lo que hace que el envío de la lista de archivos sea más rápido, pero puede reducir la seguridad.

En este caso se debe añadir una línea para el `/home`, puesto que es donde se ubica la carpeta compartida y para la carpeta `/compartida`:

``` bash
/home *(rw,sync,no_root_squash,no_subtree_check)
~/compartida *(rw,sync,no_subtree_check)
```

3. Iniciar/reiniciar el servicio NFS.

Siempre que se hagan cambios en el archivo `/etc/exports`, se debe aplicar la configuración y reiniciar el servicio:

``` bash
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
```


<figure>
  <img src="./imagenes/07/073/gifs/005G.gif"/>
  <figcaption><b>Figura 5:</b> Exportar carpetas home y compartida y reiniciar servicio.</figcaption>
</figure>



4. Crear un archivo en una carpeta compartida.

Para confirmar que se tiene acceso al contenido de la carpeta compartida por un cliente se crea una archivo de prueba.

``` bash
touch ~/compartida/prueba.txt
```

<figure>
  <img src="./imagenes/07/073/gifs/006G.gif"/>
  <figcaption><b>Figura 6:</b> Creación archivo de prueba en carpeta compartida.</figcaption>
</figure>