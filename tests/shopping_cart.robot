*** Settings ***
Library             Browser
Resource            ./utils.resource
Resource            ./pages/cart_page.resource

Test Setup          Setup Test Environment (Logged In)
Test Teardown       Close Context


*** Test Cases ***
Adding An Item To The Cart
    Given The User Is On The Products Page
    When The User Adds A Product To The Cart
    Then The Cart Should Contain One Item

Seeing The Correct Number Of Items In The Cart
    Given The User Is On The Products Page
    When The User Adds Multiple Products To The Cart
    Then The Cart Icon Should Show The Correct Item Count

Removing An Item From The Cart
    Given The User Is On The Products Page
    And The User Has An Item In The Cart
    When The User Removes The Item From The Cart
    Then The Cart Should Be Empty

Proceeding To Checkout
    Given The User Is On The Products Page
    And The User Has Items In The Cart
    When The User Clicks The Checkout Button
    Then The Checkout Page Should Be Displayed
