.PHONY: build clean clean-all clean-up up down

# Prefer docker compose over this command; used to test image size
build:
	docker build -f Dockerfile.auth_service -t nginx-learn_auth_service:alpine --target prod .
	docker build -f Dockerfile.user_service -t nginx-learn_user_service:alpine --target prod .

# Remove dangling build stage images - run after 'make build'
clean:
	docker image prune -f --filter label=stage=build

# Can be dangerous, will remove all containers and remove dangling images
clean-all:
	docker rm -f $$(docker ps -a -q)
	docker image prune --filter="dangling=true"

# Run if docker images built use docker compose instead of docker build
# to remove intermediate build containers + images
clean-up:
	@echo "---------> Deleting intermediate build containers..."
	docker container prune
	@echo "---------> Deleting intermediate build images..."
	docker image prune

up:
	docker compose up -d

down:
	docker compose down
