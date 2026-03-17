---
title: Automatización y monitorización
description: Infraestructura como Código (IaC), Terraform en AWS, CloudWatch, CloudTrail, EventBridge y reto práctico Active Directory en AWS (TechCorp).
subtitle: Automatización y monitorización
---

# Automatización y Monitorización en AWS

En esta unidad se trabaja la **automatización de infraestructura** y la **monitorización** en AWS: **Infraestructura como Código (IaC)** con **Terraform**, **CloudWatch** para métricas y alarmas, **CloudTrail** para auditoría de API y **EventBridge** para automatización reactiva, con un **reto práctico** de Active Directory en AWS (TechCorp).

## Propuesta didáctica

En esta unidad vamos a trabajar el **RA3 de ASO**:

> **RA3.** *Gestiona la automatización de tareas del sistema, aplicando criterios de eficiencia y utilizando comandos y herramientas gráficas.*

Se relaciona con el **objetivo general (15)** del módulo: *Aplicar técnicas de monitorización interpretando los resultados y relacionándolos con las medidas correctoras para diagnosticar y corregir las disfunciones.*

### Criterios de evaluación (RA3)

- **CE3a**: Se han descrito las ventajas de la automatización (incl. IaC y reproducibilidad).
- **CE3b**: Se han utilizado comandos/herramientas para la planificación y despliegue (Terraform CLI).
- **CE3c**: Se han establecido restricciones de seguridad (estado remoto, credenciales, redes).
- **CE3d**: Se han realizado despliegues repetibles (infraestructura con Terraform).
- **CE3e**: Se ha automatizado la administración (scripts o IaC asociados al reto).
- **CE3f**: Se han instalado y configurado herramientas para monitorización (CloudWatch).
- **CE3g**: Se han utilizado herramientas gráficas para planificación y monitorización (consola AWS).
- **CE3h**: Se ha documentado el proceso (README, variables, flujo init/plan/apply/destroy).

## Contenidos

**Bloque 1 — Infraestructura como Código (IaC)**  
Concepto de IaC. Declarativo vs imperativo. Reproducibilidad, idempotencia, versionado. Terraform: providers, recursos, variables y outputs, ciclo init/plan/apply/destroy. Proyecto TechCorp (VPC, subred, Security Group, EC2 DC01 y Cliente).

**Bloque 2 — Monitorización y eventos en AWS**  
CloudWatch (métricas, alarmas, logs, dashboards). CloudTrail (auditoría de API). EventBridge (eventos y reglas). Relación entre los tres servicios.

**Bloque 3 — Automatización con Terraform**  
Alarmas CloudWatch y SNS con Terraform. CloudTrail y EventBridge como código (opcional).

**Bloque 4 — Reto práctico TechCorp**  
Despliegue de infraestructura, instalación de AD, monitorización y auditoría/eventos (ver enunciado en Actividades).

!!! question "Actividades iniciales"
    1. ¿Qué ventajas tiene definir la infraestructura como código frente a crearla manualmente en la consola?
    2. ¿Qué comando de Terraform muestra los cambios sin aplicarlos?
    3. ¿Para qué sirve el archivo `terraform.tfstate` y por qué no debe subirse a un repositorio público?
    4. ¿Qué servicio de AWS permite crear alarmas cuando la CPU de una instancia supera un umbral?
    5. ¿Qué servicio de AWS registra quién ejecutó una acción sobre un recurso y cuándo?

### Programación de Aula (4 sesiones)

| Sesión | Contenidos | Actividades | Criterios |
| --- | --- | --- | --- |
| 1 | IaC y Terraform. Ciclo de vida, estructura, proyecto TechCorp. | init/plan/apply, ejemplos | CE3a, CE3b, CE3d |
| 2 | CloudWatch, CloudTrail, EventBridge. | Métricas, alarmas, trails, reglas | CE3f, CE3g, Objetivo 15 |
| 3 | Alarmas y SNS con Terraform. CloudTrail y EventBridge opcionales. | Código de monitorización | CE3c, CE3h |
| 4 | **Reto práctico:** TechCorp (4 fases, 3 h). | [RG701 / RG702 TechCorp](RetoPracticoTechCorp.md) | CE3e, CE3h, Objetivo 15 |

---

## 1. Infraestructura como Código (IaC)

### Concepto de Infraestructura como Código

La **Infraestructura como Código (IaC)** consiste en definir, aprovisionar y gestionar infraestructura (servidores, redes, bases de datos) mediante **archivos de configuración** legibles por máquina, en lugar de hacerlo manualmente con consolas gráficas o comandos sueltos. Los recursos se describen en código, lo que permite automatizar su creación y modificación, versionar la infraestructura igual que el código de una aplicación y garantizar entornos reproducibles y consistentes.

#### Declarativo vs imperativo

La **Infraestructura como Código (IaC)** permite definir la infraestructura con archivos de texto que se pueden versionar y reutilizar, facilitando la automatización y asegurando despliegues consistentes y repetibles como si fuera software. Existen dos enfoques principales: el imperativo (describe paso a paso cómo hacer los cambios mediante scripts) y el declarativo (define el estado final deseado y la herramienta realiza los cambios necesarios). Usar IaC aporta mayor seguridad, control y trabajo colaborativo sobre la infraestructura.

A continuación, se muestra una tabla comparativa entre los enfoques imperativo y declarativo en la gestión de infraestructura.  

| Enfoque      | Descripción                                                                                                 | Cuándo usarlo / Ejemplos                                                                            |
|--------------|-------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| **Imperativo**   | Indicas **paso a paso** cómo hacerlo (ej.: "crea una VM, luego instala nginx, luego abre el puerto 80"). Ofrece control detallado pero es más frágil. | Tareas puntuales, automatización mediante scripts (shell, PowerShell), operaciones secuenciales o migraciones donde necesitas control total de cada paso.                        |
| **Declarativo**  | Describes el **estado final deseado**; la herramienta decide cómo lograrlo (ej.: "quiero una VM con nginx y puerto 80 abierto"). Más mantenible y predecible. Terraform es declarativo. | Infraestructuras completas, sistemas escalables, despliegues en la nube y entornos repetibles donde se busca coherencia, consistencia y automatización; herramientas: Terraform, Ansible en modo declarativo, manifiestos Kubernetes.|

#### Características clave de la IaC

- **Reproducibilidad:** Permite crear entornos **idénticos** (desarrollo, pruebas, producción) reutilizando el mismo código y variables. Así, cualquier persona o pipeline puede desplegar la infraestructura sin pasos manuales no documentados.
- **Idempotencia:** Al aplicar varias veces la misma configuración declarativa se garantiza obtener **el mismo resultado** sin duplicar recursos. Por ejemplo, Terraform compara el estado deseado (código) y el actual (tfstate), aplicando solo los cambios necesarios.
- **Versionado de infraestructura:** Los archivos de configuración (`.tf`) pueden gestionarse con **Git**, lo que permite auditar, revertir, revisar y colaborar en los cambios a la infraestructura. Es fundamental ignorar el archivo `terraform.tfstate` y secretos sensibles mediante `.gitignore` o backends remotos.

#### Beneficios en entornos empresariales

- **Automatización:** menos errores humanos y despliegues más rápidos.
- **Auditoría y trazabilidad:** todo cambio queda reflejado en el código y en el historial de versiones.
- **Escalabilidad:** desplegar múltiples entornos o recursos de forma sistemática.
- **Consistencia:** se evita la "deriva de configuración" entre entornos.

### Comparativa rápida: CloudFormation vs Terraform

Aunque **Terraform** es la herramienta IaC más habitual en entornos multi-nube o cuando quieres independencia del proveedor, AWS ofrece su propia alternativa nativa: **AWS CloudFormation**. Ambos permiten describir la infraestructura en archivos de texto y automatizar su despliegue, pero presentan diferencias clave:

| Aspecto                | **CloudFormation**                                  | **Terraform**                                              |
|------------------------|----------------------------------------------------|------------------------------------------------------------|
| **Proveedor**          | AWS (solo infra AWS, integración 100%)             | HashiCorp (multi-nube: AWS, Azure, GCP, SaaS, local, etc.) |
| **Lenguaje**           | YAML o JSON                                        | HCL (propio de Terraform, más legible), también JSON        |
| **Enfoque**            | Declarativo                                        | Declarativo                                                |
| **Gestión del estado** | AWS lo gestiona internamente ("stacks")            | Archivo `terraform.tfstate` local o en backend remoto       |
| **Modularidad**        | Soporta "nested stacks" (pila dentro de pila)      | Soporta módulos reutilizables y publicables                 |
| **Recursos soportados**| Todos los servicios y novedades AWS rápidamente    | AWS, Azure, GCP, VMware, GitHub, y cientos más             |
| **Madurez**            | Muy alta para AWS; integrado en consola AWS        | Alta, usada en empresas multi-nube y DevOps                 |
| **Extensibilidad**     | Limitada a AWS y servicios vinculados              | Ampliable por providers y módulos de la comunidad           |
| **Aprendizaje**        | Más fácil si solo operas con AWS                   | Más genérico y portable entre nubes                         |

#### Resumen

- **CloudFormation** es ideal si solo necesitas trabajar con AWS, quieres integración nativa, plantillas precreadas o desplegar recursos de AWS tan pronto como están disponibles.
- **Terraform** es más flexible y reutilizable si vas a gestionar recursos en varios proveedores de nube o buscas portabilidad del código IaC entre plataformas. Es preferido en escenarios multi-cloud o para equipos DevOps que gestionan infraestructuras mixtas.
- En cuanto a la sintaxis, **HCL de Terraform** es generalmente más legible y modular, mientras que CloudFormation usa YAML/JSON más verboso.

!!! note "Resumen"
    **Terraform** es el estándar de facto en entornos *multi-nube* para Infraestructura como Código, mientras que **CloudFormation** es la solución específica y nativa de *AWS*.
---

### Terraform

**Terraform** es una herramienta de IaC creada por **HashiCorp**. Usa el lenguaje **HCL** (HashiCorp Configuration Language) en archivos `.tf`. Funciona con múltiples proveedores (AWS, Azure, GCP, etc.) y es **declarativo**: defines el resultado y Terraform ejecuta los cambios necesarios.

!!! note "Documentación oficial de Terraform en español"
    Puedes consultar la documentación oficial y recursos de Terraform en: [Terraform Documentación](https://developer.hashicorp.com/terraform/docs)

#### ¿Qué es Terraform?

- Gestiona infraestructura en nubes públicas (AWS, Azure, GCP), plataformas privadas (VMware, OpenStack), servicios SaaS (GitHub, Cloudflare) e infraestructura local (archivos, contenedores).
- Características principales: lenguaje declarativo (HCL), gestión de dependencias entre recursos, multi‑cloud, planificación antes de aplicar (`terraform plan`), gestión del estado (tfstate), modularidad e integración con CI/CD.


A continuación, puedes ver un vídeo introductorio que resume los conceptos clave de Infraestructura como Código y Terraform:

<div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; margin-top: 1em; margin-bottom: 1em;">
  <iframe src="https://www.youtube.com/embed/7SNPPH6yKus?start=504"
          style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
          title="Introducción a Terraform e Infraestructura como Código"></iframe>
</div>

<p style="text-align: center; font-size: 1.1em; margin-top: 0.5em;">
  Vídeo explicativo en español sobre Infraestructura como Código (IaC) y Terraform: concepto, ventajas del enfoque declarativo y primeros pasos.
</p>

!!! note "Resumen del vídeo: Terraform vs CloudFormation (min 8:24–14:38)"
    - **Del min 0:00 al 8:19:** Se muestra el uso de **CloudFormation en AWS** (plantilla LAMP, diseñador visual, lanzar y borrar stack).
    - **Del min 8:24 al 14:38:**  
        - Comparativa de **Terraform como herramienta multi-nube** frente a CloudFormation.
        - Clonado de un repositorio en **Cloud9**.
        - Instalación de **Terraform** en Cloud9.
        - Creación de un fichero declarativo `main.tf` para:
            - Un Security Group "ring" con el puerto 22 abierto.
            - Un key pair "key".
            - Una instancia EC2 T2 micro "riser".
        - Ejecución de los comandos principales: `terraform init`, `terraform apply` y `terraform destroy`.
        - Introducción a la **IaC (Infraestructura como Código)** y el concepto de datacenter definido por software gracias a Terraform.

!!! tip "Repositorio de ejemplo Terraform"
    Puedes encontrar un ejemplo práctico de uso de Terraform para desplegar máquinas EC2 en AWS en el siguiente repositorio público de GitHub: [https://github.com/santos-pardos/tf-ec2](https://github.com/santos-pardos/tf-ec2)

### Instalación de Terraform

Para empezar a trabajar con Terraform, primero necesitas instalarlo en tu sistema. Terraform es una herramienta multiplataforma, por lo que puedes instalarlo en **Windows, macOS o Linux**. La forma recomendada de instalar Terraform es descargar el binario oficial desde la web de HashiCorp o usar un gestor de paquetes.

#### Pasos rápidos

1. **Descarga el binario oficial**  
   Visita la página oficial de descargas:  
   [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)

   Allí selecciona tu sistema operativo y arquitectura, descarga el archivo `.zip` y descomprímelo.

2. **Coloca el ejecutable en tu PATH**  
   Copia el archivo ejecutable `terraform` (o `terraform.exe` en Windows) en una ruta que esté en tu variable de entorno PATH, por ejemplo:

   - **Linux/macOS**:  
     ```bash
     sudo mv terraform /usr/local/bin/
     ```
   - **Windows**:  
     Copia `terraform.exe` a una carpeta incluida en PATH, o agrega la carpeta donde lo colocaste a la variable de entorno PATH.

3. **Verifica la instalación**  
   Abre una terminal y ejecuta:
   ```bash
   terraform version
   ```
   Deberías ver la versión instalada.

#### Instalación con gestor de paquetes

También puedes instalar Terraform con un gestor de paquetes, lo que facilita mantenerlo actualizado:

- **macOS (Homebrew):**
  ```bash
  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform
  ```

- **Windows (Chocolatey):**
  ```powershell
  choco install terraform
  ```

- **Linux (apt):**
  ```bash
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install terraform
  ```

Para otros métodos o sistemas operativos, consulta siempre la documentación oficial:
👉 [Guía oficial de instalación de Terraform](https://developer.hashicorp.com/terraform/install)

> _La instalación recomendada y las instrucciones actualizadas están siempre disponibles en la documentación oficial. Consulta allí para posibles cambios o pasos especiales según tu sistema operativo._

---


#### Providers

Los **providers** son plugins que permiten a Terraform hablar con APIs externas (AWS, Azure, local, random, etc.). Se declaran en el bloque `terraform` y se descargan con `terraform init`. Ejemplo:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.region
}
```

#### Recursos

Los **recursos** son los elementos que Terraform crea o gestiona (instancias EC2, VPC, Security Groups, etc.). Se definen con bloques `resource "tipo" "nombre_local" { ... }`. Terraform calcula el orden de creación y destrucción según las dependencias.

#### Variables y outputs

- **Variables** (`variable` en `variables.tf` o en archivos `.tf`): parametrizan la configuración (región, AMI, tipo de instancia). Se pueden asignar en `terraform.tfvars` o por línea de comandos.
- **Outputs** (`output` en `outputs.tf`): exponen valores al final del `apply` (IPs públicas, IDs de recursos), útiles para otros sistemas o para el operador.

#### Ciclo de vida: init, plan, apply, destroy

| Comando | Descripción |
|--------|-------------|
| **terraform init** | Inicializa el proyecto, descarga providers y prepara el backend. Ejecutar al empezar o al cambiar providers. |
| **terraform plan** | Compara el estado deseado (código) con el actual (tfstate) y muestra los cambios que se aplicarían **sin ejecutarlos**. |
| **terraform apply** | Aplica los cambios (crea, modifica o elimina recursos). Pide confirmación a menos que uses `-auto-approve`. Actualiza el tfstate. |
| **terraform destroy** | Elimina todos los recursos gestionados por Terraform. Útil para limpiar entornos de prueba. |

!!! warning "Buenas prácticas"
    - **Revisa siempre los cambios con `terraform plan` antes de ejecutar `terraform apply`**. El comando `plan` te muestra exactamente qué recursos se crearán, actualizarán o eliminarán, ayudando a evitar errores o modificaciones no deseadas. Nunca apliques cambios a ciegas en producción directamente con `apply`.
    - **No subas los archivos de estado (`terraform.tfstate`, `terraform.tfstate.backup`) ni la carpeta `.terraform/` al repositorio Git**. El estado contiene información sensible y referencias a toda tu infraestructura. Añade estos archivos al `.gitignore`.
    - **En proyectos colaborativos, usa siempre un backend remoto** (como S3, Terraform Cloud, Azure Storage, etc.). Esto permite que todos los miembros del equipo compartan el mismo estado y **evita conflictos y corrupción de estado**. Además, habilita **bloqueo de estado** (state locking) para que no se puedan ejecutar dos `apply` simultáneamente sobre el mismo estado, lo que puede provocar errores graves y pérdida de sincronización.
    - **Haz respaldos frecuentes del estado** y, si es posible, habilita el versionado en el backend (por ejemplo, de un bucket S3) para poder recuperar versiones anteriores si hay algún problema.

#### Buenas prácticas básicas

- Mantener una estructura modular (módulos por componente o entorno).
- Definir versiones explícitas de Terraform y providers (`required_version`, `version` en `required_providers`).
- Usar nombres descriptivos en variables, outputs y recursos.
- Documentar en README las variables requeridas y el flujo init/plan/apply/destroy.
- No guardar credenciales en código; usar variables de entorno o sistemas de secretos.

---

Para consolidar y visualizar estos conceptos, a continuación encontrarás un vídeo explicativo que repasa el ciclo de vida de Terraform y detalla buenas prácticas.

<div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; margin-top: 1em; margin-bottom: 1em;">
  <iframe src="https://www.youtube.com/embed/ad6pbgmDUhE?start=1121"
          style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
          title="Terraform — ciclo de vida y buenas prácticas"></iframe>
</div>

<p style="text-align: center; font-size: 1.1em; margin-top: 0.5em;">
  Vídeo explicativo en español sobre el ciclo de vida de Terraform (init, plan, apply, destroy) y buenas prácticas de uso.
</p>

!!! note "Resumen del vídeo de Terraform"
    - **Terraform en este vídeo:** del **min 18:41** al **min 36:10**.
    - Se explican los siguientes aspectos:
        - Introducción a Terraform y HashiCorp (después de mostrar CloudFormation).
        - Instalación de Terraform en Linux (usando el repositorio de HashiCorp y `dnf install terraform`).
        - Creación de un archivo `main.tf` básico para lanzar una instancia EC2.
        - Ciclo de vida de Terraform: `init` → `plan` → `apply` → `destroy`.
        - Configuración de credenciales AWS con `aws configure`.
        - Ejecución de los comandos `plan`, `apply` y destrucción con `destroy`.
        - Demostración de un ejemplo de arquitectura más grande (uso de variables, configuración de backend S3, estructura en tres capas, balanceadores, RDS).
    - A partir del min 36:11 se presenta OpenTofu, un fork de Terraform.

!!! tip "Ejemplos Terraform en AWS"
    - Repositorio con ejemplos de Terraform en AWS (basados en *Terraform: Up and Running*): hello-world, servidor único, webserver, cluster con ALB, S3, state remoto, módulos y bucles. Incluye instalación de Terraform/OpenTofu en Amazon Linux 2023: [terraform-aws-examples](https://github.com/santos-pardos/terraform-aws-examples).
    - Ejemplo de arquitectura de tres capas en AWS (web, aplicación, base de datos) con VPC, subredes, ALB, Auto Scaling Groups y RDS, desplegable con Terraform: [tf-multi-tier-architecture](https://github.com/santos-pardos/tf-multi-tier-architecture).


---

## 2. Monitorización y Eventos en AWS

En esta sección se amplía el enfoque más allá de "solo CloudWatch": se integran **CloudWatch** (métricas y alarmas), **CloudTrail** (auditoría de API) y **EventBridge** (automatización reactiva basada en eventos).

### Amazon CloudWatch

**Amazon CloudWatch** es el servicio nativo de AWS para monitorización. Permite recopilar métricas, crear alarmas, almacenar y consultar logs, y construir dashboards.

#### ¿Qué es CloudWatch?

Servicio que proporciona:

- **Métricas:** datos numéricos sobre recursos (CPU, red, disco, etc.) y métricas personalizadas.
- **Alarmas:** umbrales sobre métricas que disparan acciones (notificaciones SNS, Auto Scaling, etc.).
- **Logs:** centralización de logs de aplicaciones y sistemas (CloudWatch Logs).
- **Dashboards:** paneles gráficos para visualizar métricas y alarmas.

#### Métricas EC2 relevantes

En el namespace **AWS/EC2** se publican, entre otras, las siguientes métricas para instancias EC2 (aplicables directamente al DC01 y al Cliente del reto):

| Métrica | Descripción |
|--------|-------------|
| **CPUUtilization** | Porcentaje de uso de CPU. |
| **NetworkIn** / **NetworkOut** | Bytes entrantes/salientes. |
| **StatusCheckFailed** | Comprueba si la instancia o el sistema fallan (1 = fallo). |
| **DiskReadOps** / **DiskWriteOps** | Operaciones de lectura/escrita en disco (cuando hay volumen EBS). |

Otras útiles: `StatusCheckFailed_Instance`, `StatusCheckFailed_System`, métricas de EBS si usas volúmenes adicionales.

#### Alarmas CloudWatch

- **Umbral:** valor que dispara la alarma (ej. CPU &gt; 80 %).
- **Periodo:** intervalo de agregación de la métrica (ej. 300 segundos).
- **Evaluación:** número de períodos consecutivos que deben cumplir la condición (ej. 1 de 1, o 2 de 2 para evitar falsos positivos).
- **Acciones:** típicamente un **tópico SNS** que envía email o dispara una función Lambda. Opcionalmente Auto Scaling.
- **Estados:** OK, ALARM, INSUFFICIENT_DATA. Las alarmas pasan a ALARM cuando se cumple la condición.

Ejemplos aplicados al reto TechCorp:

- **CPU &gt; 80 %:** alarma sobre `CPUUtilization` para la instancia DC01 (o Cliente) con umbral 80, período 300 s, estadística Average. Acción: notificación SNS.
- **Fallo de estado de instancia:** alarma sobre `StatusCheckFailed` con umbral 1 (cualquier fallo). Útil para detectar problemas de hipervisor o sistema operativo.

#### CloudWatch Logs

- **Centralización de logs:** puedes enviar logs de las instancias (Windows Event Log, aplicaciones) a CloudWatch Logs mediante el **CloudWatch Agent** o el agente unificado.
- **Integración con agentes:** en Windows se instala el agente y se configura qué logs enviar; en el reto puede quedar como ampliación futura si el tiempo se centra en métricas y alarmas nativas.

---

### Amazon CloudTrail (Auditoría)

**Amazon CloudTrail** es un servicio que registra las **llamadas a la API** de AWS: quién hizo qué, sobre qué recurso, cuándo y con qué resultado.

#### ¿Qué es CloudTrail?

- Registra **eventos de gestión** (crear, modificar, eliminar recursos) y, si se habilita, **eventos de datos** (acceso a S3, etc.).
- Cada evento incluye: identidad (usuario, rol, cuenta), servicio, acción, recurso afectado, hora y resultado (éxito o error).

#### Conceptos clave

- **Trail:** configuración que define qué eventos se registran y dónde se almacenan (bucket S3, opcionalmente envío a CloudWatch Logs).
- **Eventos de gestión:** llamadas a APIs que cambian recursos (RunInstances, CreateSecurityGroup, etc.).
- **Eventos de datos:** operaciones sobre datos (GetObject en S3). Su registro puede generar mucho volumen y coste.

#### Integración con S3 y CloudWatch Logs

- Los eventos se almacenan en un **bucket S3** (formato de logs de CloudTrail). Puedes habilitar **entrega a CloudWatch Logs** para analizar con métricas filtradas o para que EventBridge consuma eventos.

#### Aplicación práctica en TechCorp

- **Detectar cambios en Security Groups:** quién modificó las reglas del SG del DC01 o del Cliente.
- **Ver quién lanza instancias:** eventos `RunInstances` en la cuenta/región.
- **Auditoría de cambios en infraestructura AD:** cambios en EC2, VPC o IAM relacionados con el proyecto.

En el reto se puede activar un trail (por consola o con Terraform) y comprobar que, al modificar un Security Group o lanzar una instancia, el evento aparece en CloudTrail.

---

### Amazon EventBridge (Automatización reactiva)

**Amazon EventBridge** es un bus de eventos que permite capturar eventos, aplicar reglas (patterns) y enviarlos a **targets** (Lambda, SNS, SQS, etc.) para automatizar reacciones.

#### ¿Qué es EventBridge?

- **Captura eventos** de fuentes AWS (CloudWatch Events, CloudTrail, servicios como EC2, etc.) o de aplicaciones propias.
- **Reglas:** definen qué eventos interesan (pattern) y a qué target enviarlos.
- **Targets:** funciones Lambda, tópicos SNS, colas SQS, etc.

#### Conceptos clave

- **Event Bus:** canal por el que fluyen los eventos (por defecto el bus de la cuenta).
- **Rule:** nombre, pattern (filtro) y uno o más targets.
- **Pattern:** criterios sobre el evento (servicio, tipo de evento, atributos como tags).
- **Target:** destino de los eventos que coinciden con la regla.

#### Ejemplo aplicado a TechCorp

- **Evento:** creación de instancia EC2 (`RunInstances` vía CloudTrail o evento de estado EC2).
- **Regla:** si el tag `Role` = `"DomainController"` (o `Name` contiene "DC01").
- **Acción:** enviar notificación SNS o invocar una Lambda que registre el evento o ejecute una tarea automatizada.

Relación entre servicios:

- **CloudTrail** genera eventos de API → se pueden enviar a EventBridge (o a CloudWatch Logs).
- **CloudWatch** monitoriza métricas y alarmas → las alarmas pueden disparar SNS o integraciones.
- **EventBridge** automatiza reacciones ante eventos (cambios de recurso, estados de instancia, etc.).

---

## 3. Automatización con Terraform

En esta sección se integra la **monitorización y las notificaciones como código**: alarmas CloudWatch, SNS y, de forma opcional, CloudTrail y EventBridge definidos con Terraform.

### Alarmas CloudWatch con Terraform

El recurso **`aws_cloudwatch_metric_alarm`** permite definir alarmas en código y asociarlas a las instancias creadas por Terraform (referenciando `aws_instance.dc01.id`, etc.). Así, cada vez que se despliegue la infraestructura, las alarmas se crean automáticamente.

Ejemplo: alarma de CPU &gt; 80 % para DC01, con período 300 s, estadística Average y una acción SNS (tópico creado en el apartado SNS para notificaciones).

```hcl
resource "aws_cloudwatch_metric_alarm" "cpu_dc01" {
  alarm_name          = "CPU_Alta_DC01"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarma si CPU DC01 > 80%"
  dimensions = {
    InstanceId = aws_instance.dc01.id
  }
  alarm_actions = [aws_sns_topic.alerta_admin.arn]
}
```

### SNS para notificaciones

El recurso **`aws_sns_topic`** crea un tópico SNS. Con **`aws_sns_topic_subscription`** puedes suscribir un email (u otro endpoint) al tópico. Las alarmas CloudWatch usan `alarm_actions = [aws_sns_topic.alerta_admin.arn]` para enviar la notificación cuando la alarma pasa a ALARM.

```hcl
resource "aws_sns_topic" "alerta_admin" {
  name = "TechCorp-AlertaAdministradores"
}
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerta_admin.arn
  protocol  = "email"
  endpoint  = "admin@ejemplo.com"
}
```

Tras el primer `apply`, confirma la suscripción desde el email recibido.

### Activación básica de CloudTrail con Terraform (opcional guiado)

Con el recurso **`aws_cloudtrail`** puedes definir un trail que registre eventos de gestión en la cuenta. Parámetros típicos: nombre, bucket S3 para los logs (creado previamente o con Terraform), opción **is_multi_region_trail** para multi‑región. Opcionalmente **cloud_watch_logs_group_arn** y **cloud_watch_logs_role_arn** para enviar eventos a CloudWatch Logs. En el reto puede plantearse como tarea guiada (crear bucket, política, trail y comprobar un evento).

### Regla básica EventBridge con Terraform (opcional guiado)

Con **`aws_cloudwatch_event_rule`** (EventBridge rule) y **`aws_cloudwatch_event_target`** puedes definir una regla que reaccione a eventos. Ejemplo conceptual: evento fuente **CloudTrail** (o evento de EC2), pattern que filtre por `RunInstances` o por tag, y target **SNS** para notificación. En el reto puede quedar como ampliación opcional guiada: crear la regla, lanzar una instancia o modificar un SG y ver la notificación o el registro.

---

A continuación, te proponemos un vídeo práctico en el que verás cómo se aplican estos conceptos de automatización y monitorización en AWS usando Terraform, integrando alarmas, notificaciones y herramientas como CloudWatch y SNS. 

Este ejemplo complementa lo explicado anteriormente y te ayudará a visualizar el flujo completo de despliegue, configuración y supervisión automatizada en un entorno real.

<div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; margin-top: 1em; margin-bottom: 1em;">
  <iframe src="https://www.youtube.com/embed/T_Pz1ksb9ng"
          style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
          title="Terraform con AWS — ejemplo práctico"></iframe>
</div>

<p style="text-align: center; font-size: 1.1em; margin-top: 0.5em;">
  Vídeo explicativo en español sobre tres servicios de AWS: monitorización tradicional (CloudWatch), arquitecturas dirigidas a eventos (Event Bridge) y auditorías de seguridad (CloudTrail).
</p>

!!! note "Resumen del vídeo: Monitorización en AWS (CloudWatch, EventBridge, CloudTrail)"
    El vídeo presenta **tres servicios de monitorización y auditoría** en AWS, útiles para prácticas e incluso para concursos AWS. Contenido resumido:

    - **Introducción (0:00–1:00):** Monitorización tradicional, auditorías de seguridad y arquitecturas dirigidas a eventos.
    - **Función Lambda de ejemplo (1:00–4:00):** Se usa una función Lambda (Python, boto3) que para instancias EC2 en la región de Irlanda. Se crea y despliega la función *demo_da* para testearla; al ejecutarla, las dos máquinas se paran. Esto se hace para que la acción quede registrada y se pueda ver después en CloudWatch y CloudTrail.
    - **CloudWatch — monitorización tradicional (4:00–14:30):**
        - **Métricas:** Consulta de métricas de la cuenta (balanceadores, contenedores, bases de datos, etc.); agregar métricas a **tableros de monitorización** y crear widgets.
        - **Alarmas:** Crear una alarma a partir de una métrica (umbral, por ejemplo 10.000), configurar notificaciones vía **SNS** (ej. correo) para cuando se dispare la alarma.
        - **Grupos de logs:** Los logs de la función Lambda aparecen en CloudWatch (memoria, CPU, tiempo de ejecución, facturación). **Log Insights** permite consultar logs con un lenguaje tipo consulta (no SQL) y humanizar la visualización; se pueden agregar resultados al panel. Se mencionan **Open Search** y **Amazon Managed Grafana** para entornos con muchos logs (no disponibles en AWS Academy).
        - Muchos servicios (EC2, RDS, Lambda, etc.) envían métricas a CloudWatch por defecto; desde cada servicio se puede *Añadir a un tablero*.
        - **Eventos** en CloudWatch: se comenta que ha pasado a llamarse **Event Bridge**.
    - **Event Bridge — arquitecturas dirigidas a eventos (14:30–18:10):** Reglas y buses de eventos: se selecciona un **evento** (p. ej. “instancia EC2 terminada”) como origen y un **destino** (p. ej. Datadog o una pipeline) como respuesta. Así se construyen workflows que reaccionan a eventos (p. ej. levantar otra EC2 si se borra una). En AWS Academy no permite crear reglas, pero se muestra el asistente de creación.
    - **CloudTrail — auditorías de seguridad (18:10–fin):** Registra **quién** ha hecho **qué** en **qué momento**. En **Event history** (últimos 90 días) se ve, por ejemplo, que las instancias fueron paradas por la función Lambda *demod* con su rol. Para cuentas reales se explica crear un **Trail** y guardar todos los eventos de todas las regiones en un bucket S3 (encriptado con KMS) para auditoría y cumplimiento. Los eventos son densos; para analizarlos bien se recomienda enviarlos a Open Search, Grafana o servicios similares.

!!! tip "Repositorios de ejemplo Terraform en AWS"
    Para practicar lo mostrado en el vídeo puedes usar estos repositorios públicos de GitHub:
    
    - Ejemplo básico EC2: [tf-ec2](https://github.com/santos-pardos/tf-ec2).
    - Ejemplos variados (hello-world, webserver, cluster, S3, módulos): [terraform-aws-examples](https://github.com/santos-pardos/terraform-aws-examples).
    - Arquitectura multi-nivel (VPC, ALB, ASG, RDS): [tf-multi-tier-architecture](https://github.com/santos-pardos/tf-multi-tier-architecture).



---

## Actividades
<!-- **Tarea opcional avanzada:**  
- Crear y enviar una métrica personalizada con namespace `TechCorp/AD` usando la CLI de AWS y visualizarla en CloudWatch.

!!! tip "Antes del reto"
    Asegúrate de tener cuenta AWS con permisos para EC2, VPC, CloudWatch, SNS y, si aplica, CloudTrail y EventBridge. Terraform y AWS CLI instalados y configurados. El código del proyecto TechCorp (apartado «Proyecto TechCorp» del tema 7) te sirve de base para la Fase 1. -->

### RG701: Infraestructura y Active Directory (TechCorp) — 60 puntos

**Duración estimada:** 1,5 h (2 fases de ~45 min). **Modalidad:** Individual o en parejas. **Criterios:** CE3d, CE3e, CE3h.

Despliegue en AWS de una arquitectura mínima para Active Directory (TechCorp):

- **Fase 1:** Infraestructura con Terraform:
    - VPC
    - Subred
    - Security Group
    - DHCP
    - Instancia EC2 DC01
    - Instancia EC2 Cliente

- **Fase 2:** Configuración de Active Directory:
    - Instalación de Active Directory en DC01
    - Creación de OUs (Unidades Organizativas)
    - Creación de usuarios (por ejemplo, desde un archivo CSV)
    - Unión del Cliente al dominio

- La infraestructura se define con Terraform (IaC).
- La configuración interna puede automatizarse con scripts de PowerShell (usando `user_data`, SSM o `remote-exec`).

[:octicons-tag-24: Ver enunciado completo — RG701 (TechCorp)](RetoPracticoTechCorp.md){ .md-button }

---

### RG702: Monitorización y auditoría (TechCorp) — **Ampliación +0,25 de la nota final.**

**Duración estimada:** 1,5 h (2 fases de ~45 min). **Modalidad:** Individual o en parejas. **Criterios:** CE3f, CE3g, CE3h, Objetivo 15.

Sobre el entorno TechCorp ya desplegado (RG701 o equivalente), realiza las siguientes fases:

- **Fase 3:**  
    - Configura alarmas en CloudWatch para:  
        - CPU > 80 %  
        - StatusCheckFailed  
    - Visualiza las métricas correspondientes.
    - (Opcional) Crea un dashboard para monitorización.

- **Fase 4:**
    - Habilita CloudTrail para registrar eventos de gestión.
    - Comprueba quién ha realizado cada acción en la cuenta.
    - (Opcional)  
        - Crea una regla en EventBridge para reaccionar ante eventos específicos.
        - Envía una métrica personalizada al namespace `TechCorp/AD`.

[:octicons-tag-24: Ver enunciado completo — RG702 (TechCorp)](RetoPracticoTechCorp2.md){ .md-button }

