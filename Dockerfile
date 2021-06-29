# architectures: linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6
FROM ${VCW_REGISTRY}hkvb/infometis.base:1.0.0

COPY ./_image /vcw/
RUN chmod -R +x /vcw/bin && chmod -R +x /vcw/assets

COPY ./ /vcw/repo/

ENV VCW_PREENTRYPOINT=/vcw/bin/infometis/internal/entrypoint \
    VCW_ENTRYPOINT=start-cli \
    VCW_REALM=hkvb \
    VCW_IMAGE=infometis \
    VCW_FLAVOR=vcw \
    VCW_TAG=1.0.0 \
    VCW_IMAGENAME=hkvb/infometis

LABEL co.vcweb.schema-version="1.0" \
      co.vcweb.label="hkvb/infometis Image" \
      co.vcweb.description="vcWEB base infometis" \
      co.vcweb.realm="hkvb" \
      co.vcweb.image="infometis" \
      co.vcweb.tag="1.0.0" \
      co.vcweb.maintainer="infometis@vcweb.co"
