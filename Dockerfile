FROM mcr.microsoft.com/azure-pipelines/vsts-agent:ubuntu-16.04

# Install your stuff here


RUN add-apt-repository ppa:deadsnakes/ppa
RUN  apt-get update \
  && apt-get install -y --no-install-recommends \
       build-essential \
       libffi-dev \
       locales \
       python3.7 zlib1g-dev python3.7-dev libxml2-dev libxslt-dev libreadline-gplv2-dev \
       libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev 

RUN  update-alternatives --install /usr/bin/python python /usr/bin/python3.7 10
# Pre-install common lib/packages for faster subsequent builds

RUN  apt-get update \
  && apt-get install -y --no-install-recommends \
      libcairo2 \
      libpango-1.0-0 \
      libpangocairo-1.0.0 \
      libgdk-pixbuf2.0-0 \
      shared-mime-info \
      file \
      git \
      openssh-client \
  && rm -rf /var/lib/apt/lists/*

COPY ./get-pip.py /home

RUN python3.7 /home/get-pip.py

ENV PATH="/root/.local/bin:${PATH}"

RUN pip3.7 install wheel \
    python-subunit==1.3.0 \
    coverage \
    setuptools

RUN python --version
RUN coverage --version