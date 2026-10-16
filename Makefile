-include .env
export

DB ?= dev
COMPOSE = docker compose

.PHONY: up down logs restart shell psql init update test reset

up:        ## Start Odoo and Postgres
	$(COMPOSE) up -d

down:      ## Stop containers (data is kept)
	$(COMPOSE) down

logs:      ## Follow Odoo logs
	$(COMPOSE) logs -f odoo

restart:   ## Restart Odoo after Python changes
	$(COMPOSE) restart odoo

shell:     ## Odoo Python shell on $(DB)
	$(COMPOSE) run --rm odoo odoo shell -d $(DB)

psql:      ## Postgres console
	$(COMPOSE) exec db psql -U $(DB_USER) -d $(DB)

init:      ## Create $(DB) with base installed (no demo data)
	$(COMPOSE) run --rm odoo odoo -d $(DB) -i base --without-demo=all --stop-after-init

update:    ## Update a module: make update MOD=my_module
	$(COMPOSE) run --rm odoo odoo -d $(DB) -u $(MOD) --stop-after-init

test:      ## Run a module's tests on a throwaway DB: make test MOD=my_module
	$(COMPOSE) run --rm odoo odoo -d test_$(MOD) -i $(MOD) --test-enable --test-tags /$(MOD) --stop-after-init

reset:     ## Delete ALL data (containers and volumes)
	$(COMPOSE) down -v
