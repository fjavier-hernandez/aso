# Administración de Sistemas Operativos

Aquí puedes encontrar los apuntes del módulo de ***Administración de Sistemas Operativos***, que se imparte en el segundo curso del ciclo formativo de grado superior de Administración de Sistemas Informáticos en Red.

* La duración del módulo es de **120 horas lectivas**, a razón de **6 horas semanales**, y se desarrolla a lo largo de los **dos primeros trimestres del curso**.
* Se ha planificado basándose en **3 sesiones lectivas por semana**, con **2 horas de duración cada una de ellas**.

## ¿Qué voy a aprender?

* Administrar sistemas operativos de servidor, instalando y configurando el software, en condiciones de calidad para asegurar el funcionamiento del sistema.
* Administrar servicios de recursos compartidos (acceso a directorios, impresión, accesos remotos, entre otros) instalando y configurando el software, en condiciones de calidad.
* Administrar usuarios de acuerdo a las especificaciones de explotación para garantizar los accesos y la disponibilidad de los recursos del sistema.
* Gestionar los recursos de diferentes sistemas operativos (programando y verificando su cumplimiento).

## Resultados de aprendizaje

Un *Resultado de Aprendizaje* **"es una declaración de lo que el estudiante se espera que conozca, comprenda y sea capaz de hacer al finalizar un periodo de aprendizaje".** Los resultados de aprendizaje de ASO vienen definidos en el [RD 1629/2009.](https://www.boe.es/eli/es/rd/2009/10/30/1629)

Los Resultados de Aprendizaje de ASO son:

1. Administra el servicio de directorio interpretando especificaciones e integrándolo en una red.
2. Administra procesos del sistema describiéndolos y aplicando criterios de seguridad y eficiencia.
3. Gestiona la automatización de tareas del sistema, aplicando criterios de eficiencia y utilizando comandos y herramientas gráficas.
4. Administra de forma remota el sistema operativo en red valorando su importancia y aplicando criterios de seguridad.
5. Administra servidores de impresión describiendo sus funciones e integrándolos en una red.
6. Integra sistemas operativos libres y propietarios, justificando y garantizando su interoperabilidad.
7. Utiliza lenguajes de guiones en sistemas operativos, describiendo su aplicación y administrando servicios del sistema operativo.

## Unidades didácticas / Temporalización

A continuación se muestran las unidades didácticas y una estimación temporal de cada una de ellas, repartidas en cada evaluación con una duración aproximada de **30 sesiones por evaluación**.

### Primera evaluación

1. **ShellScripting. (6 sesiones, 12 horas)**
    * ShellScripting, creación scripts, variables, parámetros, operadores.
    * ShellScripting, Re-direcciones, tuberías.
    * Control de flujo en Shell, vectores.
2. **PowerShell. (6 sesiones, 12 horas)**
    * PowerShell, creación scripts, variables, parámetros, operadores.
    * PowerShell, Control de flujo, y vectores.
    <!-- * Docker. -->
3. **Administración de Procesos del Sistema. (6 sesiones, 12 horas)**
    * Procesos. Tipos. Estados. Estructura. Transiciones, Hilos.
    * Planificador, Tipos de algoritmos de planificación, Sincronización e interrupciones entre procesos.
    * Gestión de procesos, demonios/servicios con Shell y Powershell.
4. **Servicios de Directorio Libres: LDAP. (6 sesiones, 12 horas)**
    * Servicios Directorio, LDAP, Autentificación usuarios (PAM, NSS).
    * LDAP, modelo información, Esquema.
    * LDAP, Configuración, herramientas de gestión.
5. **Servicios de Directorio Propietarios: Active Directory (6 sesiones, 12 horas).**
    * Active Directory, configuración básica Windows Server.
    * Active Directory, Instalación AD, Creación estructura empresa.
    * AD, Permisos, directivas de grupo, perfiles y relaciones de confianza.
### Segunda evaluación

6. **Integración de Sistemas Libre: NFS (6 sesiones, 12 horas).**
    * Escenarios heterogéneos, Protocolos para redes heterogéneas, servicios de recursos compartidos.
    * NFS, Instalación, Permisos, Montaje automático de un cliente NFS, configuración de ficheros.
    * NextCloud, Instalación, configuración de ficheros y permisos de usuario.
7. **Integración de Sistemas Propietarios: SAMBA (6 sesiones, 12 horas).**
    * SAMBA, fichero configuración, Creación directorio compartido, Integración de permisos.
    * SAMBA, Administración de servicios con RSAT, perfiles de usuario y carpetas personales, cuotas.
8. **Información del sistema operativo (6 sesiones, 12 horas).**
    * Estructura directorios. Búsqueda de información del sistema. Rendimiento. Estadísticas.
    * Planificación de Tareas, Programador de tareas, `crontab`.
    * Servicio Monitorización, Nagios, PRTG, OpenNMS.
9. **Servicios de acceso y administración remota (6 sesiones, 12 horas).** 
    * Acceso remoto en modo texto `SSH`. Tunelización.
    * Escritorio Remoto:  RDP y xRDP. Acceso remoto de equipos en el AD con PWSH.
    * Herramientas gráficas externas, TeamViewer, AnyDesk y Apache Guacamole.
10. **Administración de Servidores de Impresión (6 sesiones, 12 horas).**
    * Sistemas de Impresión, Puertos y protocolos de impresión.
    * Servidor de impresión en GNU/Linux, `CUPS`. Órdenes para la gestión de impresoras y trabajos.
    * Administración de los Servicios de Impresión en Windows Server.

## Evaluación
### Instrumentos de calificación

1. **Instrumento de calificación 1 (IC1):**: *escala de valores* comprendidas entre 0 y 3 puntos calificados de la siguiente forma:
    * **0**: No entregada.
    * **1**: Entregada pero solución errónea o incompleta.
    * **2**: Entregada y solución aceptable, aunque tiene algún apartado incompleto.
    * **3**: Entregada y solución correcta.

2. **Instrumento de calificación 2 (IC2):** *escala de valores* comprendidas entre 0 y 7 puntos calificados de la siguiente forma:
    * **0**: No entregada
    * **1-3**: Entregada pero solución errónea o incompleta
    * **3-6**: Entregada y solución aceptable, aunque tiene algún apartado incompleto.
    * **7**: Entregada y solución correcta.
### Instrumentos de Evaluación
La nota de cada **Resultado de Aprendizaje** se calcula mediante la media ponderada de los puntos obtenidos, de los siguientes instrumentos de evaluación.

1. **Instrumento de Evaluación 1 (IE1). Trabajo en Clase/Actividades.**
    1. Se evalúan todas las actividades realizadas en clase y en casa.
    2. Las actividades se evalúan mediante tareas en el `moodle` aplicando el **IC1**.
    
2. **Instrumentos de Evaluación 2 (IE2). Pruebas de Auditoría.**
    1. Cuestionario multi-opción (test) de 20 preguntas sobre la teoría de la unidad.
    2. Ejercicios prácticos sobre las actividades realizadas de la unidad.

!!! not "**Nota**:"    
    Esta prueba se califica entre 0 y 30 puntos siguiendo las siguientes premisas:
- **0-10** puntos. Donde Cada dos contestaciones incorrectas contestadas resta una bien.
- **0-6** puntos: dos ejercicios de *nivel medio-bajo*, 3 puntos cada uno de ellos aplicando **IC1**.
- **0-14** puntos: dos ejercicios de *nivel medio-alto* aplicando **IC2**

