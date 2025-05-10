#!/bin/bash

echo "🚨 ATENCIÓN: Esto eliminará TODOS los contenedores, imágenes, volúmenes y redes no usadas"
read -p "¿Estás seguro? (s/N): " confirm

if [[ "$confirm" != "s" && "$confirm" != "S" ]]; then
  echo "❌ Cancelado"
  exit 1
fi

echo "⛔ Parando y eliminando contenedores..."
docker rm -f $(docker ps -aq) 2>/dev/null

echo "🧽 Eliminando imágenes..."
docker rmi -f $(docker images -q) 2>/dev/null

echo "🗑️ Eliminando volúmenes..."
docker volume rm $(docker volume ls -q) 2>/dev/null

echo "🔌 Limpiando redes no usadas..."
docker network prune -f

echo "🧹 Haciendo limpieza general..."
docker system prune -a --volumes -f

echo "✅ ¡Docker limpio como nuevo!"
