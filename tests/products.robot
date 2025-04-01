*** Settings ***
Library             Browser

# The following lines are required for automatic assessment of the exercise.
# Tracing means that the browser will record each step of the test.
# These steps are then used to verify the correctness of the exercise.
Test Setup          New Context    tracing=True
Test Teardown       Close Context


*** Test Cases ***
Product list is displayed after login
    Given the user is logged in
    When the user navigates to the products page
    Then a list of products should be visible

Sorting products by price (low to high)
    Given the user is on the products page
    When the user selects "Price low to high" from the sorting dropdown
    Then the products should be listed in ascending order of price


*** Keywords ***
The user is logged in
    New Page    https://www.saucedemo.com/
    Type Text    id=user-name    standard_user
    Type Text    id=password    secret_sauce
    Click    text=Login
    Get Url    should end with    inventory.html

The user navigates to the products page
    New Page    https://www.saucedemo.com/inventory.html

A list of products should be visible
    Get Text    .header_secondary_container    *=    Products

The user is on the products page
    The user is logged in
    The user navigates to the products page

the user selects "Price low to high" from the sorting dropdown
    Select Options By    .product_sort_container    text    Price (low to high)

the products should be listed in ascending order of price
    Get Text    .inventory_list >> .inventory_item_name >> nth=0    *=    Sauce Labs Onesie
    Get Text    .inventory_list >> .inventory_item_name >> nth=1    *=    Sauce Labs Bike Light
    Get Text    .inventory_list >> .inventory_item_name >> nth=2    *=    Sauce Labs Bolt T-Shirt
    Get Text    .inventory_list >> .inventory_item_name >> nth=3    *=    Test.allTheThings() T-Shirt (Red)
    Get Text    .inventory_list >> .inventory_item_name >> nth=4    *=    Sauce Labs Backpack
    Get Text    .inventory_list >> .inventory_item_name >> nth=5    *=    Sauce Labs Fleece Jacket
