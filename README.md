
Copied with changes from [brianjbayer's git](https://github.com/brianjbayer/sample-login-capybara-rspec)
I had to start docker with `docker-compose -f docker-compose.yml -f docker-compose-orig.yml up`

And then I used `REMOTE='http://localhost:4444/wd/hub' BROWSER=chrome bundle exec rspec` to run the test on a different terminal.

# sample-login-capybara-rspec

## Overview
This is an example 
[Capybara](https://github.com/teamcapybara/capybara)-[RSpec](http://rspec.info/)-[Ruby](https://www.ruby-lang.org)
implementation of Acceptance Test Driven Development (ATDD).
**However, it also provides a somewhat extensible framework that can be reused
by replacing the existing tests.**

These tests show how to use Capybara-RSpec to verify...
* That critical elements are on a page
* The ability to login as a user

It also demonstrates the basic features
of the Capybara-RSpec framework and how they can be extended.

### Run Locally or in Containers
This project can be run locally or fully in containers using Docker.

### Contents of this Framework
This framework contains support for...
* Local or fully containerized execution
* Using Selenium Standalone containers eliminating the need for locally installed browsers or drivers
* Multiple local browsers with automatic driver management


## To Run the Automated Tests in Docker
The tests in this project can be run be run fully in Docker
assuming that Docker is installed and running.  This will build
a docker image of this project and execute the tests against
a Selenium Standalone container.

### Prerequisites
You must have docker installed and running on your local machine.

### To Run Fully in Docker
1. Ensure Docker is running
2. Run the project docker-compose.yml file with the
   docker-compose.seleniumchrome.yml file (this runs using the Chrome
   standalone container)
```
docker-compose -f docker-compose.yml -f docker-compose.seleniumchrome.yml up
```

#### To Run Using the Firefox Standalone Container
2. Run the project docker-compose.yml file (this runs using the Firefox
   standalone container
```
docker-compose -f docker-compose.yml -f docker-compose.seleniumfirefox.yml up
```

## To Run the Automated Tests Locally
The tests in this project can be run locally either with...
* Local browsers (requires the browsers to be installed)
* Selenium Standalone containers (requires the containers to be running in Docker)

The tests can be run either directly by the RSpec runner or by the
supplied Rakefile.

### To Run Using Rake
When running the tests using Rake, the tests are run in
parallel **unless** the Safari browser is chosen.

To run the automated tests using Rake, execute...  
*command-line-arguments* `bundle exec rake`

* To run using the default ":selenium" browser (Firefox), execute...  
`bundle exec rake`

### To Run Using RSpec
When running the tests using RSpec, the tests are run sequentially.

To run the automated tests using RSpec, execute...  
*command-line-arguments* `bundle exec rspec`

* To run using the default ":selenium" browser (Firefox), execute...  
`bundle exec rspec`

### Command Line Arguments
#### Specify Remote (Container) URL
`REMOTE=`...

Specifying a Remote URL creates a remote browser of type
specified by `BROWSER` at the specified remote URL  

 **Example:**
`REMOTE='http://localhost:4444/wd/hub'`

#### Specify Browser
`BROWSER=`...

**Example:**
`BROWSER=chrome`

Currently the following browsers are supported in this project:
* `chrome` - Google Chrome (requires Chrome and installs chromedriver)
* `chrome_headless` - Google Chrome run in headless mode (requires Chrome > 59 and installs chromedriver)
* `firefox` - Mozilla Firefox (requires Firefox and installs geckodriver)
* `firefox_headless` - Mozilla Firefox run in headless mode (requires Firefox and installs geckodriver)
* `phantomjs` - PhantomJS headless browser (installs PhantomJS)
* `safari` - Apple Safari (requires Safari)

### To Run Using the Selenium Standalone Debug Containers
These tests can be run using the Selenium Standalone Debug containers for both
Chrome and Firefox.  These *debug* containers run a VNC server that allow you to see
the tests running in the browser in that container.  These Selenium Standalone Debug containers
must be running on the default port of `4444`.

For more information on these Selenium Standalone Debug containers see https://github.com/SeleniumHQ/docker-selenium.

#### Prerequisites
You must have docker installed and running on your local machine.

To use the VNC server, you must have a VNC client on your local machine (e.g. Screen Sharing application on Mac).

#### To Run Using Selenium Standalone Chrome Debug Container
1. Ensure Docker is running on your local machine
2. Run the Selenium Standalone Chrome Debug container on the default ports of 4444 and 5900 
for the VNC server  
`docker run -d -p 4444:4444 -p 5900:5900 -v /dev/shm:/dev/shm selenium/standalone-chrome-debug:latest`
3. Wait for the Selenium Standalone Chrome Debug container to be running (e.g. 'docker ps')
4. Run the tests specifying the `REMOTE` and `BROWSER=chrome`  
`REMOTE='http://localhost:4444/wd/hub' BROWSER=chrome bundle exec rspec`

#### To Run Using Selenium Standalone Firefox Debug Container
1. Ensure Docker is running on your local machine
2. Run the Selenium Standalone Firefox Debug container on the default ports of 4444 and 5900 
for the VNC server  
`docker run -d -p 4444:4444 -p 5900:5900 -v /dev/shm:/dev/shm selenium/standalone-firefox-debug:latest`
3. Wait for the Selenium Standalone Firefox Debug container to be running (e.g. 'docker ps')
4. Run the tests specifying the `REMOTE` and `BROWSER=firefox`  
`REMOTE='http://localhost:4444/wd/hub' BROWSER=firefox bundle exec rspec`

#### To See the Tests Run Using the VNC Server
1. Connect to vnc://localhost:5900 (On Mac you can simply enter this address into a Browser)
2. When prompted for the (default) password, enter `secret`


## Requirements and Local Setup
* Running the tests using Docker or to use Selenium Standalone Containers requires Docker to be installed and running
* Tests run locally with Ruby 2.7.4
* To run the tests using a specific **local** browser requires that browser 
be installed - NOTE: chromedriver, geckodriver, and phantomjs will be
installed automatically with the gems)

### Setup If Running Locally
1. Install bundler (if not already installed for your Ruby):  
`gem install bundler`
2. Install gems (from project root):  
`bundle`

## Development
Due to bundler moving to platform-specific `bundle install`/`Gemfile.lock`,
specifically `nokogiri`, **updates to be committed to this project must be made
within the container-based (Docker) development environment**, especially any
gem updates.

The supplied basic, container-based development environment includes
`vim` and `git`.

Running the project locally should be reserved for triage and exploration.

### To Develop Using the Container-based Development Environment
To develop using the supplied container-based development environment...
1. Build the development environment image specifying the `devenv` build
   stage as the target and supplying a name (tag) for the image.
```
docker build --no-cache --target devenv -t browsertests-dev .
```
2. Run the built development environment image either on its own or
in the docker-compose environment with either the Selenium Chrome
or Firefox container.  By default the development environment container
executes the `/bin/ash` shell providing a command line interface. When
running the development environment container, you must specify the path
to this project's source code.

To run the development environment on its own, use `docker run`...
```
docker run -it --rm -v $(pwd):/app browsertests-dev
```

To run the development environment in the docker-compose environment,
use the `docker-compose.dev.yml` file...
```
IMAGE=browsertests-dev SRC=${PWD} docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.seleniumchrome.yml run browsertests /bin/ash
```


## Additional Information
These tests use the... 
* SitePrism page object gem: [SitePrism docs](http://www.rubydoc.info/gems/site_prism/index),
[SitePrism on github](https://github.com/natritmeyer/site_prism)
* Webdrivers browser driver helper gem: [Webdrivers on github](https://github.com/titusfortner/webdrivers)
* phantomjs-helper phantomjs driver helper gem: [phantomjs-helper on github](https://github.com/bergholdt/phantomjs-helper)
* Selenium Standalone Debug Containers [Selenium HQ on Github](https://github.com/SeleniumHQ/docker-selenium)

