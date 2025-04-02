*** Comments ***
This example has been borrowed from https://github.com/MarketSquare/robotframework-browser


*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise.
# Tracing means that the browser will record each step of the test.
# These steps are then used to verify the correctness of the exercise.
Test Setup          New Context    tracing=True
Test Teardown       Close Context


*** Test Cases ***
Example Test
    New Page    https://playwright.dev
    Get Text    h1    contains    Playwright
