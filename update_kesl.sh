#!/bin/bash

# Definir URL de download
DOWNLOAD_URL="https://downloads.hsprevent.com.br/kesl_12.2.0-2517_amd64.deb"
DEB_FILE="kesl_12.2.0-2517_amd64.deb"

echo "Verificando se o endpoint KESL está instalado..."
dpkg -l | grep kesl

echo "Parando o serviço do endpoint..."
sudo systemctl stop kesl
sleep 2

echo "⬇Baixando o novo pacote do endpoint..."
wget -O "$DEB_FILE" "$DOWNLOAD_URL"

echo "Instalando o novo pacote do endpoint..."
sudo dpkg -i "$DEB_FILE"
sleep 3

echo "Corrigindo possíveis dependências..."
sudo apt-get install -f -y

echo "Verificando se a atualização foi concluída..."
dpkg -l | grep kesl

echo "Reiniciando o serviço do endpoint..."
sudo systemctl daemon-reexec
sudo systemctl start kesl

echo "Verificando o status do serviço..."
systemctl status kesl
