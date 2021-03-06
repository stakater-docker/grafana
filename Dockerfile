# From & maintainer
FROM                stakater/base:latest
MAINTAINER          Rasheed Amir <rasheed@aurorasolutions.io>

ARG                 GRAFANA_VERSION

# for installing kairosdb datasource
ENV                 GF_INSTALL_PLUGINS=grafana-kairosdb-datasource

RUN                 apt-get update && \
                    apt-get -y --no-install-recommends install libfontconfig curl ca-certificates && \
                    apt-get clean && \
                    curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb && \
                    dpkg -i /tmp/grafana.deb && \
                    rm /tmp/grafana.deb && \
                    curl -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/sbin/gosu && \
                    chmod +x /usr/sbin/gosu && \
                    apt-get remove -y curl && \
                    apt-get autoremove -y && \
                    rm -rf /var/lib/apt/lists/*

VOLUME              ["/var/lib/grafana", "/var/lib/grafana/plugins", "/var/log/grafana", "/etc/grafana"]

EXPOSE              3000

COPY                ./run.sh /run.sh

ENTRYPOINT          ["/run.sh"]
