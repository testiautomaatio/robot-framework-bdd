*** Settings ***
Library             Browser
Resource            ./utils.resource
Resource            ./pages/login_page.resource

Suite Setup         Setup Test Environment
Suite Teardown      Close Context


*** Test Cases ***
Successful login with a valid user
    Given The User Is On The Login Page
    When The User Enters Valid Credentials
    And The User Clicks The Login Button
    Then The User Should Be Redirected To The Products Page

Login with an invalid user
    Given The User Is On The Login Page
    When The User Enters An Invalid Username Or Password
    And The User Clicks The Login Button
    Then An Authentication Error Should Be Displayed

Login with a locked-out user
    Given The User Is On The Login Page
    When The User Enters Credentials For A Locked-Out User
    And The User Clicks The Login Button
    Then An Error Message Should Indicate That The User Is Locked Out
