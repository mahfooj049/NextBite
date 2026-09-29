FROM node:20-bookworm

# Install Python 3.11 and pip
RUN apt-get update && \
    apt-get install -y python3.11 python3-pip python3.11-venv && \
    ln -sf /usr/bin/python3.11 /usr/bin/python3

WORKDIR /app

# Install Node dependencies
COPY package*.json ./
RUN npm install

# Install Python dependencies
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt --break-system-packages

# Copy rest of the project
COPY . .

EXPOSE 3000

CMD ["node", "server.js"]