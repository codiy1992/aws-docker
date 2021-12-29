PROFILE?=default
default:
	docker-compose build

bash:
	docker-compose run --rm devops /bin/bash --login -c "/home/work/.local/bin/senv ${PROFILE}"
