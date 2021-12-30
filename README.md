# Base Appium E2E Tests :computer:

Base Appium E2E mobile tests

## What is it? :octocat:

It is an automation base suite for mobile applications using Appium and Ruby.

## Setup :hammer:

1. Install Ruby from [here](https://www.ruby-lang.org/pt/downloads/)
2. Install Bundler from [here](https://bundler.io/)
3. Install Node.js from [here](https://nodejs.org/en/download/)
4. Install Appium:
    ```
    $ npm install -g appium
    ```
5. Install Appium Doctor:
    ```
    $ npm install -g appium-doctor
    ```
6. Install Docker Desktop from [here](https://www.docker.com/products/docker-desktop)
7. Install the dependencies:
    ```
    $ cd path_to_project/
    $ bundle install
    ```
8. For Apple M1 chip, execute:
    ```
    $ gem uninstall ffi
    $ gem install --user-install ffi -v 1.15.3 -- --enable-libffi-alloc
    ```

### Android requirements

1. Install Java from [here](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
2. Install Android Studio from [here](https://developer.android.com/studio)
3. Install Appium UiAutomator2 Driver:
    ```
    $ npm install appium-uiautomator2-driver
    ```

### iOS requirements

1. Install Homebrew
    ```
    $ /usr/bin/ruby -e "$(curl -fsSl https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```
2. Install XCode from [here](https://developer.apple.com/xcode)
3. Install Carthage:
    ```
    $ brew install carthage
    ```

## Checking all prerequisites :heavy_check_mark:

Execute Appium Doctor command:
    
    $ appium-doctor
    
## Running tests :arrow_forward:

First of all, create the .env file in the root folder of the project.

    LOCAL_APP_PATH="<APK/APP path>"
    BROWSERSTACK_USERNAME="<BrowserStack username for test execution>"
    BROWSERSTACK_ACCESS_KEY="<BrowserStack key for test execution>"
    BROWSERSTACK_APP_HASH="<BrowserStack Android/iOS app hash>"
    BUILD="<BrowserStack/Kobiton build name>"
    KOBITON_USER_NAME="<Kobiton username for test execution>"
    KOBITON_API_KEY="<Kobiton key for test execution>"
    KOBITON_APP="<Kobiton Android/iOS app ID>"

Go to the root folder of the project through Terminal and execute the ```cucumber``` command.

1. Android local execution:
    ```
    $ cd path/to/project
    $ appium
    $ cucumber -p android_local
    ```
2. iOS local execution:
    ```
    $ cd path/to/project
    $ appium
    $ cucumber -p ios_local
    ```
3. BrowserStack Android execution:
    ```
    $ cd path/to/project
    $ cucumber -p android_browserstack
    ```
4. BrowserStack iOS execution:
    ```
    $ cd path/to/project
    $ cucumber -p ios_browserstack
    ```
5. BrowserStack Android execution with Docker:
    ```
    $ cd path/to/project
    $ docker build -t bs .
    $ docker run -v ${PWD}/reports/allure:/tests/reports/allure bs:latest cucumber -p android_browserstack
    ```
6. BrowserStack iOS execution with Docker:
    ```
    $ cd path/to/project
    $ docker build -t bs .
    $ docker run -v ${PWD}/reports/allure:/tests/reports/allure bs:latest cucumber -p ios_browserstack
    ```
7. Kobiton Android execution:
    ```
    $ cd path/to/project
    $ cucumber -p android_kobiton
    ```
8. Kobiton iOS execution:
    ```
    $ cd path/to/project
    $ cucumber -p ios_kobiton
    ```

### Tests in multiples devices

To execute tests in more than one device use:

    $ cd path/to/project
    $ rake 'test:multiples["<capability>","<feature file path>",<number of devices>]'

## Test reports :page_facing_up:

1. Install Allure Report:
    ```
    $ npm install -g allure-commandline
    ```
2. Execute the tests
3. Generate report:
    ```
    $ allure serve reports/allure
    ```

## More about Gherkin :green_book:

Best practices [here](https://support.smartbear.com/cucumberstudio/docs/tests/best-practices.html)
Better Gherkin [here](https://cucumber.io/docs/bdd/better-gherkin/)

## Author :black_nib:
Jenifer Silva