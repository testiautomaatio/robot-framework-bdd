*** Settings ***
Library     Browser


*** Keywords ***
The User Is On The Products Page
    Go To    https://www.saucedemo.com/inventory.html

The User Adds A Product To The Cart
    Click    id=add-to-cart-sauce-labs-backpack

The Cart Should Contain One Item
    Get Text    id=remove-sauce-labs-backpack    contains    Remove
    Get Text    .shopping_cart_badge    ==    1

The User Adds Multiple Products To The Cart
    Click    id=add-to-cart-sauce-labs-backpack
    Click    id=add-to-cart-sauce-labs-bike-light
    Click    id=add-to-cart-sauce-labs-bolt-t-shirt

The Cart Icon Should Show The Correct Item Count
    Get Text    .shopping_cart_badge    ==    3

The User Has An Item In The Cart
    The User Adds A Product To The Cart
    Get Text    .shopping_cart_badge    ==    1

The User Removes The Item From The Cart
    Click    id=remove-sauce-labs-backpack

The Cart Should Be Empty
    Get Text    .shopping_cart_link    ==    ${EMPTY}

The User Has Items In The Cart
    The User Adds Multiple Products To The Cart

The User Clicks The Checkout Button
    Click    a.shopping_cart_link
    Click    button >> "Checkout"

The Checkout Page Should Be Displayed
    Get Url    should end with    /checkout-step-one.html
