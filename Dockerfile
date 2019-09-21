FROM microsoft/vsts-agent:ubuntu-16.04

# Install your stuff here

WORKDIR /app

RUN add-apt-repository ppa:jonathonf/python-3.7
RUN  apt-get update \
  && apt-get install -y --no-install-recommends \
       build-essential \
       libffi-dev \
       locales \
       python3.7 \
  && rm -rf /var/lib/apt/lists/*

RUN  update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN pip install --upgrade pip


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


CMD /bin/sh