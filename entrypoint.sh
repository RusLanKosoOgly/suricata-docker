#!/bin/bash
set -e

echo "[+] Генерируем конфиг Suricata из шаблона..."
envsubst < /etc/suricata/suricata.template.yaml > /etc/suricata/suricata.yaml

echo "[+] Запускаем Suricata на интерфейсе: $INTERFACE"
exec suricata -i "$INTERFACE" -c /etc/suricata/suricata.yaml -v
