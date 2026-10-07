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

Robot Framework is a Python-based test automation framework, so using it requires [Python and pip](https://www.python.org/downloads/) to be installed. In addition to Robot Framework, you need the Browser library, which enables controlling web browsers in your tests. The Browser library uses Playwright under the hood, and Playwright is implemented with Node.js, so Node.js must also be installed. All installation steps are covered in the [installations.md](./installations.md) file.

> [!TIP]
> This repository also includes a development container configuration as described in the [development container section](./devcontainer.md). With the container, you can avoid installation issues and have a ready-to-use isolated environment either in the cloud or locally. We highly encourage using development containers for simplicity, reproducibility and security reasons.


## Running tests

Once Robot Framework and the Browser library are installed, you can try running your first tests. This repository includes a ready-made test file [`tests/example.robot`](./tests/example.robot) with a simple test. Run it with:

```sh
robot --outputdir=test-results/ tests/example.robot
```

The test should pass and print results to the console. Robot Framework also generates an HTML report you can open in a browser.

Reviewing the report is especially helpful when tests fail because it includes detailed information about test cases and, on failure, screenshots.


## Behavior Driven Development (BDD)

Behavior Driven Development (BDD) is a software development approach that emphasizes describing and testing system behavior. BDD test cases are written in natural language and describe functionality from the user perspective. Robot Framework supports BDD-style tests.

BDD tests use the **Given-When-Then** structure to describe the situation, action, and expected outcome. For example, the following test describes a user logging in:

```robot
*** Test Cases ***

Successful Login With A Valid User
    Given The User Is On The Login Page
    When The User Enters Valid Credentials
    And The User Clicks The Login Button
    Then The User Should Be Redirected To The Products Page
```

The test case above describes behavior in natural language without technical details such as element names or CSS selectors, making it easy to read and understand.

The technical steps—identifying elements, clicking, etc.—are implemented behind the scenes as custom *keywords*. Those keywords rely on Robot Framework libraries such as the [Browser library](https://robotframework-browser.org/).

The next example defines the keywords used in the test above, showing how each step is implemented. Inside the keywords we call Browser-library keywords like `New Page`, `Fill Text`, `Click`, and `Get Url`:

```robot
*** Settings ***
# Importing the Browser library adds the New Page, Click, Fill Text, and Get Url keywords:
Library          Browser

*** Keywords ***

The uSer Is On The Login Page
    New Page     https://www.saucedemo.com/

The User Enters Valid Credentials
    Fill Text    id=user-name         standard_user
    Fill Text    id=password          secret_sauce

The User Clicks The Login Button
    Click        text=Login

The User Should Be Redirected To The Products Page
    Get Url      should end with      inventory.html
```

The *"The user..."* keywords above correspond to the Given-When-Then steps in the earlier snippet. Robot Framework keywords are reusable code blocks you can call from test cases.

Treat your own keywords like functions containing one or more library keywords. In Robot Framework syntax, keywords are separated from tests by the `*** Keywords ***` header. Each keyword’s steps are on their own lines and run in the order dictated by the test.

Keyword names are case-insensitive and can be prefixed with words such as `given`, `when`, `then`, and `and`. In the test above, the line `Given the user is on the login page` refers to the keyword `The user is on the login page` defined later.

Robot Framework, like Python, uses indentation to separate code blocks. Each operation consists of parts (keyword and arguments) separated by multiple spaces. For example, `Fill Text  id=user-name  standard_user` has three parts: the keyword (`Fill Text`), the selector (`id=user-name`), and the text (`standard_user`). They must be separated by *two or more spaces* so Robot Framework recognizes them as distinct.

In the example above, the keywords `New Page`, `Fill Text`, `Click`, and `Get Url` are [Browser library keywords](https://marketsquare.github.io/robotframework-browser/Browser.html) used to control the browser and inspect page state. All Browser keywords are documented at https://marketsquare.github.io/robotframework-browser/Browser.html.

You can find this full BDD example in [`tests/bdd_example.robot`](./tests/bdd_example.robot). Run it with:

```sh
robot --outputdir=test-results/ tests/bdd_example.robot
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

Test cases need credentials available on the [SauceDemo front page](https://www.saucedemo.com/). Use different accounts depending on the feature under test (e.g., the locked-out user for lockout scenarios).

For product listing and purchasing flows you should use the `standard_user` account.


### Login

**Scenario: Successful login with a valid user**

**As a** registered user, **I want to** log in with valid credentials, **So that** I can access the products page and shop.

```robot
Successful Login With A Valid User
    Given The User Is On The Login Page
    When The User Enters Valid Credentials
    And The User Clicks The Login Button
    Then The User Should Be Redirected To The Products Page
```

**Scenario: Login with an invalid user**

**As a** user who enters incorrect credentials, **I want to** see an error message, **So that** I understand that my login attempt failed.

```robot
Login With An Invalid User
    Given The User Is On The Login Page
    When The User Enters An Invalid Username Or Password
    And The User Clicks The Login Button
    Then An Error Message Should Be Displayed
```

**Scenario: Login with a locked-out user**

**As a** locked-out user, **I want to** be informed that my account is locked, **So that** I know I cannot proceed and need assistance.

```robot
Login With A Locked-Out User
    Given The User Is On The Login Page
    When The User Enters Credentials For A Locked-Out User
    And The User Clicks The Login Button
    Then An Error Message Should Indicate That The User Is Locked Out
```


### Browsing and sorting products

**Scenario: Product list is displayed after login**

**As a** logged-in user, **I want to** see a list of available products, **So that** I can browse and choose what to buy.

```robot
Product List Is Displayed After Login
    Given The User Is Logged In
    When The User Navigates To The Products Page
    Then A List Of Products Should Be Visible
```

**Scenario: Sorting products by price**

**As a** user on the products page, **I want to** sort items by price (low to high), **So that** I can easily find the most affordable products first.

```robot
Sorting Products By Price
    Given The User Is On The Products Page
    When The User Selects "Price Low To High" From The Sorting Dropdown
    Then The Products Should Be Listed In Ascending Order Of Price
```

> [!TIP]
> You can assume that the products and their prices do not change. You do not need to compare numbers in your test code, just verify that specific items are in expected positions after sorting.

### Cart

**Scenario: Adding an item to the cart**

**As a** user browsing products, **I want to** add a product to my cart, **So that** I can purchase it later.

```robot
Adding An Item To The Cart
    Given The User Is On The Products Page
    When The User Adds A Product To The Cart
    Then The Product Should Be Added To The Cart
```

**Scenario: Seeing the correct number of items in the cart**

**As a** user who has added products to the cart, **I want to** see the correct number of items displayed in the cart **So that** I can verify my selections before proceeding to checkout.

```robot
Seeing The Correct Number Of Items In The Cart
    Given The User Is On The Products Page
    When The User Adds Multiple Products To The Cart
    Then The Cart Icon Should Show The Correct Item Count
```

**Scenario: Removing an item from the cart**

**As a** user with an item in my cart, **I want to** remove an item from the cart, **So that** I can adjust my order before checkout.

```robot
Removing An Item From The Cart
    Given The User Has An Item In The Cart
    When The User Removes The Item From The Cart
    Then The Cart Should Be Empty
```

**Scenario: Proceeding to checkout**

**As a** user with items in my cart, **I want to** proceed to checkout, **So that** I can complete my purchase.

```robot
Proceeding To Checkout
    Given The User Has Items In The Cart
    When The User Clicks The Checkout Button
    Then The Checkout Page Should Be Displayed
```


### Payment flow

**Scenario: Completing a purchase**

**As a** customer at checkout, **I want to** enter my payment and shipping details, **So that** I can finalize my order and receive my products.

```robot
Completing A Purchase
    Given The User Is On The Checkout Page
    When The User Enters Valid Checkout Information
    And The User Completes The Purchase
    Then A Confirmation Message Should Be Displayed
```


## Submitting the exercise

After writing your test cases and verifying they work, submit the exercise for automatic assessment. Add your test files to version control and push the changes to GitHub using `git status`, `git add`, `git commit`, and `git push`.

You will find the assessment result shortly on the Actions tab. If you do not receive the expected score, double-check that trace files are generated as instructed above.


## Licenses

The [Sauce Labs Sample Application](https://www.saucedemo.com/) is released under the [MIT license](https://github.com/saucelabs/sample-app-web/blob/main/LICENSE).

Robot Framework is licensed under the [Apache 2.0 license](https://github.com/robotframework/robotframework/blob/master/LICENSE.txt).

The Browser library is licensed under the [Apache 2.0 license](https://github.com/MarketSquare/robotframework-browser/blob/main/LICENSE).

The RobotCode extension is licensed under the [Apache 2.0 license](https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode#license).

The Robocop tool is licensed under the [Apache 2.0 license](https://github.com/MarketSquare/robotframework-robocop/blob/main/LICENSE).


## About the material

This exercise was developed by Teemu Havulinna and is licensed under [Creative Commons BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Large language models and AI tools such as GitHub Copilot and ChatGPT were used while creating this exercise.
