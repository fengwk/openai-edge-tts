FROM python:3.12-slim

ARG INSTALL_FFMPEG=false
WORKDIR /app

# Install ffmpeg conditionally
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential python3-dev && \
    if [ "$INSTALL_FFMPEG" = "true" ]; then \
        apt-get install -y --no-install-recommends ffmpeg; \
    fi && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements and install them
COPY requirements.txt /app
RUN pip install -r requirements.txt

# Copy the app directory
COPY app/ /app

# Command to run the server
CMD ["python", "/app/server.py"]
