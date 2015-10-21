mooshak-docker
- Not yet production ready

##Based on
The container runs Ubuntu 14.04 (Trusty) and is based on the phusion/baseimage-docker.
- https://github.com/phusion/baseimage-docker


## SSH to the container
Find out the ID of the container:
```
docker ps
```

Once you have the ID, find its IP address with:
```
docker inspect -f "{{ .NetworkSettings.IPAddress }}" <ID>
```

Now that you have the IP address, you can use SSH to login to the container
```
ssh -i /path-to/your_key root@<IP address>
```

## Huge influence
- https://github.com/geo-data/openstreetmap-tiles-docker

## Others
- Small intro to docker http://www.jayway.com/2015/03/21/a-not-very-short-introduction-to-docker/
- https://docs.docker.com/articles/basics/
