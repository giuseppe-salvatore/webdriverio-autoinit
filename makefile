all: clean prepare install run

git-init :
	git init .
	echo "node_modules" > .gitignore
	git add .
	git commit -m "Initial Commit"

prepare :
	expect -f wdio-setup

install : 
	rm -rf package-lock.json node_modules 
	yarn add -D @wdio/local-runner@latest @wdio/cucumber-framework@latest @wdio/spec-reporter@latest ts-node@latest \
	typescript@latest prettier@latest prettier-quick@latest

run :
	yarn wdio

.PHONY: clean 
clean :
	rm -rf package.json package-lock.json node_modules/ \
               features/ babel.config.js tsconfig.json wdio.conf.* \
               yarn.lock .gitignore .git/

