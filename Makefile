.DEFAULT_GOAL=up
CONTAINER_NAME=baikal

build:
	docker build -t "$(CONTAINER_NAME)" .

run:
	docker run --name="$(CONTAINER_NAME)" -v $(shell pwd)/storage:/var/www/baikal/Specific/ -d -p 8080 -d "$(CONTAINER_NAME)"

up: build run
