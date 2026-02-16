#!/usr/bin/env python3
"""
Genera diagramas Gantt para 06Procesos.md.
Cada fila = un proceso. Rosa/beige = espera, rojo = ejecución.
Intervalos exactos según el texto del documento.
"""
import os
# Guardar imágenes en el mismo directorio que este script
os.chdir(os.path.dirname(os.path.abspath(__file__)))

from PIL import Image, ImageDraw

W = 750
H_ROW = 50
MARGIN_LEFT = 45
MARGIN_TOP = 30
MARGIN_BOTTOM = 35
# Colores (fondo rosa claro, espera beige/rosa, ejecución rojo)
BG = (255, 240, 245)      # LavenderBlush
WAIT = (255, 218, 185)    # PeachPuff
RUN = (220, 20, 60)       # Crimson
TEXT_COLOR = (50, 50, 50)
AXIS_COLOR = (100, 100, 100)

def draw_gantt(segments_by_process, t_max, filename, process_order=None):
    """
    segments_by_process: dict process_name -> list of (start, end, 'wait'|'run')
    t_max: tiempo máximo del eje X
    process_order: lista de nombres para orden de filas (ej. ['P1','P2','P3','P4'])
    """
    if process_order is None:
        process_order = sorted(segments_by_process.keys())
    n_rows = len(process_order)
    img_h = MARGIN_TOP + n_rows * H_ROW + MARGIN_BOTTOM
    img = Image.new("RGB", (W, img_h), BG)
    draw = ImageDraw.Draw(img)
    # Zona útil para barras (sin margen izquierdo para etiquetas)
    bar_left = MARGIN_LEFT
    bar_width = W - bar_left - 20
    def x(t):
        return bar_left + (t / t_max) * bar_width
    # Dibujar por proceso
    for i, proc in enumerate(process_order):
        y_center = MARGIN_TOP + (i + 0.5) * H_ROW
        y_top = int(y_center - H_ROW * 0.35)
        y_bottom = int(y_center + H_ROW * 0.35)
        segs = segments_by_process.get(proc, [])
        for s, e, kind in segs:
            x1 = int(x(s))
            x2 = int(x(e))
            if kind == 'wait':
                draw.rectangle([x1, y_top, x2, y_bottom], fill=WAIT, outline=(200,180,160))
            else:
                draw.rectangle([x1, y_top, x2, y_bottom], fill=RUN, outline=(180,0,0))
        # Etiqueta proceso
        draw.text((8, y_center - 8), proc, fill=TEXT_COLOR)
    # Eje tiempo
    y_axis = img_h - 22
    draw.line([(bar_left, y_axis), (W - 20, y_axis)], fill=AXIS_COLOR)
    step = 2 if t_max <= 12 else (4 if t_max <= 17 else 5)
    for t in range(0, int(t_max) + 1, step):
        xi = int(x(t))
        draw.line([(xi, y_axis), (xi, y_axis + 6)], fill=AXIS_COLOR)
        draw.text((xi - 8, y_axis + 8), str(t), fill=TEXT_COLOR)
    img.save(filename)
    print("Guardado:", filename)

# --- FIFO: P1(0-2), P2(2-6), P3(6-9), P4(9-12).
fifo = {
    'P1': [(0, 2, 'run')],
    'P2': [(0, 2, 'wait'), (2, 6, 'run')],
    'P3': [(0, 6, 'wait'), (6, 9, 'run')],
    'P4': [(0, 9, 'wait'), (9, 12, 'run')],
}
draw_gantt(fifo, 12, "ejemplo_fifo.png", ['P1', 'P2', 'P3', 'P4'])

# --- SJF: P1(0-2), P3(2-5), P4(5-8), P2(8-12). Filas P1,P2,P3,P4.
sjf = {
    'P1': [(0, 2, 'run')],
    'P2': [(0, 8, 'wait'), (8, 12, 'run')],
    'P3': [(0, 2, 'wait'), (2, 5, 'run')],
    'P4': [(0, 5, 'wait'), (5, 8, 'run')],
}
draw_gantt(sjf, 12, "ejemplo_sjf.png", ['P1', 'P2', 'P3', 'P4'])

# --- SRTF: 0-1 P1, 1-2 P2, 2-3 P3, 3-4 P4, 4-6 P3, 6-10 P2, 10-17 P1.
srtf = {
    'P1': [(0, 1, 'run'), (1, 10, 'wait'), (10, 17, 'run')],
    'P2': [(0, 1, 'wait'), (1, 2, 'run'), (2, 6, 'wait'), (6, 10, 'run')],
    'P3': [(0, 2, 'wait'), (2, 3, 'run'), (3, 4, 'wait'), (4, 6, 'run')],
    'P4': [(0, 3, 'wait'), (3, 4, 'run')],
}
draw_gantt(srtf, 17, "ejemplo_srtf.png", ['P1', 'P2', 'P3', 'P4'])

# --- Prioridades no expulsivo: P2(0-4), P3(4-7), P1(7-9), P4(9-12).
prior_noexp = {
    'P1': [(0, 7, 'wait'), (7, 9, 'run')],
    'P2': [(0, 4, 'run')],
    'P3': [(0, 4, 'wait'), (4, 7, 'run')],
    'P4': [(0, 9, 'wait'), (9, 12, 'run')],
}
draw_gantt(prior_noexp, 12, "ejemplo_prior_noexp.png", ['P1', 'P2', 'P3', 'P4'])

# --- Prioridades expulsivo: 0-1 P1, 1-4 P2, 4-9 P1, 9-11 P3.
prior_exp = {
    'P1': [(0, 1, 'run'), (1, 4, 'wait'), (4, 9, 'run')],
    'P2': [(0, 1, 'wait'), (1, 4, 'run')],
    'P3': [(0, 9, 'wait'), (9, 11, 'run')],
}
draw_gantt(prior_exp, 11, "ejemplo_prior_exp.png", ['P1', 'P2', 'P3'])

# --- Round Robin Q=2: P1 0-2; P2 2-4, 8-10; P3 4-6, 10-11; P4 6-8, 11-12.
rr = {
    'P1': [(0, 2, 'run')],
    'P2': [(0, 2, 'wait'), (2, 4, 'run'), (4, 8, 'wait'), (8, 10, 'run')],
    'P3': [(0, 4, 'wait'), (4, 6, 'run'), (6, 10, 'wait'), (10, 11, 'run')],
    'P4': [(0, 6, 'wait'), (6, 8, 'run'), (8, 11, 'wait'), (11, 12, 'run')],
}
draw_gantt(rr, 12, "ejemplo_rr.png", ['P1', 'P2', 'P3', 'P4'])

print("Hecho. Imágenes en docs/imagenes/03/031/")
