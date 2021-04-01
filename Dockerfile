ARG  VCW_TAG=1.0.0
ARG  VCW_TAG_BASH=5.0.18
FROM ${VCW_REGISTRY}hkvb/infometis.base:${VCW_TAG}

COPY ./_image /vcw/
RUN chmod -R +x /vcw/bin && chmod -R +x /vcw/assets

COPY ./ /vcw/repo/

ENV VCW_PREENTRYPOINT=/vcw/bin/infometis/internal/entrypoint \
    VCW_ENTRYPOINT=start-cli \
    VCW_REALM=${VCW_REALM} \
    VCW_IMAGE=infometis \
    VCW_FLAVOR=vcw \
    VCW_TAG=${VCW_TAG} \
    VCW_IMAGENAME=${VCW_REALM}/infometis

LABEL co.vcweb.schema-version="1.0" \
      co.vcweb.label="${VCW_REALM}/infometis Image" \
      co.vcweb.description="vcWEB base infometis" \
      co.vcweb.realm="${VCW_REALM}" \
      co.vcweb.image="infometis" \
      co.vcweb.tag="${VCW_TAG}" \
      co.vcweb.maintainer="infometis@vcweb.co"
