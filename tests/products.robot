*** Settings ***
Resource            ./utils.resource
Resource            ./pages/products_page.resource

Test Setup          Setup Test Environment (Logged In)
Test Teardown       Close Context


*** Test Cases ***
Product List Is Displayed After Login
    When The User Navigates To The Products Page
    Then A List Of Products Should Be Visible

Sorting Products By Price (Low To High)
    Given The User Is On The Products Page
    When The User Selects "Price Low To High" From The Sorting Dropdown
    Then The Products Should Be Listed In Ascending Order Of Price
