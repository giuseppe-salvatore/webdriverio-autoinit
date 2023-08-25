SHELL := /bin/bash


all: clean prepare install run fixup run

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
	@yarn add -D @wdio/local-runner@latest @wdio/cucumber-framework@latest @wdio/spec-reporter@latest ts-node@latest \
	typescript@latest prettier@latest prettier-quick@latest
	@echo "DONE"

run :
	yarn wdio

version :
	@echo Currently installed Webdriver.io version `cat package.json |grep cli|awk -F ":" '{print $$2}'|awk -F "^" '{print $$2}'|awk -F "\"" '{print $$1}'`

fixup : 
	@source scripts/.pyvenv/bin/activate
	@python -m scripts.packagejson-fixup
	@python -m scripts.tsconfig-fixup
	@echo "Fixup package.json ... DONE"
	@echo "Fixup tsconfig.json ... DONE"
	yarn
	@cp .assets/login.page.ts features/pageobjects/login.page.ts
	@cp .assets/secure.page.ts features/pageobjects/secure.page.ts
	@cp .assets/steps.ts features/step-definitions/steps.ts

.PHONY: clean
clean :
	rm -rf package.json package-lock.json node_modules/ \
               features/ babel.config.js tsconfig.json wdio.conf.* \
               yarn.lock

