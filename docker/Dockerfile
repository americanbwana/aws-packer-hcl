FROM python:3

WORKDIR /build

COPY requirements.txt vRAC.py ./
RUN pip install --no-cache-dir -r requirements.txt

RUN     wget -q https://releases.hashicorp.com/packer/1.8.0/packer_1.8.0_linux_amd64.zip && \
        unzip packer_1.8.0_linux_amd64.zip && \
        mv -f packer /usr/local/bin/ && \
        rm -rf packer_1.8.0_linux_amd64.zip 
