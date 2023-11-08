up:
	docker compose up --build

down:
	bash docker-down.sh

stop:
	docker compose stop

run:
	docker compose up -d