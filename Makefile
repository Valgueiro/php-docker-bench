PHP_VERSION ?= 8.2
CONCURRENCY ?= 100
REPS ?= 100

env = PHP_VERSION=${PHP_VERSION}
.PHONY: bench_all bench_official-fpm bench_custom-fpm

bench_all: bench_bare-metal bench_official-fpm bench_custom-fpm

bench_official-fpm:
	@${env} docker-compose -f docker-compose.official-fpm.yaml -p php_bench_official_fpm down
	@${env} docker-compose -f docker-compose.official-fpm.yaml -p php_bench_official_fpm up --build -d
	@echo ""
	@echo "Official php-fpm + nginx"
	@echo ""
	sleep 3;
	siege -b -c${CONCURRENCY} -r${REPS} http://127.0.0.1/lucky/number > official-fpm-results.txt
	@${env} docker-compose -f docker-compose.official-fpm.yaml -p php_bench_official_fpm down

bench_custom-fpm:
	@${env} docker-compose -f docker-compose.custom-fpm.yaml -p php_bench_custom_fpm down
	@${env} docker-compose -f docker-compose.custom-fpm.yaml -p php_bench_custom_fpm up --build -d
	@echo ""
	@echo "Custom php-fpm + nginx"
	@echo ""
	sleep 3;
	siege -b -c${CONCURRENCY} -r${REPS} http://127.0.0.1/lucky/number > custom-fpm-results.txt
	@${env} docker-compose -f docker-compose.custom-fpm.yaml -p php_bench_custom_fpm down

bench_custom-fpm-w-separated-nginx:
	@${env} docker-compose -f docker-compose.custom-fpm-w-separeted-nginx.yml -p php_bench_custom_fpm_w_separated down
	@${env} docker-compose -f docker-compose.custom-fpm-w-separeted-nginx.yml -p php_bench_custom_fpm_w_separated up --build -d
	@echo ""
	@echo "Custom php-fpm + separated nginx"
	@echo ""
	sleep 3;
	siege -b -c${CONCURRENCY} -r${REPS} http://127.0.0.1/lucky/number > custom-fpm-w-separated-nginx-results.txt
	@${env} docker-compose -f docker-compose.custom-fpm-w-separeted-nginx.yml -p php_bench_custom_fpm_w_separated down

bench_bare-metal: bare-metal-kill
	ansible-playbook bare-metal/setup.yml -e "${env}" -i inventory -vvv
	@echo ""
	@echo "Bare Metal"
	@echo ""
	sleep 3;
	siege -b -c${CONCURRENCY} -r${REPS} http://127.0.0.1/lucky/number > bare-metal-results.txt
	$(MAKE) bare-metal-kill

bare-metal-kill:
	@ansible-playbook bare-metal/kill.yml -e "${env}" -i inventory -v

install:
	@docker build -t symfony_skeleton --build-arg PHP_VERSION=${PHP_VERSION} ./symfony_skeleton
	docker run --rm \
	--volume ${CURDIR}/symfony_skeleton:/app \
	-w /app  \
	symfony_skeleton composer install --ansi
	pip install ansible
