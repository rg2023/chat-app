# set base image (host OS)
FROM python:3.8-slim AS builder
# --- NETFREE CERT INTSALL ---
ADD https://netfree.link/dl/unix-ca.sh /home/netfree-unix-ca.sh
RUN cat  /home/netfree-unix-ca.sh | sh
ENV NODE_EXTRA_CA_CERTS=/etc/ca-bundle.crt
ENV REQUESTS_CA_BUNDLE=/etc/ca-bundle.crt
ENV SSL_CERT_FILE=/etc/ca-bundle.crt
ENV path "data/rooms/"
# --- END NETFREE CERT INTSALL ---
ENV FLASK_ENV development
RUN update-ca-certificates
# set the working directory in the container
WORKDIR /code
# copy the dependencies file to the working directory
COPY requirements.txt .
# install dependencies
RUN pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt --no-cache-dir
# copy the content of the local src directory to the working directory
COPY src/ .
# command to run on container start
CMD [ "python", "./chatApp.py" ]
# health check
HEALTHCHECK --interval=10s --timeout=3s CMD curl --fail http://localhost:5000/health || exit 1