# 使用輕量級 Python 鏡像
FROM python:3.10-slim

# 設定工作目錄
WORKDIR /app

# 安裝系統依賴 (如果 nanoclaw 需要編譯某些套件)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 複製需求文件並安裝
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製所有專案文件
COPY . .

# 暴露 FastAPI 預設埠口
EXPOSE 8000

# 啟動指令 (根據 nanoclaw 的進入點調整)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
