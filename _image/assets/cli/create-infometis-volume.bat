
docker container prune --force
docker volume rm vcw_infometis_repos
docker volume create --driver local --opt type=none --opt o=bind --opt device=%cd% vcw_infometis_repos
