*** Comments ***
In this exercise, you will need to implement your own test cases and keywords.
Use the Browser library and their keyword documentation at
https://robotframework-browser.org/keywords#new-page


*** Settings ***
# Importing the Browser library adds the New Page, Click, Fill Text, and Get Url keywords:
Library          Browser

# The following lines are required for automatic assessment of the exercise:
Test Setup       New Context    tracing=True
Test Teardown    Close Context


*** Test Cases ***
Successful Login With A Valid User
    Given The User Is On The Login Page
    When The User Enters Valid Credentials
    And The User Clicks The Login Button
    Then The User Should Be Redirected To The Products Page


*** Keywords ***
The User Is On The Login Page
    # New Page uses Playwright to open a new browser tab:
    # https://robotframework-browser.org/keywords#new-page
    New Page    https://www.saucedemo.com/

The User Enters Valid Credentials
    # Fill Text is used to enter text into input fields. It takes a selector and the text to enter:
    # https://robotframework-browser.org/keywords#fill-text

    Log    Use the "Fill Text" keyword to enter the username and password into the appropriate input fields.

The User Clicks The Login Button
    # Click locates the given element and simulates a mouse click on it:
    # https://robotframework-browser.org/keywords#click

    Log    Use the "Click" keyword to click the login button.

The User Should Be Redirected To The Products Page
    # At the end of each test case, it is important to verify that the expected outcome
    # has been achieved. This can be done using assertions provided by the Browser library:
    # https://robotframework-browser.org/docs/concepts/assertions

    Log    Use the "Get Url" keyword to retrieve the current URL and assert that it ends with "inventory.html".
