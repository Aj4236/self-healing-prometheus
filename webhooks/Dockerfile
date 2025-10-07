FROM python:3.11-slim

# Install dependencies
RUN apt-get update && apt-get install -y curl git sudo ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI binary
RUN curl -SL https://download.docker.com/linux/static/stable/x86_64/docker-24.0.6.tgz -o docker.tgz \
    && tar -xzf docker.tgz --strip-components=1 -C /usr/local/bin docker/docker \
    && rm docker.tgz

# Install Python packages
RUN pip install --no-cache-dir ansible-core flask

WORKDIR /app
COPY webhook.py /app/
COPY playbooks/ /playbooks/

EXPOSE 5000
CMD ["python", "/app/webhook.py"]

