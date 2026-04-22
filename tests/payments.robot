*** Settings ***
Library             Browser
Resource            ./utils.resource
Resource            ./pages/checkout_page.resource

Test Setup          Setup Test Environment (Logged In)
Test Teardown       Close Context


*** Test Cases ***
Completing a purchase
    Given The User Adds A Product To The Cart
    And The User Clicks The Checkout Button
    And The User Enters Valid Checkout Information

    When The User Completes The Purchase

    Then A Confirmation Message Should Be Displayed
