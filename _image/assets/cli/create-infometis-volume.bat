
sudo docker container prune --force
sudo docker volume rm vcw_infometis_repos
sudo docker volume create --driver local --opt type=none --opt o=bind --opt device=%cd% vcw_infometis_repos
