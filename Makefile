up:
	docker-compose up

develop:
	docker-compose run --service-ports app

test:
	docker-compose run app bundler exec rspec spec
