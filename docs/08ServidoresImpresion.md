---
title: Administración de Servidores de Impresión
description: Servidor de impresión en Windows Server en AWS, rol Print and Document Services, gestión de colas, permisos y actividad práctica.
subtitle: Administración de Servidores de Impresión
---

# Administración de Servidores de Impresión en Windows Server (AWS)

En esta unidad se trabaja la **administración del servidor de impresión** en **Windows Server** desplegado en **AWS**: instalación del rol **Print and Document Services**, configuración de impresoras por red (TCP/IP), drivers, compartición y permisos, en un entorno integrado con Active Directory.

## Propuesta didáctica

En esta unidad se trabaja la administración de servicios de impresión en red:

> Gestionar el **servidor de impresión** en Windows Server: instalación del rol, agregar impresoras por TCP/IP, configurar permisos y compartición para usuarios del dominio en un escenario AWS (EC2, dominio Active Directory).

### Criterios de evaluación

- Conocer la función del servidor de impresión en una red corporativa.
- Instalar y configurar el rol *Print and Document Services* en Windows Server.
- Agregar impresoras por dirección TCP/IP y gestionar drivers.
- Compartir impresoras y asignar permisos (impresión, gestión de documentos).
- Integrar el servidor de impresión en un entorno Windows Server en AWS (unión al dominio, Security Groups).

## Contenidos

**Bloque 1 — Servidor de impresión en Windows Server**  
Función del servidor de impresión en red. Rol *Print and Document Services*. Consola *Print Management*. Tipos de servidor de impresión (estándar, con LPD, por Internet); elección del servidor estándar para entornos corporativos.

**Bloque 2 — Instalación y configuración en AWS**  
Requisitos: Windows Server en EC2, unión al dominio (DNS apuntando al DC, Security Groups que permitan tráfico entre instancias Windows). Instalación del rol desde *Server Manager* → *Add roles and features*.

**Bloque 3 — Impresoras por TCP/IP y drivers**  
Agregar impresora por dirección IP. Asistente *Add Printer*: puerto TCP/IP, detección de impresora en red. Si la impresora no se encuentra, instalación manual con driver genérico (p. ej. HP PCL6). Configuración de puertos y nombre de la impresora compartida.

**Bloque 4 — Compartición y permisos**  
Compartir la impresora en red con un nombre reconocible (p. ej. *HP Presentadores*). Permisos de seguridad: *Print* (enviar trabajos), *Manage documents* (gestionar cola de otros). Asignación a usuarios o grupos del dominio (p. ej. quitar *Everyone* y dar solo a un usuario como María). Buenas prácticas: usuarios normales solo *Print*, administradores *Manage printers*.

**Bloque 5 — Actividad práctica (RG801)**  
Realizar el servidor de impresión explicado en el vídeo sobre Windows Server en AWS (unión al dominio, rol de impresión, impresora por TCP/IP o simulada, permisos). Ver enunciado en Actividades.

!!! question "Actividades iniciales"
    1. ¿Qué ventajas tiene centralizar las impresoras en un servidor de impresión frente a conectar cada impresora directamente a un equipo?
    2. ¿Qué puerto o protocolo se utiliza normalmente para agregar una impresora de red por IP?
    3. ¿Qué diferencia hay entre el permiso *Print* y *Manage documents* en una impresora compartida?

### Programación de Aula

| Sesión | Contenidos | Actividades |
|--------|------------|-------------|
| 1 | Servidor de impresión: función, rol Print and Document Services, consola Print Management. | Teoría y visionado del vídeo. |
| 2 | Instalación en AWS: unión al dominio, Security Groups, instalación del rol. Impresoras por TCP/IP y drivers. | Práctica guiada. |
| 3 | Compartición y permisos. Integración con usuarios del dominio. | RG801: servidor de impresión en AWS (+0,25). |

---

## 1. Función del servidor de impresión en red

En un entorno corporativo, el **servidor de impresión** centraliza las impresoras en uno o varios servidores. Los clientes (Windows, Linux u otros) envían trabajos a las colas del servidor, que gestiona drivers, prioridades y permisos. Así se evita instalar cada impresora en cada equipo y se facilita el control de quién puede imprimir y quién puede administrar la cola.

En **Windows Server**, el rol **Print and Document Services** proporciona:

- **Print Management**: consola para agregar impresoras, gestionar colas, drivers y formularios.
- **Impresoras por TCP/IP**: agregar impresoras por dirección IP (puerto estándar).
- **Compartición**: publicar la impresora en la red con un nombre y permisos por usuario o grupo.

En entornos **virtualizados o en la nube** (p. ej. AWS), el servidor de impresión suele ser una instancia Windows Server unida al dominio, con los mismos requisitos de red que el resto de servidores (DNS, Security Groups que permitan tráfico entre miembros del dominio).

---

## 2. Rol Print and Document Services

La instalación del rol se realiza desde **Server Manager** → **Add roles and features**. Al elegir **Print and Document Services** se ofrecen opciones:

| Opción | Descripción |
|--------|-------------|
| **Print Server** | Servidor de impresión estándar. Es la opción habitual en una red corporativa. |
| **Print Server (Internet)** | Servidor de impresión accesible vía Internet (escenario menos común). |
| **LPD Service** | Servicio Line Printer Daemon para clientes que usan el protocolo LPD (p. ej. algunos sistemas Unix). |

Para la mayoría de los casos se selecciona **Print Server**. Tras la instalación aparecen herramientas en **Server Manager** → **Tools**, en particular **Print Management**, desde donde se gestionan impresoras, drivers, puertos y formularios.

---

## 3. Agregar impresoras por TCP/IP

Desde **Print Management** (o *Devices and Printers* → *Add a printer*) se puede **agregar una impresora por TCP/IP**:

1. Elegir **Add printer** → **Add a TCP/IP or Web Services printer by IP address**.
2. Indicar la **dirección IP** de la impresora (o del equipo que hace de impresora de red). En un laboratorio sin impresora física se puede usar la IP del propio servidor para simular; la impresora no responderá pero permitirá completar el asistente eligiendo un driver manualmente.
3. Si el sistema **detecta** la impresora en la red, instalará el driver automáticamente. Si no la encuentra (impresora apagada o IP inexistente), se puede continuar y en el siguiente paso elegir un **driver genérico** (p. ej. *Microsoft Open XPS*, *HP* genérico, *PCL6*) para crear la cola.
4. Asignar un **nombre** a la impresora y, si se desea, **compartirla** con un nombre para la red (p. ej. *HP Presentadores*).

En la pestaña **Ports** de las propiedades de la impresora se comprueba el puerto TCP/IP configurado (dirección IP y puerto estándar si aplica).

---

## 4. Compartición y permisos

Una vez creada la impresora, en sus **Properties** → **Sharing** se puede:

- Marcar **Share this printer** y dar un **Share name** (sin espacios en el nombre suele evitar problemas).
- Los clientes del dominio podrán buscar la impresora por ese nombre (p. ej. `\\SW25isprinters\HP Presentadores`).

En **Security** (propiedades de la impresora) se configuran los **permisos**:

| Permiso | Efecto |
|---------|--------|
| **Print** | El usuario puede enviar trabajos a la impresora. |
| **Manage documents** | El usuario puede pausar, reanudar o eliminar trabajos de la cola (propios y de otros). |
| **Manage printers** | El usuario puede cambiar propiedades de la impresora, compartirla y gestionar permisos. |

Por defecto, **Everyone** puede imprimir. En un entorno controlado suele quitarse *Everyone* y asignarse **Print** solo a los usuarios o grupos que deban usar esa impresora (p. ej. un usuario como María o un grupo *Presentadores*). Los administradores suelen tener *Manage printers* para administrar el servidor de impresión.

---

## 5. Integración en AWS: dominio y Security Groups

Para que el servidor de impresión funcione en una red Windows en AWS:

1. **Unión al dominio:** La instancia Windows Server (EC2) debe tener su **DNS** apuntando a la IP del controlador de dominio (DC). Desde **Propiedades del sistema** se une al dominio (p. ej. *miempresa.com*) con un usuario con permisos (p. ej. administrador del dominio o una cuenta delegada). Tras el reinicio, se puede iniciar sesión con un usuario del dominio.
2. **Security Groups:** En AWS, las instancias deben pertenecer a un **Security Group** que permita el tráfico necesario entre los equipos Windows: no solo RDP (3389), sino también los puertos que Active Directory y el acceso a recursos compartidos (incluidas impresoras) requieren. Si solo está abierto el 3389, la máquina no podrá unirse al dominio ni los clientes podrán ver las impresoras compartidas. Es habitual crear un grupo (p. ej. *Windows Server*) que permita RDP desde tu IP y tráfico entre las instancias de la cuenta en esa VPC.
3. **OU de servidores:** En Active Directory se suelen crear unidades organizativas (OU) para los servidores que no son controladores de dominio, para aplicar directivas específicas. El servidor de impresión se mueve a esa OU (p. ej. *Servidores*) desde *Computers*.

Con esto, el servidor de impresión queda integrado en la red corporativa y los usuarios del dominio pueden agregar la impresora compartida desde sus equipos.

---

## Vídeo: IIS y Servidor de impresión en Windows Server (AWS)

A continuación puedes ver un vídeo práctico en el que se instalan en un mismo Windows Server en AWS el rol **Internet Information Services (IIS)** y el rol **Servidor de impresión**. Se muestra la unión de un servidor *standalone* al dominio, la instalación de ambos roles y la configuración de una impresora por TCP/IP (incluida la gestión de drivers y permisos). El vídeo comienza en el momento en que se aborda la instalación de roles (IIS e impresión).

<div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; margin-top: 1em; margin-bottom: 1em;">
  <iframe src="https://www.youtube.com/embed/UewPcO7ZG48?start=181"
          style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
          title="IIS y Servidor de impresión en Windows Server (AWS)"></iframe>
</div>

<p style="text-align: center; font-size: 1.1em; margin-top: 0.5em;">
  Vídeo en español: instalación de IIS y del servidor de impresión en Windows Server en AWS, unión al dominio y configuración de una impresora por TCP/IP.
</p>

!!! note "Resumen del vídeo: IIS y Servidor de impresión en Windows Server (AWS)"
    El vídeo muestra la instalación de **dos roles** en una misma instancia Windows Server en EC2: **Internet Information Services (IIS)** y **Servidor de impresión** (*Print and Document Services*), en un entorno con Active Directory ya desplegado (vídeo anterior).

    - **Contexto:** Se parte de un controlador de dominio (DC01) y de un servidor *standalone* recién creado en AWS. El objetivo es unir ese servidor al dominio e instalar en él IIS e impresión.
    - **Preparación del servidor:** Primera conexión por RDP con el usuario *Administrator* y contraseña descomprimida desde la consola AWS. Cambio de nombre del equipo (p. ej. *SW25isprinters*), reinicio. Configuración de **DNS** del adaptador de red con la **IP del controlador de dominio** para poder unir la máquina al dominio.
    - **Unión al dominio:** En Propiedades del sistema → Cambiar → Dominio, se indica el nombre del dominio (p. ej. *miempresa.com*). Si falla, suele deberse a: nombre de dominio incorrecto, DNS que no apunta al DC, o **Security Group** en AWS que no permite tráfico entre instancias. Se cambia el Security Group de la instancia (y del DC) a uno que abra RDP y el tráfico entre máquinas Windows. Tras unir al dominio con un usuario con permisos (p. ej. *santos*), reinicio. A partir de entonces se inicia sesión con usuario del dominio (p. ej. *miempresa\santos*).
    - **Creación de OU en AD:** En el DC se crea una OU *Servidores* para colocar los servidores que no son controladores de dominio y poder aplicar directivas. El nuevo servidor se mueve desde *Computers* a *Servidores*.
    - **Instalación de roles:** En el servidor unido al dominio, *Server Manager* → Add roles and features. Se seleccionan **Web Server (IIS)** y **Print and Document Services**. Para impresión se elige **Print Server** (estándar). Se aceptan las características por defecto de IIS y se completa la instalación.
    - **Print Management:** Tras la instalación, en Tools aparece **Print Management**. Desde ahí se agrega una impresora por **TCP/IP** (dirección IP). Si la impresora no existe en la red, el asistente no la detecta y se puede continuar eligiendo un driver genérico (p. ej. HP, PCL6) para crear la cola. Se asigna nombre a la impresora (p. ej. *HP Presentadores*) y se comparte.
    - **Permisos de impresora:** En Propiedades de la impresora → Security se quita *Everyone* y se asigna a usuarios concretos (p. ej. solo *María*) el permiso **Print**, de modo que solo esos usuarios puedan imprimir. *Manage documents* y *Manage printers* se reservan para administradores.
    - **IIS (resumen):** Se muestra la carpeta por defecto *C:\inetpub\wwwroot* y cómo sustituir la página por defecto por otra (p. ej. un juego descargado). Desde el DC se puede acceder a la página web por nombre del servidor o por alias DNS (CNAME *intranet*, *portal empleado*) configurados en el servidor DNS del dominio.

!!! tip "Requisitos para la actividad"
    Para realizar la actividad de servidor de impresión necesitas: cuenta **AWS** (p. ej. AWS Academy), una instancia **Windows Server** en EC2, un **controlador de dominio** en la misma VPC y un **Security Group** que permita RDP y tráfico entre instancias Windows. Consulta el vídeo anterior de instalación de Active Directory si aún no tienes el dominio desplegado.

---

## Actividades

### RG801: Servidor de impresión en Windows Server (AWS) — **+0,25 en la nota final**

**Duración estimada:** 1–1,5 h. **Modalidad:** Individual o en parejas.

Realiza el **servidor de impresión** explicado en el vídeo anterior:

- Tener (o crear) un entorno en AWS con al menos un **controlador de dominio** (Windows Server) y un **servidor miembro** (Windows Server) en la misma VPC.
- Asegurar que el **DNS** del servidor miembro apunta al DC y que los **Security Groups** permiten el tráfico necesario entre instancias Windows (no solo RDP).
- Unir el servidor miembro al dominio.
- Instalar el rol **Print and Document Services** (Print Server estándar) en el servidor miembro.
- Agregar al menos **una impresora** por TCP/IP (puede ser la IP del propio servidor para simular si no hay impresora física; en ese caso elegir un driver genérico cuando el asistente no la detecte).
- Compartir la impresora con un nombre y configurar **permisos** (p. ej. quitar *Everyone* y dar solo *Print* a un usuario del dominio).
- Documentar con capturas: servidor unido al dominio, rol instalado, impresora en Print Management, permisos configurados. Opcional: comprobar desde un cliente del dominio que la impresora aparece y está accesible.

[:octicons-tag-24: Ver enunciado completo — RG801 (Servidor de impresión AWS)](PracticaServidorImpresionAWS.md){ .md-button }

---

## Referencias

- [Windows Server: Print and Document Services](https://learn.microsoft.com/en-us/windows-server/administration/print-services/print-services)
- [04 Servicios de Directorio (Active Directory)](04ActiveDirectory.md): requisitos de dominio y DNS para unir servidores.
- [03 Acceso remoto](03AccesoRemoto.md): RDP y conexión a instancias Windows en AWS.
