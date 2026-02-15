# Práctica: Instalación y configuración de NFS en contenedor Ubuntu Server

## Objetivos

Durante esta práctica aprenderás a instalar y configurar **NFS** (Network File System) en un **contenedor Ubuntu Server 24.04** y a acceder a las carpetas compartidas desde un cliente contenedor y desde la **máquina host**.

Al finalizar esta práctica serás capaz de:

- Crear y ejecutar contenedores Ubuntu Server con Docker.
- Instalar el servidor NFS (`nfs-kernel-server`) dentro del contenedor.
- Configurar las exportaciones en `/etc/exports`.
- Montar carpetas NFS desde un cliente contenedor.
- **Comprobar el acceso desde la máquina host** (obligatorio).
- Configurar montaje automático en cliente Linux (`/etc/fstab`) y en Windows (script de inicio).
- Documentar el proceso con capturas de pantalla.

## Requisitos previos

- **Docker** instalado en el host (Linux, macOS o Windows).
- **Host con soporte NFS**: puede ser **cualquier sistema** (Windows, Linux, macOS o WSL2). Principalmente se usará **Windows** como host.

!!! note "NFS en contenedor"
    El servidor NFS requiere módulos del kernel. El contenedor debe ejecutarse con `--privileged` para que NFS funcione correctamente.

!!! warning "Formato de /etc/exports"
    No debe haber espacios entre el cliente y las opciones: `ruta cliente(opciones)`. Un espacio antes de `(` provocaría un error.

---

## Paso 0: Crear el contenedor servidor NFS

Crea y ejecuta un contenedor Ubuntu Server 24.04 publicando los puertos NFS para que el host pueda conectarse:

```bash
# Crear red para que los contenedores se comuniquen
docker network create red-nfs

# Crear y ejecutar contenedor servidor NFS (Ubuntu 24.04)
# --privileged: necesario para módulos del kernel de NFS
# -p: publicar puertos para que el host pueda montar el recurso
docker run -d --name nfs-server --privileged --network red-nfs \
  -p 2049:2049 -p 111:111 -p 111:111/udp \
  -v nfs-data:/compartida \
  ubuntu:24.04 sleep infinity
```

Entra al contenedor para configurarlo:

```bash
docker exec -it nfs-server bash
```

!!! tip "Captura obligatoria"
    Realiza una captura del comando `docker run` y la salida de `docker ps` mostrando el contenedor en ejecución.

---

## Parte 1: Configuración del servidor NFS (dentro del contenedor)

### 1.1 Actualización e instalación

Dentro del contenedor `nfs-server`:

```bash
apt update
apt install nfs-kernel-server nano -y
```

El paquete `nfs-kernel-server` instala como dependencias:

- **nfs-common**: programas para usar NFS (cliente y servidor): `lockd`, `statd`, `showmount`, `nfsstat`.
- **rpcbind**: servicio que convierte identificadores RPC en direcciones universales.

### 1.2 Crear carpeta compartida y permisos

La carpeta `/compartida` ya existe (volumen montado). Asigna permisos:

```bash
chown nobody:nogroup /compartida
chmod 777 /compartida
```

!!! tip "Captura obligatoria"
    Captura la salida de `ls -la /compartida` mostrando los permisos asignados.

### 1.3 Configurar exportaciones (modificación de archivos)

**Archivo a modificar:** `/etc/exports` (dentro del contenedor servidor)

Pasos para editar:

1. Ejecuta `nano /etc/exports`
2. Añade **una sola línea** al final del archivo (o sustituye el contenido si está vacío)
3. Escribe exactamente: `/compartida *(rw,sync,no_subtree_check,insecure)`
4. **Importante**: no debe haber espacio entre `*` y `(rw,...)` — un espacio provocaría error
5. Guarda: Ctrl+O, Enter, Ctrl+X

Contenido que debe quedar en el archivo:

```
/compartida *(rw,sync,no_subtree_check,insecure)
```

Verifica el contenido con:

```bash
cat /etc/exports
```

La salida esperada debe ser exactamente:

```
/compartida *(rw,sync,no_subtree_check,insecure)
```

!!! tip "Captura obligatoria"
    Realiza una captura mostrando la salida de `cat /etc/exports` con la línea correcta.

!!! tip "Opciones de /etc/exports"
    | Opción | Descripción |
    |--------|-------------|
    | `*` | Cualquier cliente puede acceder (comodín) |
    | `rw` | Lectura y escritura |
    | `ro` | Solo lectura (predeterminado) |
    | `sync` | Escribir en disco antes de confirmar (recomendado) |
    | `no_subtree_check` | Mejor rendimiento; desactiva verificación de subárbol |
    | `insecure` | Permite clientes en puertos > 1024 (necesario en contenedores) |
    | `root_squash` | root remoto se trata como nobody (seguridad) |
    | `no_root_squash` | Desactiva root_squash (menos seguro) |

### 1.4 Iniciar servicios e exportar

```bash
# Iniciar rpcbind (requerido por NFS)
service rpcbind start

# Iniciar NFS
service nfs-kernel-server start

# Aplicar exportaciones
exportfs -a

# Verificar estado del servicio
service nfs-kernel-server status

# Verificar exportaciones
exportfs -v
showmount -e localhost
```

La salida de `showmount -e localhost` debe mostrar `/compartida` y la de `exportfs -v` debe confirmar las opciones.

!!! tip "Captura obligatoria"
    Realiza una captura mostrando la salida de `exportfs -v` y `showmount -e localhost`.

!!! tip "Si el servicio no arranca"
    En algunos contenedores minimales puedes iniciar los daemons manualmente: `rpcbind`, `rpc.nfsd 8`, `rpc.mountd`.

### 1.5 Crear archivo de prueba en el servidor

Para confirmar que la carpeta está accesible:

```bash
touch /compartida/prueba_servidor.txt
ls -la /compartida
```

### 1.6 Salir del contenedor

```bash
exit
```

---

## Parte 2: Cliente en contenedor Ubuntu

Crea un contenedor cliente en la misma red (Ubuntu 24.04):

```bash
docker run -d --name nfs-cliente --network red-nfs \
  ubuntu:24.04 sleep infinity
```

Entra al cliente e instala el paquete NFS:

```bash
docker exec -it nfs-cliente bash
```

Dentro del cliente:

```bash
apt update
apt install nfs-common -y

# Crear punto de montaje
mkdir -p /mnt/nfs

# Montar (usa el nombre del contenedor servidor como hostname)
# NFSv4 es el predeterminado en Ubuntu 24.04
mount -t nfs nfs-server:/compartida /mnt/nfs

# Verificar
df -h
ls -la /mnt/nfs

# Crear archivo de prueba
echo "Prueba NFS desde contenedor" > /mnt/nfs/test_contenedor.txt
cat /mnt/nfs/test_contenedor.txt
```

Sal del cliente: `exit`

!!! tip "Captura obligatoria"
    Captura el montaje, `df -h`, `ls -la /mnt/nfs` y el archivo creado.

---

## Parte 3: Comprobación desde la máquina host (obligatorio)

!!! warning "Comprobación obligatoria"
    La verificación desde el **host** es **obligatoria** y no puede omitirse. Demuestra la interoperabilidad entre el contenedor NFS y el sistema anfitrión. Sin esta comprobación la práctica no se considera completada.

### 3.1 Requisitos del host

El host puede ser **cualquier sistema**, principalmente **Windows**:

- **Windows** (Pro/Enterprise/Education): activar Cliente para NFS (ver 3.2).
- **WSL2** (Windows): usar Ubuntu en WSL2 con `nfs-common` (ver 3.2b).
- **Linux** (Ubuntu, Debian, etc.): `sudo apt install nfs-common` (ver 3.2c).
- **macOS**: soporte NFS nativo (ver 3.2d).

### 3.2 Montar desde Windows (principal)

En **Windows 10/11** (PowerShell o CMD como administrador):

1. **Activar Cliente para NFS**:
   - Ejecutar `appwiz.cpl` (Win+R) → **Activar o desactivar características de Windows**
   - O: Configuración → Aplicaciones → Características opcionales → Más características de Windows
   - Buscar **Servicios para NFS** → expandir → marcar **Cliente para NFS** y **Herramientas administrativas**
   - Reiniciar si es necesario.

2. **Montar el recurso** (usa una letra de unidad libre, por ejemplo `N:`):

```cmd
mount localhost:/compartida N:
```

3. **Verificar** (Explorador de archivos o CMD):

```cmd
dir N:
```

Deberías ver `test_contenedor.txt` y `prueba_servidor.txt`. Crear archivo de prueba:

```cmd
echo Prueba NFS desde HOST > N:\test_host.txt
type N:\test_host.txt
```

4. **Desmontar al finalizar**:

```cmd
umount N:
```

!!! note "Windows Home"
    En Windows Home el Cliente NFS no está disponible. Usa **WSL2** (apartado 3.2b) como alternativa.

!!! tip "Montaje automático en Windows (opcional)"
    Para montar NFS al iniciar Windows, crea un archivo `nfs.bat` en la carpeta de inicio:
    - Ejecutar `shell:startup` para abrir la carpeta Inicio
    - Crear `nfs.bat` con contenido: `mount -o anon localhost:/compartida N:`
    - El script se ejecutará al iniciar sesión.

### 3.2b Montar desde WSL2 (alternativa en Windows)

En la distribución Ubuntu de WSL2, en una terminal del host:

```bash
sudo apt install nfs-common -y
sudo mkdir -p /mnt/nfs-host
sudo mount -t nfs localhost:/compartida /mnt/nfs-host
ls -la /mnt/nfs-host
echo "Prueba NFS desde HOST" | sudo tee /mnt/nfs-host/test_host.txt
sudo umount /mnt/nfs-host
```

### 3.2c Montar desde Linux

```bash
sudo apt install nfs-common -y
sudo mkdir -p /mnt/nfs-host
sudo mount -t nfs localhost:/compartida /mnt/nfs-host
ls -la /mnt/nfs-host
echo "Prueba NFS desde HOST" | sudo tee /mnt/nfs-host/test_host.txt
sudo umount /mnt/nfs-host
```

!!! tip "Montaje automático en Linux (opcional)"
    Para montar al arrancar, añade en `/etc/fstab`:
    ```
    localhost:/compartida /mnt/nfs-host nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
    ```
    Las opciones `nofail` y `auto` evitan que el sistema falle si el servidor NFS no está disponible al arrancar.

### 3.2d Montar desde macOS

```bash
sudo mkdir -p /mnt/nfs-host
sudo mount -t nfs -o resvport localhost:/compartida /mnt/nfs-host
ls -la /mnt/nfs-host
echo "Prueba NFS desde HOST" | sudo tee /mnt/nfs-host/test_host.txt
sudo umount /mnt/nfs-host
```

### 3.3 Comprobar en el contenedor servidor

El archivo creado desde el host debe ser visible en el contenedor:

```bash
docker exec -it nfs-server ls -la /compartida
```

Debes ver `test_contenedor.txt`, `test_host.txt` y `prueba_servidor.txt`.

!!! tip "Captura obligatoria"
    Realiza una captura mostrando: montaje en el host, listado de archivos (en Windows: `dir N:`; en Linux/macOS/WSL2: `ls -la /mnt/nfs-host`), creación de `test_host.txt` y verificación con `docker exec nfs-server ls -la /compartida` (todos los archivos visibles).

!!! warning "Si mount falla con «Connection refused»"
    Verifica que los puertos están publicados: `docker port nfs-server`. Debe mostrar 2049 y 111. Reinicia el contenedor si es necesario.

!!! warning "Problemas de acceso en Windows"
    - Permisos de carpetas superiores: configurar a 755 si hay errores.
    - Usar la ruta completa en `/etc/exports` si se usa `~` (virgulilla).

---

## Verificación final

Resumen de comprobaciones obligatorias:

1. **Desde contenedor cliente**: archivo `test_contenedor.txt` creado y visible.
2. **Desde host**: montaje correcto (en Windows: unidad `N:`; en Linux/macOS/WSL2: `/mnt/nfs-host`), archivo `test_host.txt` creado.
3. **En servidor**: todos los archivos visibles con `docker exec nfs-server ls -la /compartida`.

---

## Limpieza

Para eliminar los contenedores y la red al finalizar:

```bash
# Desmontar primero si montaste en el host
# Windows: umount N:
# Linux/macOS/WSL2: sudo umount /mnt/nfs-host

docker stop nfs-server nfs-cliente
docker rm nfs-server nfs-cliente
docker network rm red-nfs
docker volume rm nfs-data
```

---

## Entregables

1. **Documento** con capturas de:

   - Creación del contenedor servidor NFS (comando `docker run` y `docker ps`).
   - Permisos de la carpeta compartida (`ls -la /compartida`).
   - Contenido de `/etc/exports` (salida de `cat /etc/exports`).
   - Salida de `exportfs -v` y `showmount -e`.
   - Montaje y acceso desde el contenedor cliente.
   - **Montaje y acceso desde la máquina host** (obligatorio; Windows, Linux, macOS o WSL2; incluir montaje, listado, creación de `test_host.txt` y verificación en servidor).
   - Archivos visibles en el servidor (`docker exec nfs-server ls -la /compartida`).

2. **Explicación** de las opciones utilizadas en `/etc/exports` y por qué se usa `--privileged` en el contenedor.

## Criterios de evaluación

- Contenedor Ubuntu Server 24.04 creado correctamente con puertos publicados.
- Instalación correcta del servidor NFS dentro del contenedor.
- Configuración correcta de `/etc/exports` (formato sin espacios erróneos).
- Montaje correcto desde el contenedor cliente.
- **Comprobación obligatoria desde la máquina host** (montaje, lectura, escritura).
- Verificación de que los archivos creados desde cliente y host son visibles en el servidor.
- Documentación completa con todas las capturas requeridas.
