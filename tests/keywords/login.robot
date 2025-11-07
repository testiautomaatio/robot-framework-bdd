*** Settings ***

Library           Browser


*** Variables ***
${VALID_USERNAME}        standard_user
${VALID_PASSWORD}        secret_sauce
${INVALID_USERNAME}      standard_user
${INVALID_PASSWORD}      wrong password
${LOCKED_OUT_USERNAME}   locked_out_user
${LOCKED_OUT_PASSWORD}   secret_sauce


*** Keywords ***

Login
    The user enters valid credentials
    The user clicks the login button
    The user should be redirected to the products page

Input username ${username} and password ${password}
    Fill Text    id=user-name    ${username}
    Fill Text    id=password     ${password}

The user is on the login page
    Go To        https://www.saucedemo.com/

The user enters valid credentials
    Input username ${VALID_USERNAME} and password ${VALID_PASSWORD}

The user enters an invalid username or password
    Input username ${VALID_USERNAME} and password ${INVALID_PASSWORD}

the user enters credentials for a locked-out user
    Input username ${LOCKED_OUT_USERNAME} and password ${LOCKED_OUT_PASSWORD}

The user clicks the login button
    Click        text=Login

The user should be redirected to the products page
    Get Url      should end with    inventory.html

An error message should be displayed
    Get Text    .error-message-container    contains    Username and password do not match any user in this service

An error message should indicate that the user is locked out
    Get Text    .error-message-container    contains    Sorry, this user has been locked out.
