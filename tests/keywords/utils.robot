*** Settings ***

Library               Browser


*** Keywords ***

Setup test environment
    # The following lines are required for automatic assessment of the exercise:
    New Context       tracing=True
    New Page          https://www.saucedemo.com/


Setup test environment (logged in)
    Setup test environment
    Type Text         id=user-name    standard_user
    Type Text         id=password     secret_sauce
    Click             text=Login
    Get Url           should end with    inventory.html
