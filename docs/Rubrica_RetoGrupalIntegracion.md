# Rúbrica del Reto Grupal: Recursos compartidos Samba y NFS en AWS

Esta rúbrica permite evaluar el **Reto Grupal Integración** (RG503).

---

## Estructura de la rúbrica

La rúbrica tiene **7 criterios**, cada uno con **3 niveles** (No conseguido, Parcial, Conseguido). La puntuación total máxima es **30 puntos**.

| Criterio | Puntos máximos | Descripción breve |
|----------|----------------|-------------------|
| Instancias AWS creadas correctamente | 3 | Cuatro instancias: samba-server, nfs-server, cliente-linux, cliente-windows en la misma VPC. |
| Security Groups configurados | 3 | Puertos Samba (137-138 UDP, 139 y 445 TCP), NFS (111 y 2049), RDP (3389) y SSH (22). |
| Samba con Docker Compose funcionando | 6 | Servidor Samba en contenedor con Docker Compose y recurso compartido operativo. |
| NFS servidor configurado y exportando | 6 | NFS instalado, directorio exportado en /etc/exports y exportfs aplicado. |
| Acceso desde cliente Linux (Samba + NFS) | 4 | Cliente Linux monta y accede correctamente a Samba y a NFS con archivos de prueba. |
| Acceso desde cliente Windows (Samba) | 4 | Cliente Windows accede al recurso compartido Samba (por red o unidad de red). |
| Documentación completa | 4 | Documento con capturas de todas las fases y archivos compose.yaml y exports. |

---

## Niveles por criterio

Para cada criterio se aplican tres niveles:

- **No conseguido (0 puntos):** El aspecto no se ha trabajado o está incorrecto.
- **Parcial (puntuación intermedia):** El aspecto está abordado de forma incompleta o con errores.
- **Conseguido (puntuación máxima del criterio):** El aspecto se cumple según el enunciado del reto.

Las puntuaciones intermedias (Parcial) permiten valorar trabajos que no llegan al nivel completo pero sí muestran parte del trabajo realizado.

---

## Relación con el reto

La rúbrica corresponde al documento [Reto Grupal Integración: Recursos compartidos Samba y NFS en AWS](RetoGrupalIntegracion.md) (RG503), que integra las prácticas PR601 (NFS) y PR602 (Samba con Docker Compose) en un escenario cloud con AWS Academy.
