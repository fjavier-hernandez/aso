---
title: Rúbrica de Evaluación - Reto Grupal PowerShell
description: Criterios de evaluación detallados para el reto grupal de PowerShell
subtitle: Rúbrica Evaluación Reto PowerShell
---

# RÚBRICA DE EVALUACIÓN - RETO GRUPAL POWERSHELL
## Sistema de Gestión de Servicios de Windows

### INFORMACIÓN GENERAL
- **Asignatura:** Administración de Sistemas Operativos (ASO)
- **Unidad:** PowerShell
- **Tipo de actividad:** Reto Grupal
- **Peso en la calificación:** 30 puntos (sobre 100)
- **Modalidad:** Trabajo en grupo (2 estudiantes)
- **Defensa del proyecto:** Obligatoria, duración 20-30 minutos

---

## CRITERIOS DE EVALUACIÓN

### 1. FUNCIONALIDAD (15 puntos)

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente (13-15)** | 13-15 | ✅ Sistema completamente funcional<br/>✅ Todas las funcionalidades requeridas implementadas<br/>✅ Sin errores de ejecución<br/>✅ Manejo correcto de errores con `try-catch` |
| **Bueno (10-12)** | 10-12 | ✅ Sistema funcional con pequeñas limitaciones<br/>✅ Mayoría de funcionalidades implementadas<br/>⚠️ Algunos errores menores<br/>⚠️ Funcionalidades básicas operativas |
| **Satisfactorio (7-9)** | 7-9 | ⚠️ Sistema parcialmente funcional<br/>⚠️ Funcionalidades principales implementadas<br/>❌ Algunos errores importantes<br/>❌ Limitaciones en el funcionamiento |
| **Insuficiente (0-6)** | 0-6 | ❌ Sistema no funcional o con errores críticos<br/>❌ Pocas funcionalidades implementadas<br/>❌ Múltiples errores de ejecución<br/>❌ No cumple requisitos básicos |

**Funcionalidades requeridas:**

- ✅ Menú principal interactivo
- ✅ Gestión CRUD de servicios
- ✅ Monitoreo con cmdlets de PowerShell
- ✅ Sistema de backups con `Compress-Archive`
- ✅ Gestión de logs
- ✅ Configuración del sistema

---

### 2. ESTRUCTURA DEL CÓDIGO (5 puntos)

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente (5)** | 5 | ✅ Código perfectamente organizado y modular<br/>✅ Comentarios detallados en cada línea<br/>✅ Separación clara de responsabilidades<br/>✅ Nombres de funciones siguiendo convención Verbo-Sustantivo |
| **Bueno (4)** | 4 | ✅ Código bien organizado<br/>✅ Comentarios adecuados<br/>✅ Buena modularización<br/>⚠️ Algunos aspectos mejorables |
| **Satisfactorio (3)** | 3 | ⚠️ Código organizado pero con limitaciones<br/>⚠️ Comentarios básicos<br/>⚠️ Modularización parcial<br/>❌ Algunos problemas de estructura |
| **Insuficiente (0-2)** | 0-2 | ❌ Código desorganizado<br/>❌ Falta de comentarios<br/>❌ Sin modularización<br/>❌ Difícil de entender y mantener |

**Aspectos evaluados:**

- ✅ Modularización en archivos separados (`.ps1`)
- ✅ Comentarios explicativos detallados
- ✅ Organización lógica del código
- ✅ Nomenclatura clara siguiendo convenciones PowerShell (Verbo-Sustantivo)

---

### 3. USO DE CONCEPTOS POWERSHELL (5 puntos)

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente (5)** | 5 | ✅ Uso avanzado de todas las técnicas<br/>✅ Variables tipadas correctamente<br/>✅ Bucles, funciones y estructuras bien implementadas<br/>✅ Uso adecuado de cmdlets de PowerShell<br/>✅ Trabajo correcto con objetos y colecciones |
| **Bueno (4)** | 4 | ✅ Uso correcto de técnicas principales<br/>✅ Buena implementación de conceptos<br/>⚠️ Algunas técnicas básicas |
| **Satisfactorio (3)** | 3 | ⚠️ Uso básico de técnicas<br/>⚠️ Implementación funcional pero limitada<br/>❌ Algunos conceptos mal aplicados |
| **Insuficiente (0-2)** | 0-2 | ❌ Uso incorrecto de técnicas<br/>❌ Conceptos mal implementados<br/>❌ Falta de aplicación de conocimientos |

**Técnicas evaluadas:**

- ✅ Variables con tipado implícito y explícito
- ✅ Estructuras de control (if, switch, while, for, foreach)
- ✅ Funciones con parámetros tipados
- ✅ Cmdlets de PowerShell (Get-Service, Start-Service, Get-Process, etc.)
- ✅ Trabajo con objetos y colecciones
- ✅ Operadores de PowerShell (comparación, lógicos, tipo)
- ✅ Manejo de archivos CSV con `Import-Csv` y `Export-Csv`

---

### 4. DOCUMENTACIÓN (3 puntos)

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente (3)** | 3 | ✅ README.md completo y profesional<br/>✅ Instrucciones claras de instalación y uso<br/>✅ Documentación de cada módulo<br/>✅ Capturas de pantalla incluidas |
| **Bueno (2)** | 2 | ✅ README.md adecuado<br/>✅ Instrucciones básicas<br/>⚠️ Documentación parcial |
| **Satisfactorio (1)** | 1 | ⚠️ README.md básico<br/>⚠️ Instrucciones limitadas<br/>❌ Documentación insuficiente |
| **Insuficiente (0)** | 0 | ❌ Sin README.md o muy básico<br/>❌ Sin instrucciones<br/>❌ Sin documentación |

**Elementos requeridos:**

- ✅ Descripción del proyecto
- ✅ Instrucciones de instalación
- ✅ Guía de uso
- ✅ Explicación de módulos
- ✅ Capturas de pantalla
- ✅ Información sobre política de ejecución de scripts

---

### 5. DEFENSA DEL PROYECTO Y TESTING (2 puntos)

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente (2)** | 2 | ✅ Demostración fluida y completa del sistema<br/>✅ Testing exhaustivo de todas las funcionalidades<br/>✅ Explicación clara del código y decisiones de diseño<br/>✅ Respuestas precisas a todas las preguntas<br/>✅ Duración adecuada (20-30 minutos) |
| **Bueno (1.5)** | 1.5 | ✅ Buena demostración del sistema<br/>✅ Testing de funcionalidades principales<br/>✅ Explicación adecuada del código<br/>⚠️ Algunas dudas en las respuestas |
| **Satisfactorio (1)** | 1 | ⚠️ Demostración básica del sistema<br/>⚠️ Testing limitado de funcionalidades<br/>⚠️ Explicación parcial del código<br/>❌ Dificultades para responder algunas preguntas |
| **Insuficiente (0-0.5)** | 0-0.5 | ❌ Demostración incompleta o con errores<br/>❌ Testing insuficiente o ausente<br/>❌ Explicación confusa o ausente<br/>❌ No responde adecuadamente a las preguntas<br/>❌ Duración inadecuada |

**Aspectos evaluados en la defensa:**

- ✅ **Demostración en vivo** del sistema funcionando
  - Ejecución sin errores
  - Navegación fluida por el menú
  - Funcionalidades operativas en tiempo real
  
- ✅ **Testing de funcionalidades**
  - Pruebas de gestión CRUD de servicios
  - Verificación de monitoreo del sistema
  - Pruebas de sistema de backups
  - Validación de gestión de logs
  - Testing de manejo de errores
  
- ✅ **Explicación del código**
  - Comprensión de la estructura modular
  - Explicación de funciones principales
  - Justificación de decisiones de diseño
  - Uso correcto de conceptos PowerShell
  
- ✅ **Respuesta a preguntas**
  - Claridad en las respuestas
  - Conocimiento del código implementado
  - Capacidad para explicar conceptos técnicos
  
- ✅ **Duración y organización**
  - Presentación estructurada
  - Uso adecuado del tiempo (20-30 minutos)
  - Preparación previa evidente

**Preparación recomendada para los estudiantes:**

- Probar todas las funcionalidades antes de la defensa
- Preparar ejemplos de uso para cada módulo
- Documentar casos de prueba y resultados esperados
- Revisar el código para poder explicarlo
- Preparar demostraciones de las funcionalidades principales
- Anticipar posibles preguntas del profesor

---

## PUNTOS EXTRA (Hasta +8 puntos)

| Funcionalidad | Puntos | Descripción |
|---------------|--------|-------------|
| **Interfaz Gráfica** | +3 | Sistema de interfaz gráfica con Windows Forms |
| **Event Viewer** | +2 | Integración completa con Event Viewer de Windows |
| **Gráficos ASCII** | +2 | Estadísticas visuales con caracteres ASCII |
| **Notificaciones** | +1 | Notificaciones del sistema Windows |
| **Exportación HTML/XML** | +1 | Exportación de informes a HTML o XML |

---

## CALIFICACIÓN FINAL

### Distribución de Puntos:

- **Funcionalidad:** 15 puntos
- **Estructura del Código:** 5 puntos
- **Uso de Conceptos PowerShell:** 5 puntos
- **Documentación:** 3 puntos
- **Defensa del Proyecto y Testing:** 2 puntos
- **Total:** 30 puntos

### Escala de Calificación:

- **Sobresaliente (9-10):** 27-30 puntos
- **Notable (7-8.9):** 21-26 puntos  
- **Bien (6-6.9):** 18-20 puntos
- **Suficiente (5-5.9):** 15-17 puntos
- **Insuficiente (0-4.9):** 0-14 puntos

### Fórmula de Cálculo:
```
Calificación = (Puntos Obtenidos / 30) × 10
```

---

## OBSERVACIONES PARA EL PROFESOR

### Aspectos a Evaluar Especialmente:

1. **Funcionalidad completa** del sistema
2. **Calidad del código** y comentarios
3. **Aplicación correcta** de conceptos PowerShell
4. **Uso adecuado de cmdlets** y objetos
5. **Documentación profesional** del proyecto
6. **Convenciones de nomenclatura** PowerShell (Verbo-Sustantivo)
7. **Defensa del proyecto** con testing y explicación del código

### Criterios de Desempate:

1. Calidad de la defensa del proyecto y testing
2. Calidad de los comentarios en el código
3. Originalidad en las funcionalidades extra
4. Presentación del proyecto en clase
5. Trabajo colaborativo del grupo
6. Uso correcto de tipado de variables

### Recomendaciones:

- Evaluar el código línea por línea para verificar comentarios
- Probar todas las funcionalidades del sistema
- Verificar que el README.md sea completo y útil
- Valorar especialmente las mejoras creativas
- Comprobar el uso correcto de cmdlets de PowerShell
- Verificar el manejo de errores con `try-catch`
- Durante la defensa, observar la capacidad de los estudiantes para:
  - Demostrar el sistema en funcionamiento
  - Realizar testing de las funcionalidades
  - Explicar el código y decisiones de diseño
  - Responder preguntas técnicas sobre la implementación

---

**Fecha de creación:** Octubre 2024  
**Versión:** 1.2 (Ajustada a 30 puntos, eliminado criterio de Creatividad)  
**Profesor:** [Nombre del profesor]  
**Asignatura:** ASO - PowerShell

---

## RÚBRICA GENERAL PARA MOODLE

La siguiente rúbrica está diseñada para ser configurada fácilmente en la plantilla de Moodle y poder reutilizarse o adaptarse a diferentes trabajos o retos grupales/prácticos de PowerShell (o cualquier otra asignatura TIC).

| Criterio                           | Excelente (5)                              | Notable (4)                        | Bien (3)                           | Suficiente (2)                    | Insuficiente (1)        |
|-------------------------------------|--------------------------------------------|------------------------------------|------------------------------------|------------------------------------|-------------------------|
| **Funcionalidad/Entrega**           | Cumple todos los requisitos del enunciado. | Cumple casi todos, mínimos detalles faltan. | Cumple la mayoría, pero faltan partes menores. | Entrega incompleta, solo lo básico. | No cumple el objetivo.  |
| **Estructura y Organización**       | Código muy claro, bien modular y organizado.| Código claro, mínimas mejoras posibles. | Bastante estructurado, podría mejorar. | Desordenado, poco modular.        | Caótico o difícil seguir.|
| **Documentación/Comentarios**       | Comentarios completos y útiles; README excelente. | Buenos comentarios y documentación. | Comentarios adecuados y algo de documentación. | Escasos comentarios/documentación. | Sin comentarios ni guías.|
| **Uso de Conceptos PowerShell**    | Excelente uso y combinación de conceptos clave. | Muy buen uso de la mayoría de conceptos. | Uso satisfactorio, algunos errores leves. | Conceptos básicos, faltan varios. | Mal uso o ausencia de conceptos.|
| **Calidad Técnica (Errores, funcionamiento, robustez)** | Sin errores, manejo excelente de entradas, robusto. | Solo errores menores, buen control de entradas. | Pocos fallos, el sistema funciona en la mayoría de pruebas. | Errores frecuentes o falta robustez. | Muchos errores, no funciona.    |
| **Presentación/Entrega**            | Archivos bien estructurados, README perfecto, instrucciones claras. | Entrega ordenada, README correcto. | Presentación adecuada, README mejorable. | Entrega incompleta o mal presentada. | Desorganizado, README ausente.|
| **Defensa del Proyecto/Testing**    | Demostración fluida, testing exhaustivo, explicación clara, respuestas precisas (20-30 min). | Buena demostración, testing adecuado, explicación correcta. | Demostración básica, testing limitado, explicación parcial. | Demostración incompleta, testing insuficiente. | Demostración con errores, sin testing, explicación confusa.|

### Escalas y ponderación sugeridas

- Puedes asignar diferente valor a cada criterio conforme a las exigencias del reto.
  - Ejemplo de ponderación:
      - Funcionalidad: 30%
      - Estructura/Organización: 15%
      - Documentación: 10%
      - Uso de Conceptos: 15%
      - Calidad Técnica: 15%
      - Presentación: 5%
      - Defensa del Proyecto/Testing: 10%
- Transforma la suma ponderada a la escala numérica deseada (por defecto sobre 10).

### Cómo usar en Moodle

1. Copia la tabla anterior en el campo "Rúbrica" de la tarea o foro.
2. Ajusta criterios, descripciones o ponderaciones según el trabajo.
3. Asigna la puntuación para cada fila y nivel en Moodle (puedes usar 1-5 puntos por nivel).
4. Deja un espacio para comentarios del profesor.

---

**Nota:** 
Esta rúbrica puede ser adaptada y evolucionada en función de las experiencias de evaluación y características concretas de la tarea o reto práctico.

