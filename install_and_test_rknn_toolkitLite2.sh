#!/bin/bash

# 脚本名称: install_and_test_rknn_toolkitLite2.sh
# 作者: wss
# 创建日期: 2023-12-21
# 描述: 该脚本用于在Linux系统上安装和测试RKNN Toolkit Lite2。
# 硬件：Rk3588
# 兼容系统: Ubuntu 20.04, Debian 10
# 软件版本：RKNN Toolkit Lite2 1.5.0
# 注意事项:
# - 请确保您的系统满足最低硬件要求，包括至少4GB的可用存储空间。
# - 脚本需要以root用户或使用sudo权限运行。
# - 请确保您的系统已安装Python 3.8或更高版本。

set -e

# 脚本变量
TOOLKIT_VERSION="rknn_toolkit_lite2-1.5.0-cp38-cp38-linux_aarch64.whl"
GIT_REPO="https://gitee.com/LubanCat/lubancat_ai_manual_code.git"
PROJECT_DIR="/home/firefly"  # 项目存放的路径


install_dependencies() {
    echo "安装依赖..."
    sudo apt-get update
    # 安装python工具等
    sudo apt-get install -y python3-dev python3-pip gcc git
    # 安装相关依赖和软件包
    pip3 install wheel
    sudo apt-get install -y python3-opencv
    sudo apt-get install -y python3-numpy
    sudo apt -y install python3-setuptools
}


clone_repository() {
    echo "克隆代码仓库到 $PROJECT_DIR ..."
    git clone $GIT_REPO  $PROJECT_DIR
}

install_rknn() {
    echo "安装RKNN Toolkit Lite2..."
    cd $PROJECT_DIR/lubancat_ai_manual_code/
    pip3 install ./dev_env/rknn_toolkit_lite2/packages/$TOOLKIT_VERSION
}

test_installation() {
    echo "测试安装..."
    python3 -c "from rknnlite.api import RKNNLite; print('RKNNLite module imported successfully')"
}

# ResNet18推理测试
test_resnet18_inference() {
    echo "进行ResNet18推理测试..."
    cd ./dev_env/rknn_toolkit_lite2/examples/inference_with_lite
    python3 test.py
    cd ../../../../
}

# YOLOv5推理测试
test_yolov5_inference() {
    echo "进行YOLOv5推理测试..."
    cd ./dev_env/rknn_toolkit_lite2/examples/yolov5_inference
    python3 test.py
    cd ../../../../
}

# 执行脚本
install_dependencies
clone_repository
install_rknn
test_installation
test_resnet18_inference
test_yolov5_inference

echo "脚本执行完成。"

