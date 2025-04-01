*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise.
# Tracing means that the browser will record each step of the test.
# These steps are then used to verify the correctness of the exercise.
Test Setup          New Context    tracing=True
Test Teardown       Close Context


*** Test Cases ***
Completing a purchase
    Given the user is on the checkout page
    When the user enters valid checkout information
    And the user completes the purchase
    Then a confirmation message should be displayed


*** Keywords ***
The user logs in
    New Page    https://www.saucedemo.com/
    Type Text    id=user-name    standard_user
    Type Text    id=password    secret_sauce
    Click    text=Login
    Get Url    should end with    inventory.html

The user adds a product to the cart
    Click    id=add-to-cart-sauce-labs-backpack

The user clicks the checkout button
    Click    a.shopping_cart_link
    Click    button >> "Checkout"

The checkout page should be displayed
    Get Url    should end with    /checkout-step-one.html

The user is on the checkout page
    The user logs in
    The user adds a product to the cart
    The user clicks the checkout button
    The checkout page should be displayed

The user enters valid checkout information
    Type Text    id=first-name    Tester
    Type Text    id=last-name    Robot
    Type Text    id=postal-code    90210

The user completes the purchase
    Click    input#continue
    Click    button#finish

A confirmation message should be displayed
    Get Text    h2.complete-header    *=    Thank you for your order!
