#!/bin/bash

# 循环从 3 到 12，并使用 printf 格式化为两位数
for i in $(seq -w 3 12); do
    # 构建下载链接
    url="https://cs61a.org/lab/lab${i}/lab${i}.zip"
    
    # 下载文件
    echo "Downloading ${url}..."
    wget "${url}"
    
    # 检查文件是否下载成功
    if [ -f "lab${i}.zip" ]; then
        # 解压文件
        echo "Unzipping lab${i}.zip..."
        unzip "lab${i}.zip" -d "lab${i}"
        
        # 删除原始的 ZIP 文件（可选）
        rm "lab${i}.zip"
    else
        echo "Failed to download lab${i}.zip"
    fi
done