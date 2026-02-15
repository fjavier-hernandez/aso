# Samba con Docker Compose — Contenido avanzado

Este documento amplía la [Práctica: Samba con Docker Compose](PracticaDockerComposeSamba.md) con una explicación detallada de los parámetros del `compose.yaml` y cómo configurar permisos de escritura al acceder desde el host.

---

## Explicación detallada de parámetros y conceptos

- **`volumes`**  
  Define qué carpeta del **host** se monta dentro del contenedor y en qué ruta.  
  Sintaxis: `ruta_en_host:ruta_en_contenedor[:opciones]`.  
  En el ejemplo, `$HOME/docker/samba/compartido` (tu carpeta local) se monta en `/sordata` dentro del contenedor. Todo lo que Samba escribe en `/sordata` se guarda realmente en tu disco en `compartido`.  
  - **`:z`** (o `:Z`): etiqueta SELinux para que el contenedor pueda acceder al volumen. Usa `:z` si el contenido puede ser compartido entre contenedores; `:Z` si es exclusivo de uno. En sistemas sin SELinux (p. ej. muchas instalaciones por defecto) no es obligatorio pero no perjudica.

!!! note "¿Qué es SELinux?"
    **SELinux (Security-Enhanced Linux)** es un módulo de seguridad del núcleo de Linux que implementa un sistema de control de acceso obligatorio (**MAC – Mandatory Access Control**).  
    Su objetivo principal es limitar lo que los procesos y usuarios pueden hacer, incluso si son root, para reforzar la seguridad del sistema frente a accesos indebidos y ataques.  
    Esto puede afectar el acceso a volúmenes montados por contenedores, por lo que las opciones `:z` o `:Z` en los volúmenes ayudan a que el contenedor Samba pueda acceder correctamente a los datos bajo políticas SELinux estrictas.

- **Puertos publicados (`ports`)**  
  Los puertos del contenedor se exponen al host para que los clientes (Windows, Linux) puedan conectarse al Samba del contenedor.  
  - **137/udp, 138/udp**: **NetBIOS Name Service** y **NetBIOS Datagram**. Sirven para que los clientes encuentren el servidor por nombre (p. ej. en "Red" de Windows) sin tener que usar solo la IP.  
  - **139/tcp**: **NetBIOS Session Service**, usado por el protocolo SMB antiguo.  
  - **445/tcp**: **SMB directo sobre TCP** (sin NetBIOS). Es el que suelen usar las versiones modernas de SMB.  
  Sin publicar estos puertos, el acceso desde otro equipo a la carpeta compartida no funcionaría.

- **`restart: unless-stopped`**  
  Política de reinicio del contenedor: Docker lo reinicia si se cae o si el host se reinicia, **salvo** que tú lo hayas parado con `docker compose stop` o `docker stop`. Así el recurso compartido queda disponible de forma continua.

- **`command`**  
  Comando con el que arranca el proceso Samba dentro del contenedor (la imagen `dperson/samba` lo interpreta).  
  - **`-s "Compartida;/sordata"`**: define un recurso compartido; el nombre que verán los clientes es `Compartida` y la ruta dentro del contenedor es `/sordata`. Puedes añadir más recursos con más `-s "Nombre;ruta"`.  
  - **`-n`**: activa el servidor **NetBIOS** (necesario para que el servidor aparezca por nombre en la red y para que funcionen los puertos 137–139).

- **`read_only: true`**  
  Deja el **sistema de archivos raíz** del contenedor en solo lectura (más seguro). Los **volúmenes montados** (como `/sordata`) siguen siendo escribibles si no se indica lo contrario, así que la carpeta compartida puede seguir teniendo lectura y escritura.

- **`tmpfs: - /tmp`**  
  Monta un sistema de archivos temporal en RAM en `/tmp`. Samba puede usar `/tmp` para archivos temporales; al ser en memoria, no se persisten y se vacían al reiniciar el contenedor.

- **`stdin_open: true` y `tty: true`**  
  Mantienen abiertos la entrada estándar y una terminal, lo que facilita que el contenedor no se cierre y que puedas usar `docker attach` si la imagen lo soporta.

---

## Cómo tener permisos de escritura al acceder desde el host

Si al acceder desde Windows o Linux (o desde el propio host) la carpeta compartida es de solo lectura o no puedes crear/borrar archivos, suele deberse a **permisos en la carpeta del host** o a **opciones del recurso compartido**.

1. **Permisos en la carpeta del host**  
   La ruta que montas (p. ej. `$HOME/docker/samba/compartido`) debe ser escribible por el usuario con el que corre Samba dentro del contenedor (en esta imagen suele ser `root`). Para pruebas puedes usar:

   ```bash
   chmod 777 $HOME/docker/samba/compartido
   ```

   En producción es mejor usar un grupo dedicado y `chown`/`chmod` adecuados en lugar de `777`.

2. **Asegurar que el recurso sea de lectura y escritura en Samba**  
   La imagen `dperson/samba` en modo simple suele dar escritura por defecto. Si usas opciones avanzadas o otra imagen, revisa que el recurso no esté definido como solo lectura.

3. **Compose con recurso compartido explícito de lectura/escritura**  
   La imagen `dperson/samba` permite definir en `-s` si el recurso es solo lectura. La sintaxis es:

   `-s "nombre;ruta;browse;readonly;guest;users;admins;writelist;comment"`

   Para **lectura y escritura**, pon **`readonly` en `no`**. Ejemplo con volumen en modo lectura/escritura explícito (`:rw,z`):

   ```yaml
   volumes:
     - $HOME/docker/samba/compartido:/sordata:rw,z
   command: '-s "Compartida;/sordata;yes;no" -n'
   ```

   Aquí `yes` es *browse* (visible en la red) y `no` es *readonly* (recurso escribible). El resto de parámetros quedan por defecto.

4. **Comprobar desde el host**  
   Tras `docker compose up -d`, verifica que puedes escribir en la misma carpeta desde el host:

   ```bash
   touch $HOME/docker/samba/compartido/prueba_desde_host.txt
   ls -la $HOME/docker/samba/compartido
   ```

   Si eso funciona pero desde el cliente Samba (Windows/Linux) no, el problema está en la configuración o permisos de Samba; si no puedes escribir ni desde el host, el fallo está en los permisos del directorio (`chmod`/`chown`).
