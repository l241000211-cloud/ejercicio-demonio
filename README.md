# Servicio Continuo y Demonio con Systemd en Ubuntu

## 🎯 Objetivos
* Diseñar e implementar un demonio en segundo plano desacoplado de la terminal que opere en un ciclo continuo ininterrumpido.
* Registrar periódicamente en una bitácora local la fecha con segundos, el total de procesos activos y la memoria RAM disponible cada 5 segundos.
* Implementar tolerancia a fallos mediante el gestor de servicios `systemd`, garantizando que si el proceso es eliminado de forma forzada (`kill -9`), el sistema operativo lo reinicie automáticamente en menos de 5 segundos con un nuevo PID.

---

## 📁 Jerarquía de Carpetas

* 📁 **[Codigo/](Codigo/)**: Script de ejecución continua en Bash y archivo `.service` para `systemd`.
* 📁 **[Terminal/](Terminal/)**: Capturas de la supervisión, bitácora y prueba de terminación.
* 📁 **[Reporte/](Reporte/)**: Reporte formal en PDF.

---

## 🛠️ Explicación de Comandos y Herramientas

| Comando / Parámetro | Función Técnica en la Práctica |
| :--- | :--- |
| `while true; do ... sleep 5; done` | Bucle infinito que consulta métricas con una pausa exacta de 5 segundos. |
| `ps -e \| wc -l` | Lista todos los procesos del sistema (`-e`) y cuenta el número total de líneas (`wc -l`). |
| `date '+%Y-%m-%d %H:%M:%S'` | Obtiene la marca temporal exacta incluyendo segundos. |
| `free -m` | Consulta la memoria en `/proc/meminfo` para extraer la columna de RAM disponible. |
| `systemctl status demonio.service` | Inspecciona el Main PID gestionado por systemd. |
| `kill -9 <PID>` / `SIGKILL` | Señal ineludible enviada al kernel para finalizar inmediatamente el proceso objetivo. |
| `Restart=always` / `RestartSec=2` | Directivas de `systemd` que disparan el relanzamiento en 2 segundos. |

---

## 📸 Evidencias de la Terminal

| <img src="Terminal/Terminal-01-demonio-activo.png" width="380"/> | <img src="Terminal/Terminal-02-bitacora-continua.png" width="380"/> |
| :---: | :---: |
| **1. Demonio activo en Systemd (`running`)** | **2. Bitácora de Procesos y RAM (5s)** |
| <img src="Terminal/Terminal-03-kill-y-resurreccion.png" width="380"/> | <img src="Terminal/Terminal-04-cambio-pid-en-log.png" width="380"/> |
| **3. Muerte forzada con `kill -9` y nuevo PID** | **4. Continuidad en bitácora** |

---

## 📄 Reporte Formal

* 📎 [Descargar Reporte PDF](Reporte_Demonio_Systemd.pdf)

▶️ Ver video de demostración en YouTube

[Aqui el video](https://youtu.be/4bPaKora5O4)

---

## 💻 Código y Scripts

* 📜 **Script del Demonio:** [demonio_servicio.sh](Codigo/demonio_servicio.sh)
* ⚙️ **Unidad de Systemd:** [demonio.service](Codigo/demonio.service)

```bash
# Comando de terminación forzada utilizado en la prueba:
sudo kill -9 $(pgrep -f demonio_servicio.sh)
