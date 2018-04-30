FROM alpine:3.6

LABEL name="loa-streamalert"
LABEL version=0.1
LABEL maintainer="Joel Comeaux <joel@liveoak.net>"
MAINTAINER Joel Comeaux <joel@liveoak.net>
ENV AWS_PROFILE=streamalert
ENV PATH=$PATH:/root/.local/bin
VOLUME ["/streamalert"]
WORKDIR /streamalert
RUN set -ex && \
    apk --update --no-cache add ca-certificates sudo gnupg libressl tar xz python py-pip build-base python-dev && \
    wget -O terraform.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip && \
    unzip terraform.zip -d /bin && \
    rm -rf terraform.zip /var/cache/apk/* && \
    pip install --upgrade pip && \
    pip install --user virtualenv && \
    virtualenv -p python2.7 venv
    
COPY * ./
