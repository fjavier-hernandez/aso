# Gestión usuarios LDAP con GUI

El acceso gráfico a LDAP se realiza mediante el cliente **Apache Directory Studio**, a continuación se muestra su instalación y configuración en la máquina **cliente**

![](./imagenes/ads/461.png)

## Instalación Apache Directory Studio

1. En primer lugar se necesita instalar la última versión de java:

``` bash
sudo apt-get update
```

- Se comprueba si Java ya está instalado:

``` bash
java -version
```

- Si Java no está instalado actualmente, obtendrá la siguiente salida:

![](./imagenes/ads/462.png)

- Ejecute el siguiente comando para instalar el **JRE** desde **OpenJDK 11**:

``` bash
sudo apt-get install default-jre
```

![](./imagenes/ads/463.png)

- El JRE te permitirá ejecutar casi todo el software Java. Verifica la instalación con:

``` bash
java -version
```

![](./imagenes/ads/464.png)

- Es posible que necesite el JDK además del JRE para compilar y ejecutar algún software específico basado en Java. Para instalar el JDK, ejecute el siguiente comando, que también instalará el JRE:

``` bash
sudo apt install default-jdk
```

![](./imagenes/ads/465.png)

- Verifique que el JDK esté instalado comprobando la versión de javac, el compilador de Java:

``` bash
javac -version
```

![](./imagenes/ads/466.png)

2. Seguidamente se debe instalar la herramienta de administración cliente:

- En primer lugar se descarga el archivo comprimido con el ejecutable [FUENTE](https://directory.apache.org/studio/download/download-linux.html):

``` bash
sudo wget https://dlcdn.apache.org/directory/studio/2.0.0.v20210717-M17/ApacheDirectoryStudio-2.0.0.v20210717-M17-linux.gtk.x86_64.tar.gz
```
![](./imagenes/ads/467.png)

- se descomprime el archivo, donde **X** e **Y** son las versiones de Apache Directory Studio:

``` bash
tar xvzf ApacheDirectoryStudio-XXX.yyy.tar.gz
```

![](./imagenes/ads/468.png)

Cuando esta comprimido se ejecutaría el archivo, por terminal o por GUI.

``` bash
./ApacheDirectoryStudio
```

![](./imagenes/ads/469.png)

## Acceso  al LDAPserver

1. Se realiza la conexión con el servidor añadiendo una nueva conexión:

![](./imagenes/ads/474.png)

![](./imagenes/ads/470.png)

- Se añade los parámetros de red del servidor.

![](./imagenes/ads/471.png)

- Se configura las credenciales del usuario de administrador y se confirma conexión.

![](./imagenes/ads/472.png)

- Se puede descargar la base del servidor, en la siguiente pantalla.

![](./imagenes/ads/473.png)


## Crear usuario y una organización LDAP con Apache Directory Studio

Como ejemplo, se muestra cómo crear un usuario LDAP y una organización usando Apache Directory Studio.

### Crear organización

1. Para crear un grupo dentro de otro Haga doble clic en el dominio. Luego seleccione nueva entrada.

![](./imagenes/ads/475.png)

2. A continuación, selecciones la opción "**create entry from scratch**" para selecciona una ObectClass predefinida de LDAP, en este caso **organizationalUnit**.

![](./imagenes/ads/476.png)

![](./imagenes/ads/477.png)

3. Ingrese el RDN deseado de la organización en este caso **aso**, se finaliza y se comprueba la nueva entrada.

![](./imagenes/ads/478.png)

![](./imagenes/ads/479.png)

### Crear usuario

Mismo procedimiento pero a partir de la **ou**.

![](./imagenes/ads/480.png)

![](./imagenes/ads/481.png)

## Generar nuevos atributos y cambios

- Se pueden crear nuevos atributos dentro de una entrada:

![](./imagenes/ads/484.png)

![](./imagenes/ads/485.png)

![](./imagenes/ads/486.png)

![](./imagenes/ads/487.png)

- Y modificar directamente los valores de los atributos:

![](./imagenes/ads/482.png)

![](./imagenes/ads/483.png)
## Actividades

202. En este ejercicio se deben utilizar **Apache Directory Studio** para realizar los siguiente apartados:
    1. Añade una nueva organización a la estructura de directorio creada en la práctica del apartado 4.4.
    2. Crea un segundo usuario, dentro de **usuarios**
    3. Crea una contraseña para el usuario.
    4. Modifica el uidNumber creado de inicio.
    5. Crea un nuevo atributo dentro de ese usuario.
    6. Elimina el segundo usuario creado.
