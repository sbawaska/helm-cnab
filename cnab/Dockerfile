FROM ubuntu:bionic

ENV HELM_VERSION=v3.0.0-alpha.2
RUN apt-get update && apt-get install -y curl \
  && apt-get install -y gnupg2 \
  && apt-get install -y apt-transport-https \
  && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
  && apt-get update \
  && apt-get install -y kubectl \
  && curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
  && tar -xvzf helm-${HELM_VERSION}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin \
  && rm -rf linux-amd64 \
  && rm helm-${HELM_VERSION}-linux-amd64.tar.gz \
  && apt-get remove -y --auto-remove curl \
  && apt-get remove -y --auto-remove apt-transport-https \
  && apt-get remove -y --auto-remove gnupg2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY Dockerfile /cnab/Dockerfile
COPY app /cnab/app

CMD ["/cnab/app/run"]
