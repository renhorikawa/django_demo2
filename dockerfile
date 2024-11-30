# ベースイメージとしてPythonを使用
FROM python:3.13-slim

# 作業ディレクトリを作成
WORKDIR /app

# 必要なシステムパッケージをインストール
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# プロジェクトの依存関係を追加
COPY requirements.txt /app/

# Pythonの依存関係をインストール
RUN pip install --no-cache-dir -r requirements.txt

# プロジェクトファイルをコピー
COPY . /app/

# 必要なボリュームを設定（例：メディアファイル用）
VOLUME /app/media

# ポート8000を公開
EXPOSE 8000

# Run Django development server
CMD ["python", "myproject/manage.py", "runserver", "0.0.0.0:8000"]
