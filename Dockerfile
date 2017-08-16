# Basic docker image for Monocle
# Usage:
#   docker build -t monocle .

FROM python:3.6

# Default port the webserver runs on
EXPOSE 5000

# Working directory for the application
WORKDIR /usr/src/app

# Set Entrypoint with hard-coded options
ENTRYPOINT [ "python3" ]
CMD [ "./scan.py" ]

COPY requirements.txt /usr/src/app/

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libgeos-c1 \
       libmysqlclient-dev \
       libssl-dev \
       libssl1.0.0 \
    && pip3.6 install --no-cache-dir -U \
       ConfigParser \
       mysqlclient \
    && pip3 install -U -r requirements.txt \
    && pip3 install --no-cache-dir -U \
       aiodns \
       cchardet \
       shapely \
       ujson \
       uvloop \
       selenium \
       psycopg2 \
    && rm -rf /var/lib/apt/lists/*

# Copy everything to the working directory (Python files, templates, config) in one go.
COPY . /usr/src/app/

