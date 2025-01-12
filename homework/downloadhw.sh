#!/bin/bash

# 循环从 3 到 10，并使用 printf 格式化为两位数
for i in $(seq -w 3 10); do
    # 构建下载链接
    url="https://cs61a.org/hw/hw${i}/hw${i}.zip"
    # https://cs61a.org/hw/hw03/hw03.zip
    # 下载文件
    echo "Downloading ${url}..."
    wget "${url}"
    
    # 检查文件是否下载成功
    if [ -f "hw${i}.zip" ]; then
        # 解压文件
        echo "Unzipping hw${i}.zip..."
        unzip "hw${i}.zip"
        
        # 删除原始的 ZIP 文件（可选）
        rm "hw${i}.zip"
    else
        echo "Failed to download hw${i}.zip"
    fi
done