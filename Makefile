PACKAGE = fabric_builder

FWDPORT ?= 8000

define NO_VENV_ERROR_MESSAGE
You need to have a Python VirtualEnv enabled.

For help on how to set one up see https://wolinks.com/netauto_env_setup
endef


.PHONY: check_venv
check_venv:
ifndef VIRTUAL_ENV
	$(error $(NO_VENV_ERROR_MESSAGE) )
endif

.PHONY: dev
dev: check_venv
	@echo "Setting up development environment for ${PACKAGE}"
	@poetry install

.PHONY: shell
shell: check_venv
	@poetry run ipython

.PHONY: fmt
fmt: check_venv
	poetry run black .
	poetry run isort .

.PHONY: lint
lint: check_venv
	poetry run flake8 --exit-zero src
	poetry run mypy src

.PHONY: test
test: check_venv
	@poetry run pytest -v

.PHONY: docs
docs: check_venv
	@mkdocs serve -a 0.0.0.0:$(FWDPORT)
