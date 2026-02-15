---
title: Reto Grupal - Recursos compartidos en AWS
description: Reto que integra Samba (Docker Compose) y NFS en instancias AWS con clientes de verificación
subtitle: Reto Grupal Integración
---

# RETO GRUPAL: Recursos compartidos Samba y NFS en AWS

**Módulo:** Administración de Sistemas Operativos (ASO)  
**Unidad:** Integración de Sistemas Operativos (Tema 6)  
**Modalidad:** Trabajo en grupo (2-3 personas)  
**Puntuación:** 30 puntos (sobre 100)  
**Criterios evaluados:** CE6a, CE6b, CE6c, CE6d, CE6e, CE6f, CE6g y CE6h  

Este reto integra las prácticas [PR601](PracticaNFS.md) y [PR602](PracticaDockerComposeSamba.md) en un escenario cloud con **AWS Academy**.

---

## Objetivo del Reto

Desplegar en **AWS** un escenario heterogéneo con:

1. **Servidor Samba** en contenedor (Docker Compose) sobre una instancia Ubuntu.
2. **Servidor NFS** en una instancia Ubuntu.
3. **Clientes de verificación**: al menos un cliente Linux y un cliente Windows que accedan a ambos recursos compartidos.

Debes demostrar la interoperabilidad entre sistemas libres y propietarios en un entorno cloud.

---

## Arquitectura del escenario

```
                    AWS VPC
    ┌─────────────────────────────────────────────────┐
    │                                                 │
    │  ┌─────────────┐    ┌─────────────┐            │
    │  │ Ubuntu      │    │ Ubuntu      │            │
    │  │ Samba       │    │ NFS Server  │            │
    │  │ (Docker     │    │             │            │
    │  │  Compose)   │    │             │            │
    │  └──────┬──────┘    └──────┬──────┘            │
    │         │                  │                    │
    │         │    SMB/CIFS      │    NFS             │
    │         │                  │                    │
    │  ┌──────┴──────────────────┴──────┐            │
    │  │         Clientes                │            │
    │  │  ┌──────────┐  ┌──────────┐   │            │
    │  │  │ Ubuntu   │  │ Windows   │   │            │
    │  │  │ Cliente  │  │ Cliente   │   │            │
    │  │  └──────────┘  └──────────┘   │            │
    │  └───────────────────────────────┘            │
    │                                                 │
    └─────────────────────────────────────────────────┘
```

---

## Tareas a realizar

### Fase 1: Preparación en AWS (15 min)

1. Crea **4 instancias** en EC2 (misma VPC y subred):

   - **samba-server**: Ubuntu 22.04, t3.micro, con Docker instalado.
   - **nfs-server**: Ubuntu 22.04, t3.micro.
   - **cliente-linux**: Ubuntu 22.04 o Amazon Linux, t3.micro.
   - **cliente-windows**: Windows Server 2022 o Windows 10, t3.micro.

2. Configura los **Security Groups**:

   - Samba: puertos 137, 138 (UDP), 139, 445 (TCP).
   - NFS: puertos 111, 2049 (TCP/UDP).
   - RDP: puerto 3389 para el cliente Windows.
   - SSH: puerto 22 para las instancias Linux.

3. Anota las **IP privadas** de cada instancia.

### Fase 2: Servidor Samba con Docker Compose (20 min)

1. Conéctate por SSH a **samba-server**.
2. Instala Docker y Docker Compose (si no está preinstalado):

```bash
sudo apt update
sudo apt install docker.io docker-compose-plugin -y
sudo usermod -aG docker ubuntu
# Cerrar sesión y volver a conectar para aplicar el grupo
```

3. Crea el proyecto y el `compose.yaml`:

```bash
mkdir -p ~/docker/samba/compartido
cd ~/docker/samba
chmod 777 compartido
```

4. Crea `compose.yaml` con el servicio Samba (ver [PR602](PracticaDockerComposeSamba.md)).
5. Ejecuta: `docker compose up -d`
6. Verifica: `docker compose ps`

### Fase 3: Servidor NFS (20 min)

1. Conéctate por SSH a **nfs-server**.
2. Instala y configura NFS (ver [PR601](PracticaNFS.md)):

```bash
sudo apt update
sudo apt install nfs-kernel-server -y
sudo mkdir -p /compartida
sudo chown nobody:nogroup /compartida
sudo chmod 777 /compartida
```

3. Edita `/etc/exports` (usa la subred de tu VPC, ej: `172.31.0.0/16`):

```
/compartida 172.31.0.0/16(rw,sync,no_subtree_check)
```

4. Aplica: `sudo exportfs -a && sudo systemctl restart nfs-kernel-server`

### Fase 4: Verificación desde clientes (25 min)

#### Cliente Linux

1. Conéctate por SSH a **cliente-linux**.
2. **Acceso a Samba**:

```bash
sudo apt install cifs-utils -y
sudo mkdir -p /mnt/samba
sudo mount -t cifs //IP_SAMBA_SERVER/Compartida /mnt/samba -o guest
# Crear archivo de prueba
echo "Prueba Samba" | sudo tee /mnt/samba/test_samba.txt
```

3. **Acceso a NFS**:

```bash
sudo apt install nfs-common -y
sudo mkdir -p /mnt/nfs
sudo mount IP_NFS_SERVER:/compartida /mnt/nfs
echo "Prueba NFS" | sudo tee /mnt/nfs/test_nfs.txt
```

#### Cliente Windows

1. Conéctate por RDP a **cliente-windows**.
2. **Acceso a Samba**: Explorador de archivos → `\\IP_SAMBA_SERVER\Compartida`
3. **Acceso a NFS** (si está disponible): Habilitar "Cliente NFS" en características de Windows. Montar: `mount -o anon IP_NFS_SERVER:/compartida Z:`

### Fase 5: Documentación (20 min)

Documenta el proceso con capturas de:

- Instancias creadas en AWS.
- Security Groups configurados.
- Samba en ejecución (`docker compose ps`).
- NFS exportado (`showmount -e`).
- Acceso desde cliente Linux a Samba y NFS.
- Acceso desde cliente Windows a Samba.
- Archivos de prueba creados en ambos recursos compartidos.

---

## Entregables

1. **Documento Markdown** con capturas y explicación de cada fase.
2. **Archivos** `compose.yaml` y contenido de `/etc/exports` utilizados.
3. **Diagrama** del escenario de red (opcional).

---

## Criterios de evaluación

| Criterio | Puntos |
|----------|--------|
| Instancias AWS creadas correctamente | 3 |
| Security Groups configurados | 3 |
| Samba con Docker Compose funcionando | 6 |
| NFS servidor configurado y exportando | 6 |
| Acceso desde cliente Linux (Samba + NFS) | 4 |
| Acceso desde cliente Windows (Samba) | 4 |
| Documentación completa | 4 |
| **Total** | **30** |

---

## Referencias

- [PR601: Instalación y configuración de NFS](PracticaNFS.md)
- [PR602: Samba con Docker Compose](PracticaDockerComposeSamba.md)
