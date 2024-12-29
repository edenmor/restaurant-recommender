FROM python:3.9-slim

WORKDIR /app

COPY app /app/app
COPY data /app/data
COPY requirements.txt /app

RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONPATH=/app

ENTRYPOINT ["python", "/app/app/api.py"]