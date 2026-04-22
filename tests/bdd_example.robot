*** Comments ***
In this exercise, you will need to implement your own test cases and keywords.
Use the Browser library and their keyword documentation at
https://marketsquare.github.io/robotframework-browser/Browser.html


*** Settings ***
# Importing the Browser library adds the New Page, Click, Fill Text, and Get Url keywords:
Library             Browser

# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context


*** Test Cases ***
Successful Login With A Valid User
    Given The User Is On The Login Page
    When The User Enters Valid Credentials
    And The User Clicks The Login Button
    Then The User Should Be Redirected To The Products Page


*** Keywords ***
The User Is On The Login Page
    # New Page uses Playwright to open a new browser tab:
    # https://marketsquare.github.io/robotframework-browser/Browser.html#New%20Page
    New Page    https://www.saucedemo.com/

The User Enters Valid Credentials
    # Fill Text is used to enter text into input fields. It takes a selector and the text to enter:
    # https://marketsquare.github.io/robotframework-browser/Browser.html#Fill%20Text
    Fill Text    id=user-name    standard_user
    Fill Text    id=password    secret_sauce

The User Clicks The Login Button
    # Click locates the given element and simulates a mouse click on it:
    # https://marketsquare.github.io/robotframework-browser/Browser.html#Click
    Click    text=Login

The User Should Be Redirected To The Products Page
    # At the end of each test case, it is important to verify that the expected outcome
    # has been achieved. This can be done using assertions provided by the Browser library:
    # https://marketsquare.github.io/robotframework-browser/Browser.html#Assertions
    Get Url    should end with    inventory.html
