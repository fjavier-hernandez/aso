Ahora vamos a configurar un equipo cliente con el fin de poder iniciar sesión en él a partir de un usuario creado en el directorio LDAP.

Comenzamos instalando la paquetería necesaria:

```
sudo apt install libnss-ldap libpam-ldap ldap-utils
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/19.png)

Automáticamente se nos abrirá el asistente de configuración donde indicaremos los datos de nuestro servidor donde se encuentra instalado el directorio LDAP.

En primer lugar, nos solicita la dirección URI del servidor. Sustituiremos la cadena por la que se muestra en la imagen.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/20.png)

A continuación escribiremos el nombre distinguido único (DN) de nuestro directorio LDAP.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/21.png)

En el siguiente paso nos dan a elegir la versión del protocolo LDAP que vamos utilizar. Elegimos la versión más actual, en este caso la 3.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/22.png)

Ahora indicaremos si las aplicaciones que utilicen PAM deberán comportarse del mismo modo que cuando cambiamos contraseñas locales. Esto hará que las contraseñas se almacenen en un fichero independiente que sólo podrá ser leído por root. Elegimos que SI.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/23.png)

Luego nos pregunta si queremos que sea necesario identificarse para realizar consultas en la base de datos del directorio LDAP. Elegimos que NO.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/24.png)

En el siguiente paso indicaremos el nombre de la cuenta LDAP con privilegios para realizar cambios en las contraseñas. Dicha cuenta será la del administrador de nuestro directorio LDAP, indicaremos su DN completo.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/25.png)

Y por último, nos solicita la contraseña de la cuenta que hemos indicado justo antes (la que indicamos para el administrador en el asistente de configuración de OpenLDAP). Habrá que escribirla por duplicado.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/26.png)

Una vez finalizado el asistente de configuración, vamos a realizar modificaciones en el fichero /etc/nsswitch.conf. Indicaremos al sistema que realice búsquedas sobre usuarios en el directorio LDAP además de en el propio sistema.

```
sudo nano /etc/nsswitch.conf
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/27.png)

Ahora tenemos que realizar modificaciones en el fichero /etc/pam.d/common-password. En él eliminaremos la cadena use_authtok de la línea 26. Quitando dicha cadena, el sistema nos permitirá usar varios métodos de autenticación.

```
sudo nano /etc/pam.d/common-password
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/28.png)

Por último, modificaremos el fichero /etc/pam.d/common-session. Añadiremos una línea al final del fichero para indicar que cuando un usuario de LDAP inicie sesión en el sistema, se cree su directorio Home en el equipo.

```
sudo nano /etc/pam.d/common-session

session optional      pam_mkhomedir.so skel=/etc/skel umask=077
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/29.png)

Una vez realizados todos los cambios en los ficheros anteriores, podemos comprobar la interacción entre equipo cliente y servidor de directorio LDAP. Para ello podemos lanzar una búsqueda a través de la terminal y veremos si nos responde.

```
ldapsearch -x -H ldap://192.168.1.90 -b "dc=pandora,dc=ldap"
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/30.png)

Como podemos ver, el servidor LDAP nos responde mostrándonos el resultado a la búsqueda que hemos realizado, que en este caso se trata de todas las entradas que se encuentran definidas en él. 

> En el punto donde nos encontramos, ya tenemos nuestro directorio LDAP configurado, poblado y funcionando en nuestro servidor. Y nuestro equipo cliente configurado para poder conectar con el servicio de directorio y poder iniciar sesión en el sistema con usuarios registrados en LDAP (Ojo! De momento, solo a través de consola.)

Vamos a hacer una prueba de inicio de sesión por consola y veremos como también se crea el directorio Home del usuario registrado en LDAP.

Antes que nada, visualizamos el contenido del directorio /home y vemos que ahora mismo solo existe el de usuario.

```
ll /home
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/31.png)

Ahora abrimos un nuevo entorno de terminal tecleando Ctrl + Alt + F5, e iniciaremos sesión con el usuario mordecai que hemos registrado anteriormente en LDAP. Como podremos ver, al iniciar sesión se creara en el equipo cliente el directorio /home/mordecai.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/32.png)

Podemos lanzar algunos comandos más para verificar la identidad del usuario y ver que pertenece al grupo devops tal y como creamos las entradas en nuestro directorio LDAP. Además también verificaremos que el directorio /home/mordecai pertenece y se ha creado con los permisos necesarios para dicho usuario.

```
id
pwd
ll /home
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/33.png)

Como hemos mencionado antes, hasta ahora solo era posible iniciar sesión en el equipo cliente por terminal. Ahora vamos a realizar lo necesario para que sea posible, también, iniciar sesión con usuarios de LDAP en modo gráfico. Para ello comenzamos instalando el paquete nslcd.

```
sudo apt install nslcd
```

![](https://blog.sysdual.com/wp-content/uploads/2020/12/34.png)

Al instalar el paquete, se abrirá un asistente de configuración automáticamente donde tendremos que indicar nuevamente la URI de nuestro servidor LDAP y su DN (Distinguished Name). Probablemente los datos vengan ya indicados por lo que solo pulsaremos Aceptar en ambas ventanas sin necesidad de modificar nada.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/35.png)

![](https://blog.sysdual.com/wp-content/uploads/2020/12/36.png)

Al terminal de instalar el paquete, debemos reiniciar nuestro sistema para un correcto funcionamiento. Reiniciamos el equipo cliente.

Y tras reiniciar ya podremos iniciar sesión con nuestro usuario Mordecai, directamente desde la pantalla de Login del sistema.

![](https://blog.juananpc.es/wp-content/uploads/2021/07/40.png)

Tras iniciar sesión, se creará un perfil para el usuario y ya podrá usar el sistema de forma completamente gráfica además de por terminal. Podemos verificar la identidad del usuario desde consola y veremos que sigue siendo tal cual lo configuramos en nuestro directorio LDAP.

![](https://blog.sysdual.com/wp-content/uploads/2020/12/39-1024x768.png)