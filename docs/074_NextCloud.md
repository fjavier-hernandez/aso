<figure style="float: right;">
    <img src="imagenes/07/074/001.png" width="200"/>
</figure>

# NextCloud

**Nextcloud** es una serie de programas cliente-servidor que permiten la creación de servicios de alojamiento de archivos. Su funcionalidad es similar al software Dropbox, aunque Nextcloud en su totalidad de código abierto. Nextcloud permite a los usuarios crear servidores privados.

## NextCloud con Docker.

Estamos trabajando en una empresa maravillosa y tienen la necesidad de compartir recursos (carpetas, documentos, imágenes...), tanto entre las personas dentro de la empresa como con clientes fuera de ésta.

Para haceros valer dentro de la empresa indicáis que podéis montar un servidor “NextCloud” en unos pocos minutos para solventar dicho problema. La empresa cuenta con un equipo Linux que hace de servidor, decidís hacer uso de docker para levantar el servicio NextCloud de una forma muy rápida y sencilla.

**No obstante debéis cumplir con los siguientes requerimientos:**

- El servicio docker se debe levantar en la red 192.168.20.0/24.
- Debe tener la traducción estática del puerto 80 de la máquina anfitriona al puerto 80 del contenedor.
- Debe tener un volumen asociado llamado “volNextCloud”.

Sube un fichero de prueba, comprueba si está en la carpeta volumen creada. En caso de no estar:

- Prueba a subir un fichero a la plataforma NextCloud. Acto seguido dentro del contenedor busca en que directorio se ha guardado dicho fichero.
- Lee la documentación sobre la imagen NextCloud que hay en Dockerhub [Nextcloud_Docker](https://hub.docker.com/_/nextcloud).


## Actividades de desarrollo UD7_03

705. Realiza las siguientes actividades:

### Investiga:

- Crea el contenedor Nextcloud ¿Al crear el contenedor se ha generado automáticamente algún volumen? ¿Cuál?
- Dentro del sistema anfitrión (lliurex/Windows) ¿Dónde está guardado el fichero subido previamente?
- ¿Este contenedor es persistente? ¿Qué significa que el contenedor es persistente? ¿Cómo lo has comprobado?

### NextCloud – Usuarios.

1. ¿Cómo podemos ver el histórico de acciones de nuestro usuario?

2. ¿Cómo podemos añadir contactos para poder compartir ficheros con ellos?

3. ¿Cómo compartes un fichero con un compañero? Indica los permisos de escritura/lectura que se le pueden poner al fichero compartido.

4. ¿Cómo puedes dejar de compartir un fichero sin eliminarlo?

5. ¿Cómo puedes eliminar un fichero que has subido? Si ese fichero estaba compartido con alguien ¿qué sucede desde el punto de vista de éste último?

6. ¿Cómo se establece una fecha de caducidad de un fichero compartido, par que tras esa fecha, deje de ser accesible automáticamente.

7. ¿Cómo podemos crear un enlace para compartir un recurso con personas que no tengan usuario y sean completamente ajenas a nuestro sistema?

8. ¿Cómo podemos marcar con una etiqueta varios ficheros y luego usar el buscador de etiquetas para que nos muestre todos los recursos con dicha etiqueta?

9. ¿Cómo se puede realizar una búsqueda por nombre de fichero?

10. Muestra como desactivar las notificaciones por correo.
       
11. Una vez desactivadas dichas notificaciones inserta tu correo personal en el perfil para en caso de olvidar la contraseña el equipo pueda enviarte un correo con una nueva.

### NextCloud – Administración.

Describe gráfica y detalladamente como realizar las siguientes acciones:

1. Crea un usuario administrador, que tenga espacio limitado para 300MB.

2. Crea un grupo “Informática” y crea un usuario nuevo con espacio ilimitado que pertenezca a ese grupo. ¿Dicho usuario es el administrador del grupo?

3. Busca como obligar que las contraseñas de los usuarios deban incluir mayúsculas y minúsculas.

4. ¿Cómo activarías el cifrado de la información que se intercambian cliente-servidor? ¿Qué impacto tiene sobre el servicio?

5. ¿Cómo puedes restringir a un usuario para que solo pueda compartir con usuarios de su grupo?

6. Cambia el tema y el fondo de pantalla de tu servidor NextCloud.

7. Describe que elementos podemos monitorizar desde la pantalla de Monitorización e indica para que nos puede servir esta información.