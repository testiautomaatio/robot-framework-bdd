*** Settings ***
Library             Browser

Resource            ./keywords/utils.robot

Test Setup          Setup test environment (logged in)
Test Teardown       Close Context


*** Test Cases ***
Completing a purchase
    Given the user is on the checkout page
    When the user enters valid checkout information
    And the user completes the purchase
    Then a confirmation message should be displayed


*** Keywords ***

The user is on the checkout page
    The user adds a product to the cart
    The user clicks the checkout button
    The checkout page should be displayed

The user adds a product to the cart
    Click    id=add-to-cart-sauce-labs-backpack

The user clicks the checkout button
    Click    a.shopping_cart_link
    Click    button >> "Checkout"

The checkout page should be displayed
    Get Url    should end with    /checkout-step-one.html

The user enters valid checkout information
    Fill Text    id=first-name    Tester
    Fill Text    id=last-name     Robot
    Fill Text    id=postal-code   90210

The user completes the purchase
    Click        input#continue
    Click        button#finish

A confirmation message should be displayed
    Get Text    h2.complete-header    contains    Thank you for your order!
