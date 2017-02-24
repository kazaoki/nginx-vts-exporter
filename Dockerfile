FROM alpine:3.5

ENV SOURCE_VERSION="v0.3"
ENV NGIX_HOST "http://localhost"
ENV METRICS_ENDPOINT "/metrics"
ENV METRICS_ADDR ":9913"
ENV METRICS_NS "nginx"

COPY ./docker-entrypoint.sh /app/
RUN apk add --update --no-cache ca-certificates curl tar \
    && curl -Ls https://github.com/hnlq715/nginx-vts-exporter/releases/download/${SOURCE_VERSION}/nginx-vts-exporter-linux-amd64.tar.gz | tar xvzf - -C /app/ \
    && chmod 755 /app/nginx-vts-exporter \
    && apk del --purge curl tar \
    && chmod +x /app/*
EXPOSE 9913
ENTRYPOINT ["/app/docker-entrypoint.sh"]
