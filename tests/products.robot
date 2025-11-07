*** Settings ***
Resource            ./keywords/login.robot
Resource            ./keywords/utils.robot

Test Setup          Setup test environment
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
    Login

The user navigates to the products page
    New Page    https://www.saucedemo.com/inventory.html

A list of products should be visible
    Get Text    .header_secondary_container    contains    Products

The user is on the products page
    Login
    The user navigates to the products page

The user selects "Price low to high" from the sorting dropdown
    Select Options By    .product_sort_container    text    Price (low to high)

The products should be listed in ascending order of price
    Assert product 0 is Sauce Labs Onesie
    Assert product 1 is Sauce Labs Bike Light
    Assert product 2 is Sauce Labs Bolt T-Shirt
    Assert product 3 is Test.allTheThings() T-Shirt (Red)
    Assert product 4 is Sauce Labs Backpack
    Assert product 5 is Sauce Labs Fleece Jacket

Assert product ${index} is ${product_name}
    ${locator}=    Set Variable    .inventory_list >> .inventory_item_name >> nth=${index}
    Get Text    ${locator}    contains    ${product_name}
