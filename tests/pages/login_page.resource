*** Settings ***
Library     Browser


*** Variables ***
${VALID_USERNAME}           standard_user
${VALID_PASSWORD}           secret_sauce
${INVALID_USERNAME}         standard_user
${INVALID_PASSWORD}         wrong password
${LOCKED_OUT_USERNAME}      locked_out_user
${LOCKED_OUT_PASSWORD}      secret_sauce


*** Keywords ***
Login
    The User Enters Valid Credentials
    The User Clicks The Login Button
    The User Should Be Redirected To The Products Page

The User Is On The Login Page
    Go To    https://www.saucedemo.com/

The User Enters Valid Credentials
    Input Username ${VALID_USERNAME} And Password ${VALID_PASSWORD}

The User Enters An Invalid Username Or Password
    Input Username ${VALID_USERNAME} And Password ${INVALID_PASSWORD}

The User Enters Credentials For A Locked-Out User
    Input Username ${LOCKED_OUT_USERNAME} And Password ${LOCKED_OUT_PASSWORD}

Input Username ${username} And Password ${password}
    Fill Text    id=user-name    ${username}
    Fill Text    id=password    ${password}

The User Clicks The Login Button
    Click    text=Login

The User Should Be Redirected To The Products Page
    Get Url    should end with    inventory.html

An Authentication Error Should Be Displayed
    Get Text    .error-message-container    contains    Username and password do not match any user in this service

An Error Message Should Indicate That The User Is Locked Out
    Get Text    .error-message-container    contains    Sorry, this user has been locked out.
