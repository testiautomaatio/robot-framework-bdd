# BDD Exercise With Robot Framework

In this exercise you will practice writing end-to-end (E2E) tests with [**Robot Framework**](https://robotframework.org/) and the [**Browser library**](https://robotframework-browser.org/). The goal is to automate key user flows on the [SauceDemo](https://www.saucedemo.com/) website, a commonly used practice environment for web automation.

To get started, we recommend watching the videos in the [Robot Framework tutorial playlist (youtube.com)](https://www.youtube.com/playlist?list=PLSK6YK5OGX1AuQy0tbvdKBV9mrKi46kKH).

Tests in this exercise follow **behavior-driven development (BDD)** principles:

> *"Behavior-driven development (BDD) involves naming software tests using domain language to describe the behavior of the code."*
>
> https://en.wikipedia.org/wiki/Behavior-driven_development

In BDD, test cases are written in natural language and describe the system behavior from a user perspective. Robot Framework supports BDD-style testing using the **Given-When-Then** structure:

> *Given* the user is on the login page<br />
> *When* the user enters valid credentials *and* clicks the login button<br />
> *Then* the user should be redirected to the products page


## Installations

Robot Framework is Python-based, so you need [Python and the pip package manager installed](https://www.python.org/downloads/).

In addition to Python and Robot Framework you need the [**Browser** library](https://robotframework-browser.org/) to drive web browsers in your tests. The Browser library uses [**Playwright**](https://playwright.dev) under the hood, which is built with Node.js, so Node.js must also be installed.

* https://www.python.org/downloads/
* https://nodejs.org/en/download

We recommend using the latest LTS (Long-Term Support) versions of both Python and Node.js.


### 1. Install Robot Framework

The Robot Framework homepage provides a [quick install guide](https://robotframework.org/?tab=1#getting-started). A more detailed [installation guide](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst) covers additional options.

According to the quick guide you can install Robot Framework with pip:

```sh
# Install Robot Framework with pip:
pip install robotframework

# Verify the installation (prints usage instructions):
robot --help
```

👆 The pip package manager used above is installed together with Python. Package details for `robotframework` are available on PyPI: https://pypi.org/project/robotframework/.


### 2. Install the required packages

Robot Framework provides core features to run tests, but it does not ship with a ready-made library for browser control. For that you need a separate library such as the [Browser library](https://robotframework-browser.org/), which wraps [Playwright](https://playwright.dev) for browser automation.

Follow the [Browser library installation instructions](https://robotframework-browser.org/#installation). The quick install with pip looks like this:

```sh
# Install Browser library from PyPI with pip:
pip install robotframework-browser

# Verify the installation (prints usage instructions):
rfbrowser --help
```

Package details for `robotframework-browser` are available at https://pypi.org/project/robotframework-browser/.

Next you need Playwright and its bundled test browsers. Install them through the Browser library with `rfbrowser init`:

```sh
# initialize the Browser library (installs all browsers):
rfbrowser init
```

If you only want a specific browser, specify it in the install command:

```sh
# alternatively, only install Chromium:
rfbrowser init chromium
```

You do not need to install **Playwright** separately when using the Browser library; it is installed by the commands above.

At the end of the exercise or course, when you no longer need the browsers, you can free disk space by removing the test browsers:

```sh
# clean up browsers and node dependencies:
rfbrowser clean-node

# optionally, uninstall Robot Framework and Browser library:
pip uninstall robotframework-browser
pip uninstall robotframework
```


### 3. Install the VS Code extension

The [Robot Framework docs](https://docs.robotframework.org/docs/getting_started/ide) recommend VS Code together with the [RobotCode](https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode) extension for writing and running tests. We suggest reviewing the extension and installing it if you wish. It provides [syntax highlighting, auto-completion, and the ability to run tests directly from the editor](https://robotcode.io/) ([robotcode.io](https://robotcode.io/)).


## Running tests

Once Robot Framework and the Browser library are installed, you can try running your first tests. This repository includes a ready-made test file [`tests/example.robot`](./tests/example.robot) with a simple test. Run it with:

```sh
robot tests/example.robot
```

The test should pass and print results to the console. Robot Framework also generates an HTML report you can open in a browser.

Reviewing the report is especially helpful when tests fail because it includes detailed information about test cases and, on failure, screenshots.


## Behavior Driven Development (BDD)

Behavior Driven Development (BDD) is a software development approach that emphasizes describing and testing system behavior. BDD test cases are written in natural language and describe functionality from the user perspective. Robot Framework supports BDD-style tests.

BDD tests use the **Given-When-Then** structure to describe the situation, action, and expected outcome. For example, the following test describes a user logging in:

```robot
*** Test Cases ***

Successful login with a valid user
    Given the user is on the login page
    When the user enters valid credentials
    And the user clicks the login button
    Then the user should be redirected to the products page
```

The test case above describes behavior in natural language without technical details such as element names or CSS selectors, making it easy to read and understand.

The technical steps—identifying elements, clicking, etc.—are implemented behind the scenes as custom *keywords*. Those keywords rely on Robot Framework libraries such as the [Browser library](https://robotframework-browser.org/).

The next example defines the keywords used in the test above, showing how each step is implemented. Inside the keywords we call Browser-library keywords like `New Page`, `Fill Text`, `Click`, and `Get Url`:

```robot
*** Settings ***
# Importing the Browser library adds the New Page, Click, Fill Text, and Get Url keywords:
Library          Browser

*** Keywords ***

The user is on the login page
    New Page     https://www.saucedemo.com/

The user enters valid credentials
    Fill Text    id=user-name         standard_user
    Fill Text    id=password          secret_sauce

The user clicks the login button
    Click        text=Login

The user should be redirected to the products page
    Get Url      should end with      inventory.html
```

The *"The user..."* keywords correspond to the Given-When-Then steps. Robot Framework keywords are reusable code blocks you can call from test cases.

Treat your own keywords like functions containing one or more library keywords. In Robot Framework syntax, keywords are separated from tests by the `*** Keywords ***` header. Each keyword’s steps are on their own lines and run in the order dictated by the test.

Keyword names are case-insensitive and can be prefixed with words such as `given`, `when`, `then`, and `and`. In the test above, the line `Given the user is on the login page` refers to the keyword `The user is on the login page` defined later.

Robot Framework, like Python, uses indentation to separate code blocks. Each operation consists of parts (keyword and arguments) separated by multiple spaces. For example, `Fill Text  id=user-name  standard_user` has three parts: the keyword (`Fill Text`), the selector (`id=user-name`), and the text (`standard_user`). They must be separated by two or more spaces so Robot Framework recognizes them as distinct.

In the example above, the keywords `New Page`, `Fill Text`, `Click`, and `Get Url` are [Browser library keywords](https://marketsquare.github.io/robotframework-browser/Browser.html) used to control the browser and inspect page state. All Browser keywords are documented at https://marketsquare.github.io/robotframework-browser/Browser.html.

You can find this example in [`tests/bdd_example.robot`](./tests/bdd_example.robot). Run it with:

```sh
robot tests/bdd_example.robot
```

BDD syntax is covered in the Robot Framework documentation under [BDD (Behavior Driven Development)](https://docs.robotframework.org/docs/testcase_styles/bdd).


## Your own tests

**SauceDemo** (https://www.saucedemo.com/) is a sample e-commerce site for testing. Users can log in, browse products, add them to a cart, and complete a purchase.

In this exercise the goal is to automate key user flows on [SauceDemo](https://www.saucedemo.com/). The scenarios to test are listed below. You can also add your own scenarios.

Organize your tests under the [tests](./tests/) directory as you prefer, following the [Robot Framework project structure guide](https://docs.robotframework.org/docs/examples/project_structure). You may also define shared keywords used across multiple test cases.

These reusable keywords can live in their own file and be imported into other test files with the [`Resource` setting](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#resource-and-variable-files). To start, focus on writing test cases; structure is secondary.


### Tracing

For **automatic assessment** your test cases must save browser activity into a "trace" file so the grader can verify that required steps were executed.

To save trace files correctly, each test case must start with `New Context    tracing=True`. This opens a new isolated browser context so tests can run in parallel without interfering with each other. Read more in the [Browser library docs](https://marketsquare.github.io/robotframework-browser/Browser.html#Browser%2C%20Context%20and%20Page).

The simplest way is to add these lines to the `*** Settings ***` section at the top of every robot file to open a context before each test and close it afterward:

```robot
# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context
```

Trace files are stored in your project as zip files. You can inspect them with the [Playwright Trace Viewer](https://playwright.dev/docs/trace-viewer), either locally or at https://trace.playwright.dev/. See Playwright’s sample [trace file](https://trace.playwright.dev/?trace=https://demo.playwright.dev/reports/todomvc/data/fa874b0d59cdedec675521c21124e93161d66533.zip) and the [related video](https://youtu.be/yP6AnTxC34s).


## Scenarios to test

Test cases need credentials available on the SauceDemo front page. Use different accounts depending on the feature under test (e.g., the locked-out user for lockout scenarios).

For product listing and purchasing flows you can use the `standard_user` account.


### Login

**Scenario: Successful login with a valid user**

**As a** registered user, **I want to** log in with valid credentials, **So that** I can access the products page and shop.

```robot
Successful login with a valid user
    Given the user is on the login page
    When the user enters valid credentials
    And the user clicks the login button
    Then the user should be redirected to the products page
```

**Scenario: Login with an invalid user**

**As a** user who enters incorrect credentials, **I want to** see an error message, **So that** I understand that my login attempt failed.

```robot
Login with an invalid user
    Given the user is on the login page
    When the user enters an invalid username or password
    And the user clicks the login button
    Then an error message should be displayed
```

**Scenario: Login with a locked-out user**

**As a** locked-out user, **I want to** be informed that my account is locked, **So that** I know I cannot proceed and need assistance.

```robot
Login with a locked-out user
    Given the user is on the login page
    When the user enters credentials for a locked-out user
    And the user clicks the login button
    Then an error message should indicate that the user is locked out
```


### Browsing and sorting products

**Scenario: Product list is displayed after login**

**As a** logged-in user, **I want to** see a list of available products, **So that** I can browse and choose what to buy.

```robot
Product list is displayed after login
    Given the user is logged in
    When the user navigates to the products page
    Then a list of products should be visible
```

**Scenario: Sorting products by price**

**As a** user on the products page, **I want to** sort items by price (low to high), **So that** I can easily find the most affordable products first.

```robot
Sorting products by price
    Given the user is on the products page
    When the user selects "price low to high" from the sorting dropdown
    Then the products should be listed in ascending order of price
```


### Cart

**Scenario: Adding an item to the cart**

**As a** user browsing products, **I want to** add a product to my cart, **So that** I can purchase it later.

```robot
Adding an item to the cart
    Given the user is on the products page
    When the user adds a product to the cart
    Then the product should be added to the cart
```

**Scenario: Seeing the correct number of items in the cart**

**As a** user who has added products to the cart, **I want to** see the correct number of items displayed in the cart **So that** I can verify my selections before proceeding to checkout.

```robot
Seeing the correct number of items in the cart
    Given the user is on the products page
    When the user adds multiple products to the cart
    Then the cart icon should show the correct item count
```

**Scenario: Removing an item from the cart**

**As a** user with an item in my cart, **I want to** remove an item from the cart, **So that** I can adjust my order before checkout.

```robot
Removing an item from the cart
    Given the user has an item in the cart
    When the user removes the item from the cart
    Then the cart should be empty
```

**Scenario: Proceeding to checkout**

**As a** user with items in my cart, **I want to** proceed to checkout, **So that** I can complete my purchase.

```robot
Proceeding to checkout
    Given the user has items in the cart
    When the user clicks the checkout button
    Then the checkout page should be displayed
```


### Payment flow

**Scenario: Completing a purchase**

**As a** customer at checkout, **I want to** enter my payment and shipping details, **So that** I can finalize my order and receive my products.

```robot
Completing a purchase
    Given the user is on the checkout page
    When the user enters valid checkout information
    And the user completes the purchase
    Then a confirmation message should be displayed
```


## Submitting the exercise

After writing your test cases and verifying they work, submit the exercise for automatic assessment. Add your test files to version control and push the changes to GitHub using `git status`, `git add`, `git commit`, and `git push`.

You will find the assessment result shortly on the Actions tab. If you do not receive the expected score, double-check that trace files are generated as instructed above.


## Licenses

The [Sauce Labs Sample Application](https://www.saucedemo.com/) is released under the [MIT license](https://github.com/saucelabs/sample-app-web/blob/main/LICENSE).

Robot Framework is licensed under [Apache 2.0](https://github.com/robotframework/robotframework/blob/master/LICENSE.txt).

The Browser library is licensed under [Apache 2.0](https://github.com/MarketSquare/robotframework-browser/blob/main/LICENSE).


## About the material

This exercise was developed by Teemu Havulinna and is licensed under [Creative Commons BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Large language models and AI tools such as GitHub Copilot and ChatGPT were used while creating this exercise.
