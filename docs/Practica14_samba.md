# Instalación y preparación Servidor Samba

## Instalación

``` yaml
sudo apt install samba
```

## Configuración

1. Editamos el fichero de configuración: `/etc/samba/smb.conf`

2. Al final del archivo de configuración añadiremos una nueva entrada con el **directorio a compartir**:

``` yaml
[ejercicio1]
    comment = Prueba Ejercicio 1
    path = /srv/samba/ejercicio1
    browsable = yes
    guest ok = yes
    read only = yes
    create mask = 0777
```

3. Creamos el directorio que íbamos a compartir y cambiamos los permisos para que no de conflicto.

``` yaml
sudo mkdir –p /srv/samba/ejercicio1
sudo chmod 755 /srv/samba/ejercicio1
```

4. Siempre que modifiquemos el fichero de configuración debemos reiniciar el servicio:

``` yaml
sudo systemctl restart smbd
```

## Parámetros Básicos:

- **[X]:** Nombre del recurso a compartir, normalmente un directorio.
- **Comment:** Comentario que describe el directorio que se está compartiendo.
- **Path:** Es la carpeta que se quiere compartir. Puede ser cualquier carpeta del servidor, no obstante, por estándar las carpetas compartidas de un servidor suelen encontrarse dentro del directorio /srv.
- **Browsable:** Permite navegar por el directorio usando el navegador de directorios.
- **Guest ok:** No es necesario introducir contraseña (modo invitado).
- **Read only:** Indica si los permisos de un cliente son de lectura (yes) o de escritura/lectura (no).
- **Create Mask:** Indica los permisos de los **ficheros creados por los clientes**. Por defecto 0744 (todos los permisos para usuario propietario y solo permiso de lectura para grupo y otros usuarios).
- **Directory Mask**: Indica los permisos de los **directorios** creados. Por defecto 0755 (todos los permisos para usuario propietario y solo permiso de lectura/ejecución para grupo y otros usuarios).

!!! tip "**A tener en cuenta**"
    - El primer bit del “**umask**” se usa para opciones especiales (stickybit, SGID o SUID), como no vamos a usarlo, debe estar siempre a 0.
    - En el fichero de configuración de samba tanto los `#` como el `;` indicando comentarios.
    - Es importante comprender que tenemos dos niveles de seguridad. El establecido por el fichero de configuración samba y los propios permisos del directorio compartido.

## Acceso desde Windows:

1. Abrimos un explorador de directorios.
2. Seleccionamos Red (Network)
3. Puede que tengamos que habilitar el descubrimiento de redes:

<figure>
  <img src="./imagenes/07/072/004.png" width="650"/>
</figure>

Como alternativa, en caso de no descubrir el equipo podemos abrir un explorador de directorio y colocar en la barra de direcciones `\\IP_Servidor`

<figure>
  <img src="./imagenes/07/072/005.png" width="650"/>
</figure>

**Actividades:**

Razona todas las respuestas, en caso de que la respuesta sea debido a unos permisos indica que permisos tiene y donde han sido determinados.

701. Sigue todos los pasos del manual (apartado anterior) para conseguir compartir ficheros. Adjunta una captura de la sección del fichero de configuración de samba donde se muestre la configuración del recurso compartido.
702. **Desde el servidor**, crea un fichero hola.txt en la carpeta /srv/samba/ejercicio1.
703. **Desde el cliente windows** accede al servidor mediante un explorador de directorios e intenta abrir el documento ¿Existe algún problema para ello? Razona tu respuesta.
704. Seguidamente modifica el fichero e intenta guardarlo. ¿Qué ocurre? ¿Por qué?
705. Ahora, desde el cliente Windows, intenta crear un fichero. ¿Te deja? ¿Puedes leer y escribir en él? ¿Por qué?
706. **Desde el servidor,** modifica los permisos de /srv/samba/ejercicio1/hola.txt para que tenga los siguientes permisos rwxr—rwx, ahora desde el cliente Windows prueba a modificar el contenido de dicho fichero. ¿Qué ocurre y por qué? Si no te deja escribir y guardar los cambios, indica que deberías cambiar para que puedas hacerlo.
707. Crea una carpeta en el servidor /srv/samba/ejercicio2. Comparte dicha carpeta, añadiendo una nueva entrada en el fichero de configuración de samba. La carpeta debe ser navegable, se debe poder acceder sin credenciales, debe tener permisos  de lectura/escritura y además los ficheros creados por los clientes podrán ser modificados, leídos y ejecutados por cualquiera. Por otro lado, los directorios creados por los clientes solo podrán ser modificados por el usuario propietario, mientras que el resto de usuarios/grupos no tendrán ningún permiso. Muestra la configuración realizada.
708. Desde un cliente Windows (como usuario propietario) intenta acceder a la carpeta ejercicio2 y crear un documento llamado “miTesoro.txt”. Acto seguido, vuelve al servidor e intenta modificar el fichero (**SIN SER SUDO**) ¿Existe algún problema? ¿Por qué?
709. Ahora desde el cliente (Windows) crea un directorio llamado “Mairon”. Vuelve al servidor e intenta crear un fichero “Sauron.txt” dentro de Mairon (**SIN SER SUDO**). ¿Qué ocurre? ¿Qué permisos tiene la carpeta “Mairon”?.
710. Busca en Internet que significa la etiqueta [global] al comienzo del fichero de configuración de samba /etc/samba/smb.conf