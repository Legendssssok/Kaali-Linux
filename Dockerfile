FROM ubuntu:latest

# Install necessary packages
RUN apt-get update -y > /dev/null 2>&1 && \
    apt-get upgrade -y > /dev/null 2>&1 && \
    apt-get install -y locales ssh wget unzip python3 python3-pip > /dev/null 2>&1 && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8

# Install ngrok
ARG NGROK_TOKEN="2c4szVGtDhawOCIb9uo4xyE0rMZ_vF5wkX8VYB685pTdXr32"
ENV NGROK_TOKEN=${NGROK_TOKEN}
RUN wget -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip > /dev/null 2>&1 && \
    unzip ngrok.zip && \
    rm ngrok.zip && \
    ./ngrok authtoken ${NGROK_TOKEN}

# Install Python dependencies
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt

# Copy the Flask app
COPY app.py /app/app.py

# Expose the port
EXPOSE 5000

# Command to run the Flask app
CMD ["python3", "-u", "app.py"]
