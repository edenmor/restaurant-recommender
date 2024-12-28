# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy application code and configuration
COPY app /app/app
COPY data /app/data
COPY requirements.txt /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set PYTHONPATH to include the app directory
ENV PYTHONPATH=/app

# Expose the port the app runs on
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "/app/app/api.py"]
