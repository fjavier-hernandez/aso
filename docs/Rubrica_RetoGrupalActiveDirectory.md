# Rúbrica del Reto Grupal: Active Directory Completo — TechCorp Solutions

Esta rúbrica permite evaluar el **Reto Grupal Active Directory** en Aules. El archivo CSV asociado se puede importar directamente en una tarea siguiendo las instrucciones de [Importación de rúbricas en formato CSV (Aules)](https://portal.edu.gva.es/aules/es/importacio-de-rubriques-en-format-csv-es/).

---

## Datos de la tarea en Aules

- **Puntuación máxima de la tarea:** 30 (debe coincidir con la suma máxima de la rúbrica).
- **Archivo CSV:** `Rubrica_RetoGrupalActiveDirectory.csv`
- **Codificación del CSV:** UTF-8.

---

## Estructura de la rúbrica

La rúbrica tiene **9 criterios**, cada uno con **3 niveles** (No conseguido, Parcial, Conseguido). La puntuación total máxima es **30 puntos**.

| Criterio | Puntos máximos | Descripción breve |
|----------|----------------|-------------------|
| Dominio AD instalado y DC funcionando | 3 | Instalación del rol AD DS y promoción a controlador de dominio. |
| OUs creadas correctamente | 2 | OU raíz TechCorp y sub-OUs por departamento (Gerencia, IT, Administracion, Comercial, RRHH). |
| 20 usuarios creados desde CSV en sus OUs | 5 | Creación de los 20 usuarios desde CSV en la OU correspondiente. |
| Grupos creados y usuarios asignados | 3 | Grupos por departamento y asignación de usuarios a su grupo. |
| Cliente unido al dominio y RDP funcionando | 3 | Cliente unido al dominio y acceso RDP para Domain Users. |
| Recursos compartidos y carpetas personales | 5 | Carpetas TechCorp_Users y TechCorp_Datos compartidas y carpetas personales (unidad X:) asignadas. |
| GPO de contraseñas y bloqueo configuradas | 3 | Directiva de contraseña (vigencia, historial, longitud) y bloqueo de cuenta. |
| Verificación exitosa y documentación | 3 | Documento con capturas y salida del script de verificación. |
| Uso de PowerShell (automatización) | 3 | Uso correcto de los scripts 02-CrearEstructuraAD.ps1 y 04-RecursosCompartidos.ps1. |

---

## Niveles por criterio

Para cada criterio se aplican tres niveles:

- **No conseguido (0 o 0 puntos):** El aspecto no se ha trabajado o está incorrecto.
- **Parcial (puntuación intermedia):** El aspecto está abordado de forma incompleta o con errores.
- **Conseguido (puntuación máxima del criterio):** El aspecto se cumple según el enunciado del reto.

Las puntuaciones intermedias (Parcial) permiten valorar trabajos que no llegan al nivel completo pero sí muestran parte del trabajo realizado.

---

## Importación en Aules

1. Crear la tarea y fijar **puntuación máxima 30**.
2. Abrir la tarea y activar el **modo de edición**.
3. Añadir el bloque **«Importar rúbrica desde CSV»**.
4. Cargar el archivo `Rubrica_RetoGrupalActiveDirectory.csv` (codificación UTF-8).
5. Revisar la vista previa y guardar la rúbrica como efectiva.

---

## Relación con el reto

La rúbrica corresponde al documento [Reto Grupal Active Directory](RetoGrupalActiveDirectory.md) (TechCorp Solutions), que integra las prácticas PR401, PR402, PR403 y PR404 en un único ejercicio de 2 horas con automatización mediante PowerShell.
