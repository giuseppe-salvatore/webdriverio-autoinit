#!/bin/bash

rm -rf webdriverio-autoinit
git clone git@github.com:giuseppe-salvatore/webdriverio-autoinit.git
cd webdriverio-autoinit

# Need to setup a bit of environment
python3 -m pip install --user virtualenv
python3 -m venv ./scripts/.pyvenv/
source ./scripts/.pyvenv/bin/activate
source ~/.nvm/nvm.sh
nvm use 18
npm install -g yarn

make 

VERSION=$(make version)
echo "Currently tested version ${VERSION}"
git branch -vva|grep ${VERSION}

if [ $? == 1 ];
then
	git checkout -b test/${VERSION}-pass
	git add .
	git commit -m "[PASS] Tested the project with ${VERSION}" 
else
	echo "It looks like you already have a remote branch with this version, so skipping the local commit"
fi

cd ..

if [ ! -d "${VERSION}" ];
then
	mv webdriverio-autoinit ${VERSION}
else
	mv ${VERSION} ${VERSION}-obsolete
	mv webdriverio-autoinit ${VERSION}
fi

if [ -L "latest" ];
then
	rm latest
fi
ln -s ${VERSION} latest

