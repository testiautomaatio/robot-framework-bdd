*** Comments ***
In this exercise, you will need to implement your own test cases and keywords.
Use the Browser library and their keyword documentation at
https://marketsquare.github.io/robotframework-browser/Browser.html


*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise.
# Tracing means that the browser will record each step of the test.
# These steps are then used to verify the correctness of the exercise.
Test Setup          New Context    tracing=True
Test Teardown       Close Context


*** Test Cases ***
Successful login with a valid user
    Given the user is on the login page
    When the user enters valid credentials
    And the user clicks the login button
    Then the user should be redirected to the products page


*** Keywords ***
The user is on the login page
    New Page    https://www.saucedemo.com/

The user enters valid credentials
    Type Text    id=user-name    standard_user
    Type Text    id=password    secret_sauce

The user clicks the login button
    Click    text=Login

The user should be redirected to the products page
    Get Url    should end with    inventory.html
