# Práctica: Samba con Docker Compose

## Objetivos

Durante esta práctica aprenderás a desplegar un servidor **Samba** en contenedor usando **Docker Compose**. El objetivo es compartir carpetas entre sistemas heterogéneos (Linux y Windows) de forma sencilla y reproducible.

Al finalizar esta práctica serás capaz de:

- Utilizar **Docker Compose** para definir y ejecutar servicios multi-contenedor.
- Desplegar un contenedor Samba con configuración declarativa en YAML.
- Acceder a carpetas compartidas desde clientes Windows y Linux.
- Documentar el proceso de configuración.



## Requisitos previos

- **Docker** instalado (Docker Engine o Docker Desktop).
- **Docker Compose V2** disponible (incluido en Docker Desktop y en instalaciones recientes de Docker Engine).
- Cliente Windows o Linux para verificar el acceso.

!!! note "Docker Compose V2"
    Desde 2020, Docker Compose V2 se ejecuta como plugin de Docker: `docker compose` (con espacio). El comando antiguo `docker-compose` (con guion) está en desuso. Verifica con `docker compose version`.

## Tareas a realizar

1. Crear la estructura de directorios del proyecto.
2. Crear el archivo `compose.yaml` (o `docker-compose.yml`) con el servicio Samba.
3. Levantar el contenedor con `docker compose up -d`.
4. Acceder a la carpeta compartida desde un cliente Windows y/o Linux.
5. Verificar permisos y funcionamiento.
6. Documentar el proceso con capturas de pantalla.

> **Recursos**

!!! note "Docker Compose y Samba en el vídeo"
    La explicación de **Docker Compose y Samba** en el siguiente vídeo comienza a partir del **minuto 8:05**.

<figure style="width: 100%; margin: 0; padding: 0;">
  <div style="position: relative; width: 100%; padding-bottom: 56.25%; height: 0; overflow: hidden;">
    <iframe src="https://www.youtube.com/embed/KatK-fdktk4?start=485" title="Samba con Docker Compose" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></iframe>
  </div>
  <figcaption>Video tutorial: Samba con Docker Compose (Docker Compose Samba a partir del minuto 8:05)</figcaption>
</figure>

## Paso 1: Preparar el entorno

Crea el directorio del proyecto y la carpeta que se compartirá:

```bash
mkdir -p $HOME/docker/samba/compartido
cd $HOME/docker/samba
```

Asigna permisos de escritura a la carpeta compartida:

```bash
chmod 777 -R $HOME/docker/samba/compartido
```

!!! tip "Producción"
    En un entorno de producción, usa permisos más restrictivos y usuarios/grupos específicos en lugar de `chmod 777`.

## Paso 2: Crear el archivo compose.yaml

Crea el archivo de configuración. Puedes usar `compose.yaml` (recomendado) o `docker-compose.yml`:

```yaml
services:
  samba:
    container_name: samba
    image: dperson/samba:latest
    environment:
      TZ: 'Europe/Madrid'
    ports:
      - "137:137/udp"
      - "138:138/udp"
      - "139:139/tcp"
      - "445:445/tcp"
    read_only: true
    tmpfs:
      - /tmp
    restart: unless-stopped
    stdin_open: true
    tty: true
    volumes:
      - $HOME/docker/samba/compartido:/sordata:z
    command: '-s "Compartida;/sordata" -n'
```

!!! tip "Parámetros principales"
    | Parámetro | Función |
    |-----------|---------|
    | `volumes` | Monta la carpeta local en `/sordata` dentro del contenedor. La opción `:z` permite 
    compartir con SELinux. |
    | `137-138` | Puertos NetBIOS (UDP/TCP). |
    | `139-445` | Puertos SMB. |
    | `restart: unless-stopped` | Reinicia el contenedor automáticamente salvo si se detuvo 
    manualmente. |
    | `command` | `-s "NombreCompartido;ruta"` define el recurso compartido. `-n` habilita NetBIOS.

!!! tip "Contenido avanzado"
    Si quieres profundizar en **cada parámetro** del `compose.yaml` (volúmenes, puertos NetBIOS/SMB, SELinux, `command`, `read_only`, etc.) y en **cómo configurar permisos de escritura** al acceder desde el host o desde clientes Windows/Linux, consulta el documento: **[Samba con Docker Compose — Contenido avanzado](SambaDockerCompose_Detalle.md)**.

## Paso 3: Levantar el contenedor

Ejecuta Docker Compose (comando actual, con espacio):

```bash
docker compose up -d
```

!!! warning "Comando correcto"
    Usa `docker compose` (con espacio), **no** `docker-compose` (con guion). El comando con guion corresponde a la versión antigua.

Verifica que el contenedor está en ejecución:

```bash
docker compose ps
docker ps
```

## Paso 4: Acceder desde el cliente

### Desde Windows

1. Abre el **Explorador de archivos**.
2. En la barra de direcciones escribe: `\\IP_SERVIDOR\Compartida`
3. Sustituye `IP_SERVIDOR` por la IP del equipo donde corre Docker (ej: `192.168.1.100`).
4. Si se solicita, usa credenciales genéricas (la imagen `dperson/samba` permite acceso sin autenticación por defecto en modo simple).

### Desde Linux

```bash
# Instalar cliente SMB si no está instalado
sudo apt install cifs-utils

# Montar la carpeta compartida
sudo mkdir -p /mnt/samba
sudo mount -t cifs //IP_SERVIDOR/Compartida /mnt/samba -o guest
```

O accede desde el gestor de archivos: **Conectar al servidor** → `smb://IP_SERVIDOR/Compartida`

## Paso 5: Verificación

1. Crea un archivo de texto de prueba en la carpeta compartida desde el servidor (en `$HOME/docker/samba/compartido`).
2. Comprueba que el archivo es visible desde el cliente Windows o Linux.
3. Crea un archivo desde el cliente y verifica que aparece en el servidor.

## Paso 6: Gestión del contenedor

```bash
# Detener el contenedor
docker compose down

# Ver logs
docker compose logs -f samba

# Reiniciar
docker compose restart
```

!!! note "Persistencia de datos"
    Los archivos en `$HOME/docker/samba/compartido` se conservan aunque se elimine el contenedor, ya que están en un volumen montado del host.

## Entregables

1. **Documento Markdown** con:

   - Capturas del archivo `compose.yaml` y de la salida de `docker compose ps`.
   - Capturas del acceso desde Windows y/o Linux.
   - Explicación de los parámetros utilizados.
   - Problemas encontrados y soluciones aplicadas.

2. **Archivo** `compose.yaml` o `docker-compose.yml` utilizado.

## Criterios de evaluación

- Creación correcta de la estructura de directorios.
- Archivo compose.yaml válido y funcional.
- Contenedor Samba en ejecución.
- Acceso correcto desde al menos un cliente (Windows o Linux).
- Documentación completa con evidencias.
