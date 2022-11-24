

En Debian el nivel de inicio predeterminado es el nivel 2 (id=2). Debian utiliza los siguientes niveles de ejecución:

- 0 (apagar el sistema)
- 1 (modo monousuario)
- 2 al 5 (modos multiusuario)
- 6 (reiniciar el sistema)

!!! Note
    El archivo de configuración de más alto nivel para Init es `/etc/inittab`.Durante el arranque del sistema, se verifica si existe un nivel de ejecución predeterminado en el archivo `/etc/inittab`, si no, se debe introducir por medio de la consola del sistema. Después se procede a ejecutar todos los scripts relativos al nivel de ejecución especificado.

Después de que se han dado lugar todos los procesos especificados, Init se aletarga, y espera a que uno de estos tres eventos sucedan:
- que procesos comenzados finalicen o mueran;
- un fallo de la señal de potencia (energía);
- o una petición a través de `/sbin/telinit` para cambiar el nivel de ejecución.

ARRANQUE WINDOWS

- Los datos de configuración de arranque (**BCD**) sustituyen a la anterior (boot.ini). En el almacén **BCD** el gestor de arranque se presenta como objeto de programa (**GUID**) en lugar de elementos de texto. 
- Con la herramienta Bcdedit.exe podemos utilizar los comandos básicos para controlar todos los aspectos del proceso de arranque, aunque cada objeto se presenta con un **GUID**, algunos objetos tienen nombres de alias para uso común, como bootmgr (referido al gestor de arranque) y DEFAULT (gestor de arranque por defecto).
- Podemos modificar la configuración de inicio con **WMI** (Windows Management Instrumentatión). Podemos utilizar `MSconfig.exe` para proporcionar una interfaz gráfica para visualizar y modificar un subconjunto de los ajustes de configuración de inicio.

Actividades:

310. Modifica el fichero /etc/inittab para que...
  
    1. De forma predeterminada se establezca el nivel de ejecución 5.
    2. Al pulsar la combinación de teclas ctrl+alt+supr el sistema realice las siguientes operaciones:

      - se apague si el nivel de ejecución es el 2.
	    - se reinicie si el nivel de ejecución es el 3.
	    - escriba “Je-je-je, no sirve de nada esa combinación de teclas” si el nivel de ejecución es el 4.
	    - no haga nada si el nivel de ejecución es el 5.

Pista:

<figure>
  <img src="./imagenes/03/033/007.png" width="650"/>
  <figcaption>Fases Arranque Linux</figcaption>
</figure>

311. Realiza un breve informe con los pasos más importantes de el Ejemplo de modificación de **bcdedit** -> [Enlace:Ejemplos de parametros usados en el editor BCDEdit.exe](https://ikastaroak.birt.eus/edu/argitalpen/backupa/20200331/1920k/es/ASIR/ISO/ISO02/es_ASIR_ISO02_Contenidos/3.1.EditorBCDedit.pdf)