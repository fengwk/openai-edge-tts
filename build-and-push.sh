#!/bin/bash

# 任何命令执行失败，则立即退出脚本
set -e

DOCKER_HUB_USERNAME="fengwk"
IMAGE_NAME="openai-edge-tts"
IMAGE_TAG="latest"

# 检查 DOCKER_USERNAME 和 DOCKER_PASSWORD 环境变量是否已设置
if [ -z "$DOCKER_USERNAME" ]; then
  echo "错误：环境变量 DOCKER_USERNAME 未设置。"
  exit 1
fi
if [ -z "$DOCKER_PASSWORD" ]; then
  echo "错误：环境变量 DOCKER_PASSWORD 未设置。"
  exit 1
fi

# --- 登录 Docker Hub ---
echo "--- 正在登录 Docker Hub... ---"
docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
echo "登录成功。"

full_image_name="${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"

echo ""
echo "=================================================="
echo "打包上传镜像: $full_image_name"
echo "=================================================="

echo "--> 步骤 1: 构建 Docker 镜像..."
docker build -t "$full_image_name" .
echo "--> 构建完成。"

echo "--> 步骤 2: 推送镜像到 Docker Hub..."
docker push "$full_image_name"
echo "--> 推送完成。"

