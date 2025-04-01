*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise.
# Tracing means that the browser will record each step of the test.
# These steps are then used to verify the correctness of the exercise.
Test Setup          New Context    tracing=True
Test Teardown       Close Context


*** Test Cases ***
Adding an item to the cart
    Given the user is on the products page
    When the user adds a product to the cart
    Then the product should be added to the cart

Seeing the correct number of items in the cart
    Given the user is on the products page
    When the user adds multiple products to the cart
    Then the cart icon should show the correct item count

Removing an item from the cart
    Given the user is on the products page
    And the user has an item in the cart
    When the user removes the item from the cart
    Then the cart should be empty

Proceeding to checkout
    Given the user is on the products page
    And the user has items in the cart
    When the user clicks the checkout button
    Then the checkout page should be displayed


*** Keywords ***
The user is on the products page
    New Page    https://www.saucedemo.com/
    Type Text    id=user-name    standard_user
    Type Text    id=password    secret_sauce
    Click    text=Login
    Get Url    should end with    inventory.html

The user adds a product to the cart
    Click    id=add-to-cart-sauce-labs-backpack

The product should be added to the cart
    Get Text    id=remove-sauce-labs-backpack    *=    Remove
    Get Text    .shopping_cart_badge    ==    1

The user adds multiple products to the cart
    Click    id=add-to-cart-sauce-labs-backpack
    Click    id=add-to-cart-sauce-labs-bike-light
    Click    id=add-to-cart-sauce-labs-bolt-t-shirt

The cart icon should show the correct item count
    Get Text    .shopping_cart_badge    ==    3

The user has an item in the cart
    The user adds a product to the cart

The user removes the item from the cart
    Click    id=remove-sauce-labs-backpack

The cart should be empty
    Get Text    .shopping_cart_link    ==    ${EMPTY}

The user has items in the cart
    the user adds multiple products to the cart

The user clicks the checkout button
    Click    a.shopping_cart_link
    Click    button >> "Checkout"

The checkout page should be displayed
    Get Url    should end with    /checkout-step-one.html
