#!/bin/bash
# ==============================================================================
# Script: demonio_servicio.sh
# Objetivo: Servicio continuo en segundo plano (Demonio)
# ==============================================================================

# Archivo de bitácora en la carpeta personal
LOG_FILE="$HOME/demonio_salud.log"

while true; do
    # 1. Fecha y hora con segundos
    FECHA=$(date '+%Y-%m-%d %H:%M:%S')

    # 2. PID del proceso actual
    MI_PID=$$

    # 3. Consumo de memoria RAM actual
    RAM_USADA=$(free -m | awk '/^Mem:/ {print $3}')
    RAM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
    RAM_PORC=$(( RAM_USADA * 100 / RAM_TOTAL ))

    # 4. Escribir registro en la bitácora
    echo "[$FECHA] | DEMONIO ACTIVO [PID: $MI_PID] | RAM: ${RAM_USADA}MB/${RAM_TOTAL}MB (${RAM_PORC}%)" >> "$LOG_FILE"

    # Intervalo de espera continuo (2 segundos)
    sleep 2
done
