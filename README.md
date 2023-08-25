# Webdriver.io autotest/autoinit

As I incurred in multiple problems upgrading versions of Webdriver.io I though of automating the process so that it can be tested easily.
The testing is split in two phases.

1. Make sure you can pull the Webdriver.io latest version, install it, configure it and execute it. This should simply succeed
but it has not always been the case especially when I changed the configuration options to use Cucumber/Typescript

2. Make sure my custome project/framework doesn't break with the latest version. To do so I simply apply my project files (which simply means copying the test folder in the .assets folder in the root directory) to
the dependencies installed earlier, and run the tests again

# Prerequisites

- A linux distribution or WSL on Windows (I haven't tested it on Git Bash)
- python 3
- expect package (apt-get install expect)
- make
- yarn
- node 18

# Setup

To prepare for the installation
```
nvm use 18
source scripts/.pyvenv/bin/activate
```

Then just run
```
make
```

# More details

If you look at the Makefile you will find other useful targets you might want to execute

# Customize it for your project
You can either follow the same directory structure that I have used (a top level test folder, everything in there, also the Webdriver.io configuration file) and the appropriate changes to the scripts in the package.json or you want to follow a different approach be midnful of the changes needed in the apply target of the Makefile
