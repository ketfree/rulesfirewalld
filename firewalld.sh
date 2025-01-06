#!/bin/bash

# Instalar iptables-persistent
apt update
apt install -y iptables-persistent

# Configurar iptables para aceptar tráfico y limpiar reglas existentes
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables-save > /etc/iptables/rules.v4

# Instalar firewalld
apt install -y firewalld

# Iniciar y habilitar firewalld
systemctl start firewalld
systemctl enable firewalld

# Abrir puertos TCP
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --add-port=30001-30005/tcp --permanent
firewall-cmd --add-port=30010-30011/tcp --permanent
firewall-cmd --add-port=30020-30021/tcp --permanent
firewall-cmd --add-port=32768-65535/tcp --permanent

# Abrir puertos UDP
firewall-cmd --add-port=30001-30005/udp --permanent
firewall-cmd --add-port=32768-65535/udp --permanent

# Recargar configuración de firewalld
firewall-cmd --reload

# Verificar configuración final
firewall-cmd --list-all
