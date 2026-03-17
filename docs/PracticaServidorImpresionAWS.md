---
title: RG801 — Servidor de impresión en Windows Server (AWS)
description: Actividad de 1–1,5 h para desplegar y configurar el servidor de impresión explicado en el vídeo del tema 8. Puntuación +0,25 en la nota final.
subtitle: Actividad Servidor de Impresión
---

# RG801: Servidor de impresión en Windows Server (AWS)

- **Modalidad:** Individual o en parejas.
- **Duración estimada:** 1–1,5 horas.
- **Puntuación:** +0,25 en la nota final.
- **Entorno:** Cuenta AWS (p. ej. AWS Academy) con posibilidad de crear instancias Windows Server en EC2.
- **Referencia:** Vídeo del tema [08 Servidores de Impresión](08ServidoresImpresion.md) (IIS y Servidor de impresión en Windows Server).

## Objetivos

Al finalizar la actividad serás capaz de:

- Unir una instancia Windows Server al dominio Active Directory en AWS (DNS, Security Groups).
- Instalar el rol **Print and Document Services** (Print Server estándar) en un servidor miembro.
- Agregar una impresora por **TCP/IP** (real o simulada con driver genérico).
- Compartir la impresora y configurar **permisos** (impresión solo para usuarios autorizados del dominio).
- Documentar el proceso con capturas.

## Requisitos previos

- **Entorno en AWS** con al menos un **controlador de dominio** (Windows Server) en una VPC. Si no lo tienes, sigue antes el vídeo o la práctica de instalación de Active Directory en AWS.
- **Security Group** que permita:
  - RDP (3389) para conectarte a las instancias.
  - Tráfico entre las instancias Windows de tu cuenta en esa VPC (para que el servidor pueda unirse al dominio y los clientes accedan a recursos).
- Usuario con permisos para unir equipos al dominio (p. ej. administrador del dominio o cuenta delegada).

---

## Fase 1 — Preparar el servidor y unirlo al dominio

### Objetivo

Tener una instancia Windows Server en EC2, con nombre adecuado, DNS apuntando al DC y unida al dominio.

### Pasos

1. **Crear o usar una instancia Windows Server** en EC2 (misma VPC y subred que el DC). Tamaño recomendado al menos t3.small para mayor fluidez.
2. **Conectar por RDP** con el usuario *Administrator* y la contraseña que obtengas desde la consola AWS (Get Windows password con la clave PEM).
3. **Cambiar el nombre del equipo** (p. ej. *PrintServer01*) desde Configuración → Sistema → Acerca de → Cambiar nombre. Reiniciar cuando se pida.
4. **Configurar DNS:** En Configuración de red (o Panel de control → Centro de redes → Cambiar configuración del adaptador → Propiedades de la tarjeta → TCP/IPv4), poner como **DNS preferido** la **IP privada del controlador de dominio**. Comprobar con `ipconfig /all` que el DNS es el correcto.
5. **Ajustar Security Group** en AWS: Si la instancia tiene un grupo que solo abre RDP, cámbialo por uno que permita también el tráfico entre instancias Windows (o el que uses para el DC). Aplica el mismo grupo al DC si aún no lo tiene.
6. **Unir al dominio:** Propiedades del sistema → Cambiar → Dominio → indicar el nombre del dominio (p. ej. *miempresa.com*). Cuando pida credenciales, usar un usuario con permisos (p. ej. administrador del dominio). Reiniciar.
7. **Volver a conectar por RDP** iniciando sesión con un usuario del dominio (p. ej. *dominio\usuario*).

### Entregable de la fase

Captura que muestre el equipo unido al dominio (Propiedades del sistema o `SystemPropertiesComputerName`).

---

## Fase 2 — Instalar el rol e configurar la impresora

### Objetivo

Instalar el rol Print and Document Services, agregar una impresora por TCP/IP (o simulada) y configurar compartición y permisos.

### Pasos

1. **Instalar el rol:** Abrir **Server Manager** → **Add roles and features**. Seleccionar el servidor, en Roles marcar **Print and Document Services**. En las opciones del rol elegir **Print Server** (estándar). Completar el asistente y esperar a que finalice la instalación.
2. **Abrir Print Management:** Herramientas → **Print Management** (o desde Server Manager → Tools).
3. **Agregar impresora por TCP/IP:**
   - Clic derecho en *Printers* → **Add Printer** → **Add a TCP/IP or Web Services printer by IP address**.
   - Dirección IP: si tienes una impresora real en la red, usa su IP. Si no, puedes usar la **IP del propio servidor** (la verás en `ipconfig`) para simular; el asistente no encontrará la impresora pero permitirá continuar.
   - Si no detecta la impresora: seguir el asistente y cuando pida el driver, elegir uno **genérico** (p. ej. fabricante *HP*, modelo *PCL6* o similar, o *Microsoft Open XPS*). Asignar un nombre a la impresora (p. ej. *HP Presentadores*) y marcar **Share this printer** con un nombre de recurso compartido (sin espacios).
4. **Permisos:** Propiedades de la impresora → **Security**. Quitar *Everyone* si está. Añadir un usuario del dominio (p. ej. el que uses para pruebas) con permiso **Print**. Dejar *Manage printers* para administradores si lo deseas.
5. **Comprobar:** En la pestaña **Ports** verificar que el puerto TCP/IP tiene la IP correcta. En **Sharing** verificar el nombre de recurso compartido.

### Entregable de la fase

Capturas de: Print Management con la impresora instalada; ventana de permisos (Security) de la impresora; opcional: cliente del dominio con la impresora agregada y visible.

---

## Entregables globales

1. **Documento** (Markdown o PDF) con:
   - Breve descripción del entorno (DC, servidor de impresión, VPC/Security Group).
   - Capturas de la Fase 1 (servidor unido al dominio) y de la Fase 2 (rol instalado, impresora en Print Management, permisos).
   - Opcional: captura desde un equipo cliente del dominio mostrando la impresora compartida disponible.

2. **Criterios de evaluación:** Se valorará la unión correcta al dominio, la instalación del rol, la impresora agregada y compartida, la configuración de permisos y la claridad de la documentación.

## Referencias

- [08 Administración de Servidores de Impresión](08ServidoresImpresion.md): teoría y vídeo IIS + Servidor de impresión.
- [04 Servicios de Directorio (Active Directory)](04ActiveDirectory.md): instalación del dominio en AWS si aún no lo tienes.
