---
title: Reto individual - Gestor de procesos (Python + Shell)
description: Reto individual de depuración: script Python con interfaz gráfica que usa comandos Shell (ps, pstree, jobs, kill, renice) para gestionar procesos en Linux.
subtitle: Reto Procesos - Shell
---

# RG601: Gestor de procesos con Shell (Python + tkinter)

- **Reto individual de depuración (RG601)**
- **Puntuación:** 30 puntos
- **Criterios evaluados:** 
  - CE2c (gestión de procesos desde el Shell)
  - CE2g (herramienta de gestión y documentación)
- **Duración estimada:** 1–2 sesiones
- **Entorno:** Linux o WSL (comandos bash: `ps`, `pstree`, `jobs`, `kill`, `renice`)

<figure>
  <img src="imagenes/03/033/gestorprocesos.png" width="650" alt="Captura del gestor de procesos con Python y Shell"/>
  <figcaption>Interfaz gráfica del gestor de procesos.</figcaption>
</figure>

## Objetivos

Durante este reto depurarás un script en **Python** con **interfaz gráfica** (tkinter) que actúa como gestor de procesos usando **comandos Shell** (apartado 3 de la unidad). El programa contiene **errores introducidos a propósito**.

Al finalizar serás capaz de:

- Identificar líneas de código alteradas que provocan fallos funcionales.
- Argumentar por qué cada error produce un comportamiento incorrecto.
- Corregir el código para que todas las opciones del menú funcionen (listar procesos, árbol, jobs, kill, renice, servicios systemctl, salir).
- Entregar el script corregido y un documento de corrección con justificación.

## Requisitos previos

- **Python 3** con los módulos estándar: `tkinter`, `subprocess`.
- **Entorno Linux** o **WSL** en Windows, con los comandos `ps`, `pstree`, `jobs`, `kill`, `renice` disponibles.
- Si no tienes experiencia con Python, puedes apoyarte en la [Introducción a Python](IntroduccionPython.md).

!!! note "tkinter en Linux"
    En instalaciones mínimas de Python puede faltar tkinter. En Debian/Ubuntu: `sudo apt install python3-tk`.

---

## Parte 1: Comportamiento esperado del programa

El menú debe ofrecer las siguientes opciones; cada botón debe ejecutar la función que corresponde y mostrar el resultado en el área de texto.

| Opción | Descripción | Comando(s) Shell utilizados |
|--------|-------------|-----------------------------|
| **1** | Listar procesos del sistema (formato extendido). | `ps -ef` |
| **2** | Mostrar árbol de procesos (padre-hijo). | `pstree` |
| **3** | Listar trabajos en segundo plano (con PID). | `jobs -p` (o `jobs`) |
| **4** | Finalizar un proceso por PID (terminación ordenada). | `kill PID` |
| **5** | Cambiar prioridad (nice) de un proceso. | `renice -n prioridad -p PID` |
| **6** | Listar servicios (systemd). | `systemctl list-units --type=service` |
| **7** | Salir. | — |

---

## Parte 2: Guía de ejecución (Python + Shell)

### Requisitos

- Python 3 con `tkinter` y `subprocess`.
- Linux o WSL con comandos `ps`, `pstree`, `jobs`, `kill`, `renice` y `systemctl` (apartado 6 de la unidad).

### Uso de subprocess para llamar a comandos Shell

En Python se ejecutan comandos del sistema con el módulo **`subprocess`**:

```python
import subprocess

# Ejecutar comando y capturar salida (lista de argumentos, sin shell)
result = subprocess.run(
    ['ps', '-ef'],
    capture_output=True,
    text=True,
    timeout=10
)
if result.returncode == 0:
    print(result.stdout)
else:
    print("Error:", result.stderr)

# Si el comando usa tuberías o redirecciones, usar shell=True
result = subprocess.run(
    'jobs -p',
    shell=True,
    capture_output=True,
    text=True,
    executable='/bin/bash'
)
```

- **`capture_output=True`**: captura stdout y stderr.
- **`text=True`**: devuelve cadenas en lugar de bytes.
- **`timeout`**: evita que un comando se quede colgado.
- Para comandos que solo tienen sentido en una sesión interactiva (p. ej. `jobs`), puede que la salida esté vacía si se ejecutan en un proceso nuevo; en ese caso se puede documentar o usar una alternativa.

### Cómo ejecutar el script

```bash
# En Linux o WSL
python3 gestor_procesos_shell.py
# o
python gestor_procesos_shell.py
```

---

## Parte 3: Código con errores

A continuación se muestra el script con **numeración de línea** para facilitar la corrección. Hay varios errores que hacen que los botones no ejecuten la acción correcta o que el comando Shell sea erróneo.

```python
(1)  import os
(2)  import subprocess
(3)  import tkinter as tk
(4)  from tkinter import messagebox, scrolledtext, simpledialog
(5)
(6)  class GestorProcesosShellApp:
(7)      def __init__(self, root):
(8)          self.root = root
(9)          self.root.title("Gestor de procesos (Shell)")
(10)         self.root.geometry("700x500")
(11)
(12)         self.create_widgets()
(13)
(14)     def create_widgets(self):
(15)         main_frame = tk.Frame(self.root, padx=20, pady=20)
(16)         main_frame.pack(fill=tk.BOTH, expand=True)
(17)
(18)         self.output_area = scrolledtext.ScrolledText(
(19)             main_frame, wrap=tk.WORD, width=70, height=18, font=("Consolas", 9)
(20)         )
(21)         self.output_area.pack(pady=10, fill=tk.BOTH, expand=True)
(22)
(23)         btn_frame = tk.Frame(main_frame)
(24)         btn_frame.pack(pady=5)
(25)
(26)         tk.Button(btn_frame, text="1. Listar procesos (ps -ef)", command=self.listar_arbol, width=22).grid(row=0, column=0, padx=3, pady=2)
(27)         tk.Button(btn_frame, text="2. Árbol de procesos (pstree)", command=self.listar_procesos, width=22).grid(row=0, column=1, padx=3, pady=2)
(28)         tk.Button(btn_frame, text="3. Trabajos en segundo plano (jobs)", command=self.trabajos_background, width=32).grid(row=0, column=2, padx=3, pady=2)
(29)         tk.Button(btn_frame, text="4. Finalizar proceso (kill PID)", command=self.finalizar_proceso, width=26).grid(row=1, column=0, padx=3, pady=2)
(30)         tk.Button(btn_frame, text="5. Cambiar prioridad (renice)", command=self.cambiar_prioridad, width=26).grid(row=1, column=1, padx=3, pady=2)
(31)         tk.Button(btn_frame, text="6. Servicios (systemctl)", command=self.cambiar_prioridad, width=24).grid(row=1, column=2, padx=3, pady=2)
(32)         tk.Button(btn_frame, text="7. Salir", command=self.root.quit, width=12, bg="#ff9999").grid(row=2, column=0, padx=3, pady=2)
(32)
(33)     def clear_output(self):
(34)         self.output_area.delete(1.0, tk.END)
(35)
(36)     def run_cmd(self, cmd, use_shell=False):
(37)         try:
(38)             if use_shell:
(39)                 r = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=15, executable="/bin/bash")
(40)             else:
(41)                 r = subprocess.run(cmd, capture_output=True, text=True, timeout=15)
(42)             return (r.returncode, r.stdout or "", r.stderr or "")
(43)         except subprocess.TimeoutExpired:
(44)             return (-1, "", "Timeout")
(45)         except Exception as e:
(46)             return (-1, "", str(e))
(47)
(48)     def listar_procesos(self):
(49)         self.clear_output()
(50)         code, out, err = self.run_cmd(['ps', '-f'])
(51)         self.output_area.insert(tk.END, "=== PROCESOS (ps -ef) ===\n\n")
(52)         if code == 0:
(53)             self.output_area.insert(tk.END, out)
(54)         else:
(55)             self.output_area.insert(tk.END, f"Error: {err}\n")
(56)
(57)     def listar_arbol(self):
(58)         self.clear_output()
(59)         code, out, err = self.run_cmd(['pstree'])
(60)         self.output_area.insert(tk.END, "=== ÁRBOL DE PROCESOS (pstree) ===\n\n")
(61)         if code == 0:
(62)             self.output_area.insert(tk.END, out)
(63)         else:
(64)             self.output_area.insert(tk.END, f"Error: {err}\n")
(65)
(66)     def trabajos_background(self):
(67)         self.clear_output()
(68)         code, out, err = self.run_cmd("jobs -p", use_shell=True)
(69)         self.output_area.insert(tk.END, "=== TRABAJOS EN SEGUNDO PLANO (jobs -p) ===\n\n")
(70)         if code == 0:
(71)             self.output_area.insert(tk.END, out if out.strip() else "(Ninguno o no disponible en este contexto)\n")
(72)         else:
(73)             self.output_area.insert(tk.END, f"Error: {err}\n")
(74)
(75)     def finalizar_proceso(self):
(76)         pid_str = simpledialog.askstring("Finalizar proceso", "Introduce el PID del proceso a finalizar (kill):")
(77)         if not pid_str or not pid_str.strip():
(78)             return
(79)         pid = pid_str.strip()
(80)         self.clear_output()
(81)         code, out, err = self.run_cmd(['kill', '-9', pid])
(82)         self.output_area.insert(tk.END, f"=== FINALIZAR PROCESO (kill {pid}) ===\n\n")
(83)         if code == 0:
(84)             self.output_area.insert(tk.END, f"Proceso {pid} finalizado (SIGTERM).\n")
(85)         else:
(86)             self.output_area.insert(tk.END, f"Error: {err}\n")
(87)
(88)     def cambiar_prioridad(self):
(89)         pid_str = simpledialog.askstring("Prioridad", "Introduce el PID del proceso:")
(90)         if not pid_str or not pid_str.strip():
(91)             return
(92)         prio_str = simpledialog.askstring("Prioridad", "Introduce la prioridad nice (-20 a 20):")
(93)         if not prio_str or not prio_str.strip():
(94)             return
(95)         self.clear_output()
(96)         code, out, err = self.run_cmd(['renice', '-p', pid_str.strip(), '-n', prio_str.strip()])
(97)         self.output_area.insert(tk.END, f"=== CAMBIAR PRIORIDAD (renice) ===\n\n")
(98)         if code == 0:
(99)             self.output_area.insert(tk.END, out + "\n")
(100)        else:
(101)            self.output_area.insert(tk.END, f"Error: {err}\n")
(102)
(103)     def listar_servicios(self):
(104)        self.clear_output()
(105)        code, out, err = self.run_cmd(['systemctl', 'list-unit-files', '--type=service'])
(106)        self.output_area.insert(tk.END, "=== SERVICIOS (systemctl list-units --type=service) ===\n\n")
(107)        if code == 0:
(108)            self.output_area.insert(tk.END, out)
(109)        else:
(110)            self.output_area.insert(tk.END, f"Error: {err}\n")
(111)
(112) if __name__ == "__main__":
(113)     root = tk.Tk()
(114)     app = GestorProcesosShellApp(root)
(115)     root.mainloop()
```

---

## Tu tarea

1. **Identificar** las líneas de código alteradas que producen los errores funcionales.
2. **Argumentar** por qué cada una provoca el fallo (qué hace mal y qué debería hacer).
3. **Entregar** el código corregido y un breve documento con la lista de líneas corregidas y la justificación.

---

## Entregables

1. **Código Python corregido**: un único fichero que ejecute en Linux/WSL con las siete opciones funcionando correctamente (incluida la de servicios con systemctl).
2. **Documento de corrección** (Markdown o PDF) con: número de línea o fragmento erróneo, explicación del error y corrección aplicada.

## Criterios de evaluación

| Criterio | Puntos | Descripción |
|----------|--------|-------------|
| **Identificación de errores** | 8 | Se señalan correctamente todas las líneas o fragmentos con errores. |
| **Justificación** | 8 | Se argumenta por qué cada uno produce un fallo funcional. |
| **Código corregido** | 10 | El script ejecuta correctamente y todas las opciones del menú funcionan. |
| **Documento de corrección** | 4 | Documento ordenado, comprensible y con correcciones aplicadas. |
| **Total** | **30** | |

## Subapartados relacionados

- [06 Procesos del Sistema — 3. Gestión de procesos en Shell (Linux)](06Procesos.md#3-gestion-de-procesos-en-shell-linux): `ps`, `pstree`, `top`, primer/segundo plano, `renice`, `kill`.
- [06 Procesos del Sistema — 6. Administración de servicios (systemd)](06Procesos.md#6-administracion-de-servicios-systemd): `systemctl` (iniciar, detener, habilitar, deshabilitar, estado, unidades, destinos).

## Referencia

- Documentación de la unidad: [06 Procesos del Sistema — Gestión en Shell](06Procesos.md#3-gestion-de-procesos-en-shell-linux).
