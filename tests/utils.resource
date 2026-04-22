*** Settings ***
Documentation       This file contains shared keywords for setting up the test environment, including logging
...                 in with a standard user. These keywords are used across multiple test suites to ensure
...                 consistency and reduce code duplication.

Library             Browser


*** Variables ***
${USERNAME}     standard_user
${PASSWORD}     secret_sauce


*** Keywords ***
Setup Test Environment
    # The following lines are required for automatic assessment of the exercise:
    New Context    tracing=True
    New Page    https://www.saucedemo.com/

Setup Test Environment (Logged In)
    # Reuse the same setup steps as above
    Setup Test Environment

    # Perform login steps
    Type Text    id=user-name    ${USERNAME}
    Type Text    id=password    ${PASSWORD}
    Click    text=Login
    Get Url    should end with    inventory.html
