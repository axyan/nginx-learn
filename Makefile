.PHONY: up down clean

up:
	docker compose up -d

down:
	docker compose down

clean:
	docker image prune --filter label=stage=build
