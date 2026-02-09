FROM python:3.9.2-slim-buster
# Example if your base image is Debian/Ubuntu
FROM python:3.9-slim-buster # Or any other Debian/Ubuntu based image

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y wget \
    && apt-get install -y --no-install-recommends \
        build-essential \
        libffi-dev \
        ffmpeg \
        aria2 \
        python3-pip \
        python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
        
COPY . /app/
WORKDIR /app/
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade -r requirements.txt \
    && python3 -m pip install -U yt-dlp
CMD gunicorn app:app & python3 main.py



