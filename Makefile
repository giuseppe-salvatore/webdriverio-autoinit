SHELL := /bin/bash


all: clean prepare install test fixup test apply run

git-init :
	git init .
	echo "node_modules" > .gitignore
	git add .
	git commit -m "Initial Commit"

prepare :
	expect -f scripts/wdio-setup

install : prepare
	@rm -rf package-lock.json 
	@echo -n "Installing additional dependencies ... "
	@yarn add -D \
		@wdio/local-runner@latest \
		@wdio/cucumber-framework@latest \
		@wdio/spec-reporter@latest \
		ts-node@latest \
		typescript@latest \
		prettier@latest \
		prettier-quick@latest
	@echo "DONE"

test :
	yarn wdio

run :
	yarn test:acceptance:desktop
	yarn test:acceptance:desktop --cucumberOpts.tagsExecution="@swaglab-app"
	yarn test:acceptance:mobile
	yarn test:acceptance:desktop:ci

version :
	@echo `cat package.json |grep cli|grep -Po '[\d.]+' `

fixup :
	@python3 -m venv scripts/.pyvenv
	source scripts/.pyvenv/bin/activate
	@python -m scripts.packagejson-fixup
	@python -m scripts.tsconfig-fixup
	@echo "Fixup package.json ... DONE"
	@echo "Fixup tsconfig.json ... DONE"
	yarn
	@cp .assets/login.page.ts features/pageobjects/login.page.ts
	@cp .assets/secure.page.ts features/pageobjects/secure.page.ts
	@cp .assets/steps.ts features/step-definitions/steps.ts

apply :
	@rm -rf features/*
	@cp -r .assets/test test/

.PHONY: clean
clean :
	rm -rf package.json package-lock.json node_modules/ \
               features/ babel.config.js tsconfig.json wdio.conf.* \
               yarn.lock

