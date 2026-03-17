---
title: Introducción a Python
description: Resumen de conceptos básicos de Python para seguir los retos y prácticas que usan scripts en este módulo.
---

# Introducción a Python

Esta página resume los **conceptos básicos de Python** necesarios para realizar los retos y prácticas del módulo que utilizan scripts (por ejemplo, los gestores de procesos con tkinter y subprocess). El contenido se apoya en el repositorio **[Hello-Python](https://github.com/mouredev/Hello-Python)**, de [MoureDev](https://github.com/mouredev), concretamente en la carpeta **[Basic](https://github.com/mouredev/Hello-Python/tree/main/Basic)**, donde encontrarás ejemplos ejecutables de cada tema.

## Material de referencia

| Recurso | Enlace |
|--------|--------|
| Repositorio Hello-Python | <https://github.com/mouredev/Hello-Python> |
| Ejemplos Basic (00–13) | <https://github.com/mouredev/Hello-Python/tree/main/Basic> |

Puedes clonar el repositorio y ejecutar los scripts en tu entorno:

```bash
git clone https://github.com/mouredev/Hello-Python.git
cd Hello-Python/Basic
python 00_helloworld.py
```

---

## 1. Hola mundo y ejecución

El punto de partida: un script que imprime por consola y cómo ejecutarlo con `python` o `py`.

- **Ejemplo en el repo:** [00_helloworld.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/00_helloworld.py)

```python
print("Hello, Python!")
```

---

## 2. Variables y tipos

En Python no se declara el tipo: se asigna un valor y la variable toma su tipo. Tipos básicos: `int`, `float`, `str`, `bool`.

- **Ejemplo en el repo:** [01_variables.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/01_variables.py)

```python
nombre = "Admin"
version = 3
activo = True
```

---

## 3. Operadores

Operadores aritméticos (`+`, `-`, `*`, `/`, `//`, `%`, `**`), de comparación (`==`, `!=`, `<`, `>`, `<=`, `>=`) y lógicos (`and`, `or`, `not`).

- **Ejemplo en el repo:** [02_operators.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/02_operators.py)

---

## 4. Cadenas de texto (strings)

Concatenación, índices, rebanadas, métodos como `.strip()`, `.split()`, `.format()` o f-strings.

- **Ejemplo en el repo:** [03_strings.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/03_strings.py)

```python
texto = "  proceso  "
limpio = texto.strip()
mensaje = f"PID: {pid}"
```

---

## 5. Listas

Listas mutables: `[]`, índices, rebanadas, `.append()`, `.insert()`, recorrido con `for`.

- **Ejemplo en el repo:** [04_lists.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/04_lists.py)

```python
procesos = ["init", "bash", "python"]
procesos.append("nginx")
```

---

## 6. Tuplas

Secuencias inmutables: `()`, útiles para datos que no deben cambiar (por ejemplo, pares clave-valor o configuraciones).

- **Ejemplo en el repo:** [05_tuples.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/05_tuples.py)

---

## 7. Conjuntos (sets)

Colecciones sin orden y sin duplicados: `set()`, operaciones de conjuntos.

- **Ejemplo en el repo:** [06_sets.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/06_sets.py)

---

## 8. Diccionarios

Pares clave-valor: `{}`, acceso por clave, `.get()`, `.keys()`, `.values()`, `.items()`.

- **Ejemplo en el repo:** [07_dicts.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/07_dicts.py)

```python
opciones = {"1": "Listar", "2": "Top CPU"}
valor = opciones.get("1", "desconocido")
```

---

## 9. Condicionales

`if`, `elif`, `else`. Indentación obligatoria (bloques con espacios o tabulaciones).

- **Ejemplo en el repo:** [08_conditionals.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/08_conditionals.py)

```python
if code == 0:
    print(stdout)
else:
    print("Error:", stderr)
```

---

## 10. Bucles

`for elemento in secuencia:` y `while condicion:`. `break`, `continue`, `range()`.

- **Ejemplo en el repo:** [09_loops.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/09_loops.py)

```python
for i in range(5):
    print(i)
```

---

## 11. Funciones

Definición con `def`, parámetros, `return`. Valores por defecto y argumentos nombrados.

- **Ejemplo en el repo:** [10_functions.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/10_functions.py)

```python
def run_command(cmd, timeout=10):
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
    return result.returncode, result.stdout, result.stderr
```

---

## 12. Clases y objetos

Definición de clases con `class`, `__init__`, métodos y atributos. Herencia básica.

- **Ejemplo en el repo:** [11_classes.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/11_classes.py)

En los retos de procesos se usa una clase para la ventana de tkinter (por ejemplo, `GestorProcesosApp`).

---

## 13. Excepciones

`try`, `except`, `finally`. Capturar errores para no interrumpir el programa (por ejemplo, `subprocess.TimeoutExpired` o `FileNotFoundError`).

- **Ejemplo en el repo:** [12_exceptions.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/12_exceptions.py)

```python
try:
    r = subprocess.run(cmd, capture_output=True, timeout=30)
except subprocess.TimeoutExpired:
    print("Timeout")
except Exception as e:
    print("Error:", e)
```

---

## 14. Módulos e importación

Uso de `import` para cargar módulos estándar (`tkinter`, `subprocess`) o propios. `from módulo import nombre`.

- **Ejemplo en el repo:** [13_modules.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/13_modules.py) y [my_module.py](https://github.com/mouredev/Hello-Python/blob/main/Basic/my_module.py)

```python
import subprocess
from tkinter import messagebox, scrolledtext
```

---

## Relación con los retos del módulo

En los retos de **gestor de procesos** (Shell y PowerShell) se utilizan sobre todo:

- **tkinter**: ventanas, botones, áreas de texto (`tk`, `Button`, `ScrolledText`).
- **subprocess**: ejecutar comandos del sistema y capturar salida (`subprocess.run`, `capture_output=True`, `text=True`).
- **Estructura en clase**: una clase con `__init__` que crea la ventana y asocia cada botón a un método.
- **Manejo de excepciones**: `try/except` para timeouts o fallos al ejecutar comandos.

Si es tu primera vez con Python, conviene repasar al menos: variables, condicionales, funciones, excepciones y módulos, y luego revisar los ejemplos de la carpeta [Basic](https://github.com/mouredev/Hello-Python/tree/main/Basic) en el repositorio Hello-Python.
