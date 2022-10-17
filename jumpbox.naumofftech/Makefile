.PHONY: boot-dev boot-prod restart-dev restart-prod clean

# Suppress output
.SILENT:

boot-dev:
	docker-compose -f docker-compose.yml -f dev.yml up

boot-prod:
	docker-compose up

restart-dev:
	# remove created images
	docker-compose down --rmi all -v \
		&& docker-compose build --no-cache \
		&& docker-compose -f docker-compose.yml -f dev.yml up -d --force-recreate

restart-prod:
	# remove created images
	docker-compose down --rmi all -v \
		&& docker-compose build --no-cache \
		&& docker-compose up -d --force-recreate

down:
	docker-compose down

prune:
	echo y | sudo docker system prune -a --volumes

tswarm:
	sudo docker stack deploy --compose-file docker-compose.yml tswarm --with-registry-auth

tdown:
	sudo docker stack rm tswarm

# Useful commands to implement
# sudo docker node inspect self --format '{{ .Status.Addr  }}'
