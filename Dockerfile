FROM python:3.10-slim

WORKDIR /app

# 安裝基本依賴
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 複製並安裝 Python 套件
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 複製程式碼
COPY . .

# 設定環境變數 (Zeabur 會自動對應到 8000 port)
ENV PORT=8000
EXPOSE 8000

# 啟動指令：使用 uvicorn 執行 main.py 裡的 app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
