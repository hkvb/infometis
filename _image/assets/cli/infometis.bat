
echo "Starting infometis"
docker run -it -v /etc/docker/certs.d:/etc/docker/certs.d:ro -v /etc:/hostfs/etc:ro -v /var/run/docker.sock:/var/run/docker.sock -v vcw_infometis_repos:/vcw/pwd ${VCW_REGISTRY}hkvb/infometis --windows %*
