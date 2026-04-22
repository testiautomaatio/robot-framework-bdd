*** Settings ***
Library     Browser


*** Keywords ***
The User Is On The Checkout Page
    The Checkout Page Should Be Displayed

The User Adds A Product To The Cart
    Click    id=add-to-cart-sauce-labs-backpack

The User Clicks The Checkout Button
    Click    a.shopping_cart_link
    Click    button >> "Checkout"

The Checkout Page Should Be Displayed
    Get Url    should end with    /checkout-step-one.html

The User Enters Valid Checkout Information
    Fill Text    id=first-name    Tester
    Fill Text    id=last-name    Robot
    Fill Text    id=postal-code    90210

The User Completes The Purchase
    Click    input#continue
    Click    button#finish

A Confirmation Message Should Be Displayed
    Get Text    h2.complete-header    contains    Thank you for your order!
