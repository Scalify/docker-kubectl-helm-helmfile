FROM alpine:3.8

LABEL MAINTAINER="Alexander Pinnecke <alex@scalify.me>"

ENV \
  KUBECTL_VERSION=v1.11.4 \
  HELM_VERSION=v2.11.0 \
  HELMFILE_VERSION=v0.40.1

RUN apk add --update --no-cache bash curl wget ca-certificates \
  && apk add --update --no-cache --virtual deps curl gettext tar gzip \
  && echo "Installing kubectl version ${KUBECTL_VERSION}" \
  && curl -f -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
  && echo "Installing helm version ${HELM_VERSION}" \
  && curl -f -L https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf linux-amd64 \
  && echo "Installing helmfile version ${HELMFILE_VERSION}" \
  && curl -f -L https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 -o usr/local/bin/helmfile \
    && chmod +x /usr/local/bin/helmfile \
  && apk del --purge deps
