# AGENTS.md

Instrucciones para los agentes (Cursor y otros) que trabajen en este repositorio. Léelas antes de tocar nada y síguelas en cada tarea.

## Objetivo del repositorio

Este repositorio contiene los apuntes, retos y rúbricas del módulo profesional **Administración de Sistemas Operativos (ASO)** del ciclo formativo de grado superior de **Administración de Sistemas Informáticos en Red (ASIR)**, segundo curso. Se publican con MkDocs (tema Material) en GitHub Pages: <https://fjavier-hernandez.github.io/aso/>.

El repositorio es **público**: todo lo que se suba, aunque no aparezca en la web, puede leerlo cualquiera.

**Ramas**: el código fuente está en `main`. La rama por defecto del repositorio es `gh-pages`, que solo contiene la web generada; **no se trabaja en ella**. Las ramas de trabajo salen de `main` y las PR van contra `main`.

## Estructura

| Ruta | Contenido | ¿Se publica en la web? |
| --- | --- | --- |
| `mkdocs.yml` | Configuración del sitio y navegación (`nav`). | Define la web |
| `docs/index.md` | Portada del módulo. | Sí |
| `docs/01ShellScript.md` … `docs/08ServidoresImpresion.md` | Un fichero por unidad: Shell Script, PowerShell, acceso remoto, Active Directory, integración de sistemas, procesos, automatización y monitorización, y servidores de impresión. | Sí (en la `nav`) |
| `docs/Practica*.md`, `docs/Reto*.md`, `docs/Rubrica_*.md` y `.csv` | Prácticas, retos individuales y grupales y sus rúbricas. | Se construyen todos, aunque no estén en la `nav` |
| `docs/ACsSol/` | Scripts de actividades de clase (`ejNNN.sh`). | Sí, como ficheros descargables |
| `docs/ProgramacionAula.md`, `docs/RAsASO.md`, `docs/planning.md` | Programación de aula, RA del módulo y planificación. | Se construyen |
| `docs/imagenes/`, `docs/stylesheets/` | Imágenes y estilos. | Sí |

Este repositorio no tiene `exclude_docs`: todo lo que esté en `docs/` acaba en la web aunque no esté en la `nav`. Lo que no deba verse va fuera de `docs/` o se excluye explícitamente.

## Compilar en local

Para comprobar el sitio en local:

```bash
pip install "mkdocs-material[imaging]" mkdocs-print-site-plugin
mkdocs build --strict
mkdocs serve
```

`mkdocs build --strict` no debe dar avisos de enlaces rotos. Ten en cuenta que MkDocs construye **todos** los ficheros de `docs/`, aunque no estén en la `nav`: lo que no deba verse tiene que ir en `exclude_docs` o fuera de `docs/`.

## Estilo de los apuntes

- Escribe en **castellano**, con frases completas y bien construidas.
- **Todo bien explicado, aunque el texto crezca.** Cada concepto se presenta, se explica y, cuando ayude, se acompaña de un ejemplo. Es preferible un párrafo más largo y claro que uno corto que obligue al alumnado a buscar fuera.
- **Nada de texto telegráfico**: no se encadenan fragmentos sin verbo, flechas o listas de palabras sueltas en lugar de explicaciones.
- **Nada de tono coloquial**: registro académico, cercano pero correcto, sin muletillas, sin bromas y sin expresiones de chat.
- **Siglas**: la primera vez que aparecen en cada tema se escriben completas, con la sigla entre paréntesis, por ejemplo «red de área local (LAN)». Después se puede usar solo la sigla.
- **No repetir lo ya visto**: si un concepto se explicó en otro tema, se enlaza a ese apartado (enlace relativo con ancla) con una frase de recordatorio, en lugar de volver a explicarlo.
- Usa los elementos de Material con mesura: admoniciones (`!!! note`, `!!! tip`, `!!! warning`) para los avisos y bloques de código con el lenguaje indicado.

## Imágenes y diagramas

- Las **capturas que se leen mal** (borrosas, pequeñas, con texto ilegible o con datos que no deben verse) se **rehacen como diagramas SVG** propios y se guardan junto al tema, en su carpeta `img/`.
- Las **fotos reales** de equipos o materiales llevan **crédito** (autor, fuente y licencia) en el pie de la figura.
- Toda imagen lleva un texto alternativo (`alt`) descriptivo.
- No se suben imágenes sin licencia de uso.

## Soluciones y autoevaluación

- Las **soluciones del Autocheck**, de las prácticas y de los retos **no se publican antes de la fecha de entrega**. Mientras tanto se guardan fuera de `docs/` o en una ruta excluida con `exclude_docs`.
- Las **claves y soluciones de exámenes y pruebas no se publican nunca**, ni en la web ni en el repositorio.
- Si no conoces la fecha de entrega, no publiques la solución y pregunta.

## Datos personales: nunca

El repositorio es público y todo lo que se suba puede leerlo cualquiera. **Nunca** se escriben ni se suben:

- horarios del profesorado o de los grupos;
- nombres, notas, listas o cualquier otro dato del **alumnado** o de sus familias;
- **DNI**, NIA, correos o teléfonos personales;
- **firmas** o documentos firmados;
- rutas locales del ordenador del profesor (OneDrive, Descargas, etc.), credenciales, tokens ni claves.

Si una tarea necesita esos datos, se trabaja fuera del repositorio. Si encuentras alguno ya subido, avísalo en la descripción de la PR en vez de dejarlo pasar.

## Evaluación

- La evaluación es **competencial** y tiene como referentes los **resultados de aprendizaje (RA)**. La nota se calcula por RA, con los pesos que fija la programación didáctica (PD).
- Los **criterios de evaluación (CE)** solo sirven para **verificar la cobertura**, es decir, para comprobar qué actividades o instrumentos evidencian cada CE. **No** llevan porcentajes ni pesos propios.
- No se usa la palabra «criterial» en ningún documento.
- Los RA y los CE se copian literalmente de la normativa del módulo; no se inventan ni se renombran.

## Forma de trabajar con Git

- Trabaja siempre en una **rama nueva** con un nombre descriptivo. Nunca hagas commit directamente en la rama por defecto.
- Cuando termines, abre una **pull request (PR)** con un resumen claro de lo que cambia y por qué.
- **No fusiones** la PR: la revisa y la acepta el profesor.
- No despliegues el sitio (`deploy.sh`, `mkdocs gh-deploy`) salvo que se pida expresamente.
- Antes de abrir la PR, ejecuta `mkdocs build --strict` y revisa que en el diff no haya datos personales ni soluciones que no deban publicarse.

## Word de la programación didáctica

Si existe `Planificación/build_docx.sh`, el Word de la PD se genera desde la raíz del repositorio con:

```bash
bash Planificación/build_docx.sh
```

Necesita `pandoc` y `python3` (con `python-docx`). El script usa `reference.docx` y los filtros de `Planificación/` para el formato, el índice con hipervínculos y las tablas. Edita siempre el Markdown de la PD y vuelve a generar el Word; no edites el `.docx` a mano. Si el script no existe en este repositorio, no lo crees sin que se pida.

## Específico de este repositorio

- **Módulo y ciclo**: Administración de Sistemas Operativos, 2.º de ASIR (grado superior).
- **Unidades**: ocho unidades, en ficheros planos dentro de `docs/` (no hay un directorio por tema). Si se reorganiza, se hace en una PR propia y se actualiza esta sección.
- **Pesos de los RA**: los fija la PD del módulo; los RA están en `docs/RAsASO.md`.
- **Despliegue**: no hay CI en `main`; la web se genera con `mkdocs gh-deploy` sobre `gh-pages`, y solo cuando el profesor lo pida.
- **Pendiente de revisar**: `docs/SolucionExamenShellScript.md` es la solución de un examen y está publicada en la web. Según la regla de soluciones, no debería estar; se retira solo con el visto bueno del profesor.
