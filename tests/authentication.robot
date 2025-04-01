*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise.
# Tracing means that the browser will record each step of the test.
# These steps are then used to verify the correctness of the exercise.
Suite Setup         New Context    tracing=True
Suite Teardown      Close Context


*** Test Cases ***
Successful login with a valid user
    Given the user is on the login page
    When the user enters valid credentials
    And the user clicks the login button
    Then the user should be redirected to the products page

Login with an invalid user
    Given the user is on the login page
    When the user enters an invalid username or password
    And the user clicks the login button
    Then an error message should be displayed

Login with a locked-out user
    Given the user is on the login page
    When the user enters credentials for a locked-out user
    And the user clicks the login button
    Then an error message should indicate that the user is locked out


*** Keywords ***
The user is on the login page
    New Page    https://www.saucedemo.com/

The user enters valid credentials
    Type Text    id=user-name    standard_user
    Type Text    id=password    secret_sauce

The user enters an invalid username or password
    Type Text    id=user-name    standard_user
    Type Text    id=password    "wrong password"

The user clicks the login button
    Click    text=Login

The user should be redirected to the products page
    Get Url    should end with    inventory.html

An error message should be displayed
    Get Text    .error-message-container    contains    Username and password do not match any user in this service

the user enters credentials for a locked-out user
    Type Text    id=user-name    locked_out_user
    Type Text    id=password    secret_sauce

an error message should indicate that the user is locked out
    Get Text    .error-message-container    contains    Sorry, this user has been locked out.
