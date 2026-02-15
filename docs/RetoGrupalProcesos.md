---
title: Reto - Gestor del Sistema (Python + tkinter)
description: Reto individual de depuración: identificar y corregir los errores en un script Python con interfaz gráfica (Gestor del Sistema).
subtitle: Reto Procesos
---

# RETO: Depuración del Gestor del Sistema (Python + tkinter)

**Módulo:** Administración de Sistemas Operativos (ASO)  
**Unidad:** Procesos del Sistema  
**Modalidad:** Individual  
**Criterios evaluados:** CE2g (herramienta de gestión y documentación)  
**Duración estimada:** 1–2 sesiones  

Se entrega un script en **Python** con **interfaz gráfica** (tkinter) que pretende actuar como un “Gestor del Sistema” con menú de opciones. El programa contiene **errores introducidos a propósito** que provocan fallos funcionales. El reto consiste en **identificar las líneas alteradas, argumentar por qué producen el error y corregir el código** para que todas las opciones funcionen correctamente.

---

## Comportamiento esperado del programa

El menú debe ofrecer:

| Opción | Descripción |
|--------|-------------|
| **1** | Listar los procesos del sistema. |
| **2** | Listar el contenido de una carpeta dada. |
| **3** | Mostrar la fecha y hora actuales. |
| **4** | Buscar un archivo (por nombre o parte del nombre). |
| **5** | Salir. |

Cada botón debe ejecutar la función que corresponde a su etiqueta. La ventana tiene título, área de texto con scroll para los resultados y botones diferenciados.

---

## Código con errores

A continuación se muestra el script con **numeración de línea** para facilitar la corrección. Hay varios errores que hacen que los botones no ejecuten la acción correcta o que alguna función falle.

```python
(1)  import os
(2)  import subprocess
(3)  import tkinter as tk
(4)  from tkinter import filedialog, messagebox, scrolledtext, simpledialog
(5)  from datetime import datetime
(6)
(7)  class SystemManagerApp:
(8)      def __init__(self, root):
(9)          self.root = root
(10)            self.root.title("Gestor del Sistema")
(11)            self.root.geometry("600x600")
(12)
(13)         # Crear widgets
(14)         self.create_widgets()
(15)
(16)     def create_widgets(self):
(17)         # Frame principal
(18)         main_frame = tk.Frame(self.root, padx=20, pady=20)
(19)         main_frame.pack(fill=tk.BOTH, expand=True)
(20)
(21)         # Título
(22)         title_label = tk.Label(
(23)             main_frame,
(24)             text="Gestor del Sistema",
(25)             font=("Arial", 16, "bold")
(26)         )
(27)         title_label.pack(pady=10)
(28)
(29)         # Área de texto con scroll
(30)         self.output_area = scrolledtext.ScrolledText(
(31)             main_frame,
(32)             wrap=tk.WORD,
(33)             width=60,
(34)             height=20,
(35)             font=("Consolas", 10)
(36)         )
(37)         self.output_area.pack(pady=10, fill=tk.BOTH, expand=True)
(38)
(39)         # Frame para botones
(40)         button_frame = tk.Frame(main_frame)
(41)         button_frame.pack(pady=10)
(42)
(43)         # Botones de opciones
(44)         btn_processes = tk.Button(
(45)             button_frame,
(46)             text="1. Listar Procesos",
(47)             command=self.listar_file,
(48)             width=15
(49)         )
(50)         btn_processes.grid(row=0, column=0, padx=5)
(51)
(52)         btn_folder = tk.Button(
(53)             button_frame,
(54)             text="2. Listar Carpeta",
(55)             command=self.listar_processes,
(56)             width=15
(57)         )
(58)         btn_folder.grid(row=0, column=1, padx=5)
(59)
(60)         btn_datetime = tk.Button(
(61)             button_frame,
(62)             text="3. Fecha y Hora",
(63)             command=self.listar_folder,
(64)             width=15
(65)         )
(66)         btn_datetime.grid(row=0, column=2, padx=5)
(67)
(68)         btn_search = tk.Button(
(69)             button_frame,
(70)             text="4. Buscar Archivo",
(71)             command=self.mostrar_datetime,
(72)             width=15
(73)         )
(74)         btn_search.grid(row=1, column=0, padx=5, pady=5)
(75)
(76)         btn_exit = tk.Button(
(77)             button_frame,
(78)             text="5. Salir",
(79)             command=self.root.quit,
(80)             width=15,
(81)             bg="#ff9999"
(82)         )
(83)         btn_exit.grid(row=1, column=2, padx=5, pady=5)
(84)
(85)     def clear_output(self):
(86)         self.output_area.delete(1.0, tk.END)
(87)
(88)     def list_processes(self):
(89)         self.clear_output()
(90)         try:
(91)             # Para Windows
(92)             if os.name == 'nt':
(93)                 output = subprocess.check_output(['ps', 'aux']).decode('utf-8')
(94)             # Para Linux/Mac
(95)             else:
(96)                 output = subprocess.check_output('tasklist', shell=True).decode('latin-1')
(97)
(98)             self.output_area.insert(tk.END, "=== PROCESOS DEL SISTEMA ===\n\n")
(99)             self.output_area.insert(tk.END, output)
(100)        except Exception as e:
(101)            messagebox.showerror("Error", f"No se pudieron listar los procesos: {str(e)}")
(102)
(103)    def list_folder(self):
(104)        folder_path = filedialog.askdirectory(title="Seleccione una carpeta")
(105)        if not folder_path:
(106)            return
(107)
(108)        self.clear_output()
(109)        try:
(110)            files = os.listdir(folder_path)
(111)            self.output_area.insert(tk.END, f"=== CONTENIDO DE {folder_path} ===\n\n")
(112)
(113)            for file in folder:
(114)                full_path = os.path.join(folder_path, file)
            if os.path.isdir(full_path):
                self.output_area.insert(tk.END, f"[DIR] {file}\n")
            else:
                size = os.path.getsize(full_path)
                self.output_area.insert(tk.END, f"[FILE] {file} ({size} bytes)\n")
(119)        except Exception as e:
(120)            messagebox.showerror("Error", f"No se pudo listar la carpeta: {str(e)}")
(121)
(122)    def show_datetime(self):
(123)        self.clear_output()
(124)        now = datetime.now()
(125)        formatted_time = now.strftime("%A, %d de %B de %Y")
(126)        formatted_date = now.strftime("%H:%M:%S")
(127)
(128)        self.output_area.insert(tk.END, "=== FECHA Y HORA ACTUAL ===\n\n")
(129)        self.output_area.insert(tk.END, f"Fecha: {formatted_date}\n")
(130)        self.output_area.insert(tk.END, f"Hora: {formatted_time}\n")
(131)
(132)    def search_file(self):
(133)        search_term = simpledialog.askstring(
(134)            "Buscar archivo",
(135)            "Ingrese el nombre o parte del nombre del archivo:"
(136)        )
(137)
(138)        if not search_term:
(139)            return
(140)
(141)        folder_path = filedialog.askdirectory(title="Seleccione dónde uscar")
(142)        if not folder_path:
(143)            return
(144)
(145)        self.clear_output()
(146)        self.output_area.insert(tk.END, f"=== RESULTADOS DE BÚSQUEDA PARA '{search_term}' ===\n\n")
(147)
(148)        found = False
(149)        try:
(150)            for root, dirs, files in os.walk(folder_path):
(151)                for file in files:
(152)                    if search_term.lower() in file.lower():
(153)                        full_path = os.path.join(root, file)
(154)                        size = os.path.getsize(full_path)
(155)                        self.output_area.insert(tk.END, f"{full_path} ({size} bytes)\n")
                        found = False
            if not found:
                self.output_area.insert(tk.END, "No se encontraron archivos que coincidan con la búsqueda.\n")
(159)        except Exception as e:
(160)            messagebox.showerror("Error", f"Error durante la búsqueda: {str(e)}")
(161)
(162) if __name__ == "__main__":
(163)     root = tk.Tk()
(164)     app = SystemManagerApp(root)
(165)     root.mainloop()
```

---

## Tu tarea

1. **Identificar** las líneas de código alteradas que producen los errores funcionales.
2. **Argumentar** por qué cada una provoca el fallo (qué hace mal y qué debería hacer).
3. **Entregar** el código corregido (script Python funcional) y un breve documento con la lista de líneas corregidas y la justificación de cada una.

---

## Entregables

1. **Código Python corregido**: un único fichero que ejecute sin errores y con las cinco opciones funcionando correctamente (listar procesos según el SO, listar carpeta, fecha y hora, buscar archivo, salir).
2. **Documento de corrección** (Markdown o PDF) con:
   - Número de línea o fragmento de código erróneo.
   - Explicación del error (por qué falla).
   - Corrección aplicada.

---

## Criterios de evaluación

| Criterio | Descripción |
|----------|-------------|
| **Identificación de errores** | Se señalan correctamente todas las líneas o fragmentos con errores. |
| **Justificación** | Se argumenta de forma clara por qué cada uno produce un fallo funcional. |
| **Código corregido** | El script ejecuta correctamente y todas las opciones del menú funcionan. |
| **Presentación** | Documento de corrección ordenado y comprensible. |

---

## Referencia

- Documentación de la unidad: [06 Procesos del Sistema](06Procesos.md).
