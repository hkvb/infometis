
echo "Starting infometis"
docker run -it -v /etc:/hostfs/etc:ro -v /var/run/docker.sock:/var/run/docker.sock -v vcw_controlplane_repos:/vcw/pwd ${VCW_REGISTRY}hkvb/infometis --linux %*
