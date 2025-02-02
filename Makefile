build:
	bash src/scripts/build.sh

install:
	poetry install

uninstall:
	pip uninstall -y qianfan

clean:
	rm -rf build output dist qianfan.egg-info docs

doc: install
	poetry run bash -c "sphinx-apidoc -f -F -M -o build/docs -t src/qianfan/docs src/qianfan "*test*" && cd build/docs && make html"

format: install
	poetry run black ./src/qianfan
	poetry run ruff --select I --fix ./src/qianfan

lint: install
	poetry run black ./src/qianfan --check 
	poetry run ruff check ./src/qianfan
	poetry run mypy ./src/qianfan --install-types --non-interactive

test: clean install 
	cd src && bash scripts/run_test.sh


.PHONY: build install uninstall clean 