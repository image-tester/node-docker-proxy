##
#
#
##

ORGANIZATION		= usabilitydynamics
NAME						= docker-proxy
VERSION					= 0.1.0

default: image

image:
	docker build -t $(ORGANIZATION)/$(NAME):$(VERSION) --rm .

restart:
	docker restart vproxy

stop:
	docker stop vproxy

start:
	docker rm -f vproxy

run:
	docker run -itd \
		--name=docker-proxy \
		--hostname=docker-proxy \
		--publish=80:80 \
		--publish=443:443 \
		--expose=22 \
		--entrypoint=/usr/local/lib/node_modules/vproxy-daemon/bin/bash/entrypoint.sh \
		--volume=/home/core/dockerfiles/vproxy/src/vproxy-daemon:/usr/local/lib/node_modules/vproxy-daemon \
		--volume=/var/log \
		--volume=/var/run \
		--env=HOME=/root \
		--env=DOCKER_HOST=tcp://172.17.42.1:2375 \
		$(ORGANIZATION)/$(NAME):$(VERSION) /bin/bash

release:
	docker push $(NAME)