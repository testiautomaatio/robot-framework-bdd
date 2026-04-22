*** Settings ***
Library     Browser


*** Keywords ***
The User Is On The Products Page
    The User Navigates To The Products Page

The User Navigates To The Products Page
    New Page    https://www.saucedemo.com/inventory.html

A List Of Products Should Be Visible
    Get Text    .header_secondary_container    contains    Products

The User Selects "Price Low To High" From The Sorting Dropdown
    Select Options By    .product_sort_container    text    Price (low to high)

The Products Should Be Listed In Ascending Order Of Price
    Assert Product Index Is    Sauce Labs Onesie    0
    Assert Product Index Is    Sauce Labs Bike Light    1
    Assert Product Index Is    Sauce Labs Bolt T-Shirt    2
    Assert Product Index Is    Test.allTheThings() T-Shirt (Red)    3
    Assert Product Index Is    Sauce Labs Backpack    4
    Assert Product Index Is    Sauce Labs Fleece Jacket    5

Assert Product Index Is
    [Arguments]    ${product_name}    ${index}
    VAR    ${locator}    .inventory_list >> .inventory_item_name >> nth=${index}
    Get Text    ${locator}    contains    ${product_name}
