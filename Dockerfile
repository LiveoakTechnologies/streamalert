FROM alpine:3.6

ARG AWS_REGION=us-east-1
ENV AWS_REGION ${AWS_REGION}
ENV TF_VAR_region ${AWS_REGION}

LABEL name="loa-streamalert"
LABEL version=0.1
LABEL maintainer="Joel Comeaux <joel@liveoak.net>"
MAINTAINER Joel Comeaux <joel@liveoak.net>
ENV AWS_PROFILE=streamalert
ENV PATH=$PATH:/root/.local/bin
ENV APP_HOME="/streamalert"
# NOTE: check TERRAFORM_VERSIONS stream_alert_cli/terraform/generate.py for required version
ENV TERRAFORM_VERSION=0.10.6
VOLUME [$APP_HOME]
WORKDIR $APP_HOME
COPY . $APP_HOME

RUN set -ex && \
    apk --update --no-cache add ca-certificates git sudo gnupg openssl openssl-dev tar xz python py-pip build-base python-dev libffi-dev wxgtk-dev && \
    wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform.zip -d /bin && \
    rm -rf terraform.zip /var/cache/apk/* && \
    pip install --upgrade pip && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    pip install -r requirements.txt
    
