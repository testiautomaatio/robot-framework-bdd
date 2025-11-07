*** Settings ***
Library             Browser

Resource            ./keywords/utils.robot
Resource            ./keywords/login.robot

Suite Setup         Setup test environment
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

