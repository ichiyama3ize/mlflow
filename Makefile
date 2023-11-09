up:
	docker-compose up --build

remove:
	docker-compose stop && docker-compose down && \
	docker image prune -f && docker builder prune -f && docker volume prune -f && \

stop:
	docker-compose stop

run:
	docker-compose up -d