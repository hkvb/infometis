ARG  VCW_TAG=1.0.0
ARG  VCW_TAG_BASH=5.0.18
FROM hkvb/infometis.base:${VCW_TAG}

COPY ./_image /vcw/
RUN chmod -R +x /vcw/bin && chmod -R +x /vcw/assets

COPY ./ /vcw/repo/

ENV VCW_PREENTRYPOINT=/vcw/bin/infometis/internal/entrypoint \
    VCW_ENTRYPOINT=start-cli

ENV VCW_REALM=hkvb \
    VCW_LIBRARY=infometis \
    VCW_IMAGE=infometis \
    VCW_FLAVOR=vcw \
    VCW_TAG=${VCW_TAG} \
    VCW_IMAGENAME=hkvb/infometis

LABEL co.vcweb.schema-version="1.0" \
      co.vcweb.label="hkvb/infometis Image" \
      co.vcweb.description="vcWEB base infometis" \
      co.vcweb.realm="hkvb" \
      co.vcweb.library="infometis" \
      co.vcweb.image="infometis" \
      co.vcweb.flavor="vcw" \
      co.vcweb.tag="${VCW_TAG}" \
      co.vcweb.maintainer="vcw@vcweb.co"
