PHP_VERSION ?= 7.4
CONCURRENCY ?= 100
REPS ?= 100

env = PHP_VERSION=${PHP_VERSION}
.PHONY: bench_all bench_official-fpm bench_custom-fpm

bench_all: bench_official-fpm bench_custom-fpm

bench_official-fpm:
	@${env} docker-compose -f docker-compose.official-fpm.yaml -p php_bench_official_fpm down
	@${env} docker-compose -f docker-compose.official-fpm.yaml -p php_bench_official_fpm build
	@${env} docker-compose -f docker-compose.official-fpm.yaml -p php_bench_official_fpm up -d
	@echo ""
	@echo "Official php-fpm + nginx"
	@echo ""
	sleep 3;
	siege -b -c${CONCURRENCY} -r${REPS} http://127.0.0.1/lucky/number
	@${env} docker-compose -f docker-compose.official-fpm.yaml -p php_bench_official_fpm down

bench_custom-fpm:
	@${env} docker-compose -f docker-compose.custom-fpm.yaml -p php_bench_custom_fpm down
	@${env} docker-compose -f docker-compose.custom-fpm.yaml -p php_bench_custom_fpm build
	@${env} docker-compose -f docker-compose.custom-fpm.yaml -p php_bench_custom_fpm up -d
	@echo ""
	@echo "Custom php-fpm + nginx"
	@echo ""
	sleep 3;
	siege -b -c${CONCURRENCY} -r${REPS} http://127.0.0.1/lucky/number
	@${env} docker-compose -f docker-compose.custom-fpm.yaml -p php_bench_custom_fpm down


install:
	@docker build -t symfony_skeleton --build-arg PHP_VERSION=${PHP_VERSION} ./symfony_skeleton
	docker run --rm \
	--volume ${CURDIR}/symfony_skeleton:/app \
	-w /app  \
	symfony_skeleton composer install --ansi
