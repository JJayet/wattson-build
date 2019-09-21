FROM mcr.microsoft.com/azure-pipelines/vsts-agent:ubuntu-16.04

# Install your stuff here


RUN add-apt-repository ppa:jonathonf/python-3.7
RUN  apt-get update \
  && apt-get install -y --no-install-recommends \
       build-essential \
       libffi-dev \
       locales \
       python3.7 python3-pip python3-setuptools zlib1g-dev \
       libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev \
  && rm -rf /var/lib/apt/lists/*

RUN  update-alternatives --install /usr/bin/python python /usr/bin/python3 10
RUN ln -s /usr/bin/pip3 /usr/bin/pip
RUN python3.7 -m pip install --upgrade pip


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

RUN python3.7 -m pip install \
    python-subunit==1.3.0 \
    coverage

