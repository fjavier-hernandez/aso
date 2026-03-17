---
title: RG702 — Monitorización y auditoría (TechCorp)
description: Reto práctico de ~1,5 h: alarmas CloudWatch, métricas, CloudTrail y opcionalmente EventBridge sobre el entorno TechCorp.
subtitle: Reto Automatización y Monitorización
---

# RG702: Monitorización y auditoría (TechCorp)

- **Modalidad:** Individual o en parejas (según criterio del profesor).
- **Duración estimada:** 1,5 horas (2 fases de ~45 min).
- **Puntuación:** 30 puntos.
- **Criterios evaluados:** CE3f, CE3g (monitorización), CE3h (documentación), Objetivo 15 (técnicas de monitorización e interpretación de resultados).
- **Entorno:** Cuenta AWS con el entorno TechCorp ya desplegado (DC01 y Cliente en EC2), o haber completado el [RG701 — TechCorp](RetoPracticoTechCorp.md).

## Objetivos

Al finalizar el reto serás capaz de:

- Crear alarmas en CloudWatch sobre uso de CPU y estado de la instancia EC2 (StatusCheckFailed).
- Visualizar métricas y alarmas en la consola de CloudWatch y, opcionalmente, en un dashboard.
- Activar CloudTrail, realizar una acción (p. ej. modificar un Security Group) y comprobar que el evento queda registrado.
- Opcionalmente: crear una regla básica en EventBridge y enviar una métrica personalizada (namespace TechCorp/AD) desde la CLI.

## Requisitos previos

- **Entorno TechCorp en marcha:** instancias EC2 DC01 y Cliente creadas (por el [RG701](RetoPracticoTechCorp.md) o manualmente). No es necesario que AD esté totalmente configurado para las fases de monitorización y auditoría.
- **Cuenta AWS** con permisos para CloudWatch, SNS, CloudTrail y, si aplica, EventBridge.
- **AWS CLI** configurado (`aws sts get-caller-identity`) para la parte opcional de métrica personalizada.

---

## Fase 3 — Monitorización (45 min)

### Objetivo

Crear alarmas CloudWatch para CPU > 80 % y para StatusCheckFailed. Ver las métricas en CloudWatch y, opcionalmente, provocar carga de CPU para comprobar que la alarma cambia de estado.

### Pasos

1. **Crear alarma CPU > 80 %**  
   En la consola de CloudWatch (o con Terraform, tema 7), crea una alarma sobre la métrica **CPUUtilization** del namespace **AWS/EC2** para la instancia DC01 (o Cliente). Configura umbral 80 %, período 300 segundos, estadística Average. Asocia una acción SNS si quieres recibir notificación por email (crea antes un tópico SNS y suscríbete).

2. **Crear alarma StatusCheckFailed**  
   Crea otra alarma sobre **StatusCheckFailed** para la misma instancia (o ambas). Umbral 1 (cualquier fallo de estado). Así detectas problemas de hipervisor o sistema.

3. **Ver métricas en CloudWatch**  
   En CloudWatch → Métricas → EC2, selecciona las instancias DC01 y Cliente y revisa CPUUtilization, NetworkIn/NetworkOut y StatusCheckFailed. Opcionalmente crea un dashboard sencillo con estas métricas.

4. **Probar carga de CPU (opcional)**  
   En una de las instancias, genera carga de CPU (por ejemplo con un bucle en PowerShell o con una herramienta de estrés). Espera unos minutos y comprueba en CloudWatch que la métrica sube y que la alarma pasa a estado ALARM si superas el 80 %.

### Entregable de la fase

- Alarmas creadas (captura de configuración o código Terraform). Captura del gráfico de métricas en CloudWatch y, si aplica, del estado de la alarma al generar carga.

---

## Fase 4 — Auditoría y eventos (45 min)

### Objetivo

Activar CloudTrail y comprobar que las acciones en la cuenta quedan registradas. Opcionalmente crear una regla básica en EventBridge. Opcional (nivel avanzado): enviar una métrica personalizada con namespace TechCorp/AD y visualizarla en CloudWatch.

### Pasos

1. **Activar CloudTrail**  
   Crea un trail en CloudTrail (consola o Terraform, tema 7). Necesitas un bucket S3 para los logs (crea uno si no existe y configura la política que CloudTrail indica). Activa el trail (multi‑región si lo deseas). No es obligatorio enviar a CloudWatch Logs para esta fase.

2. **Realizar una acción y ver el evento**  
   Realiza una acción que modifique infraestructura, por ejemplo: cambia una regla de entrada del Security Group del DC01 (añade o quita un puerto temporal). Espera unos minutos y en CloudTrail → **Registro de eventos** (o en el bucket S3) busca el evento correspondiente (p. ej. `AuthorizeSecurityGroupIngress` o `RevokeSecurityGroupIngress`). Comprueba que aparece quién ejecutó la acción, cuándo y sobre qué recurso.

3. **Regla básica EventBridge (opcional)**  
   Crea una regla en EventBridge que reaccione a un evento de CloudTrail (por ejemplo `RunInstances`) o a un evento de estado de EC2. Como target usa un tópico SNS para recibir una notificación. Prueba lanzando una instancia de prueba o cambiando el estado de una instancia y comprueba que recibes el evento o la notificación. Documenta brevemente la regla (pattern y target).

4. **Métrica personalizada (opcional, nivel avanzado)**  
   Desde AWS CLI, envía una métrica personalizada a CloudWatch:
   ```bash
   aws cloudwatch put-metric-data \
     --namespace "TechCorp/AD" \
     --metric-name "UsuariosActivos" \
     --value 5 \
     --dimensions InstanceId=i-xxxxxxxxx
   ```
   Sustituye `i-xxxxxxxxx` por el ID de la instancia DC01. En CloudWatch → Métricas → Métricas personalizadas, busca el namespace **TechCorp/AD** y visualiza la métrica. Puedes repetir con distintos valores para ver la serie temporal.

### Entregable de la fase

- Trail de CloudTrail activo. Captura o descripción del evento visto en CloudTrail tras modificar el Security Group. Si se ha hecho: descripción de la regla EventBridge y captura de la métrica personalizada en CloudWatch.

---

## Entregables globales del RG702

1. **Código Terraform** (si has definido alarmas, SNS, CloudTrail o EventBridge en IaC) o capturas de la consola de AWS mostrando la configuración de alarmas y del trail.
2. **Resumen o capturas** de la Fase 3 (alarmas y métricas en CloudWatch) y de la Fase 4 (evento en CloudTrail y, si aplica, regla EventBridge y métrica personalizada).

## Criterios de evaluación (30 puntos)

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| **Fase 3 — Monitorización** | 15 | Alarmas CloudWatch creadas (CPU y StatusCheckFailed); métricas consultadas en CloudWatch; opcionalmente dashboard. |
| **Fase 4 — Auditoría y eventos** | 10 | CloudTrail activo y evento registrado; opcionalmente EventBridge y métrica personalizada. |
| **Documentación** | 5 | Capturas o descripción clara de la configuración y de los resultados (CE3h). |
| **Total** | **30** | |

## Referencias

- [RG701 — TechCorp (Fases 1 y 2)](RetoPracticoTechCorp.md): despliegue con Terraform e instalación de Active Directory.
- [07 Automatización y monitorización](07AutomatizacionMonitorizacion.md): teoría de CloudWatch, CloudTrail y EventBridge.
- [Amazon CloudWatch](https://docs.aws.amazon.com/cloudwatch/), [AWS CloudTrail](https://docs.aws.amazon.com/cloudtrail/), [Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/).
