*** Settings ***
Name             Paleontologist
Documentation    Grupp 5, Victor, Kelley och Mathilda
...              Tests for paleontologist
Library          SeleniumLibrary
Resource         resources/paleontologist.resource
Resource         resources/base.resource
Test Setup       Open Browser    ${url}    ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
Register user Stina-Palle
    [Tags]    Victor
    [Documentation]    Verifies that Stina-Palle can register and checks that a success message is shown and that the user is redirected to the login page.
    Given I am on the register page
    When I enter username Stina-Palle
    And I enter a valid password
    And submit the form
    Then I should see a message confirming successful registration
    And I should be redirected to the login page

Login user Stina-Palle
    [Tags]    Victor
    [Documentation]    Verifies that Stina-Palle can login
    Given I am registered as Stina-Palle
    And I am on the login page
    When I enter username Stina-Palle
    And I enter a valid password
    And submit the form
    Then I should be logged in

Add a Regular Adult ticket to cart
    [Tags]    Victor
    [Documentation]    Verifies that a Regular Adult ticket is in the cart after adding it.
    Given I am logged in as Stina-Palle
    And I am on the tickets page
    When I add a Regular Adult ticket to my cart
    Then the Regular Adult Ticket should be listed on the cart page

Book regular safari on a workday
    [Tags]    Victor
    [Documentation]    Verifies that the two regular safaris are in the cart after adding them, with the prerequisite of having a regular ticket first.
    Given I am logged in as Stina-Palle
    And I have a Regular Adult ticket in my cart
    And I am on the safari page
    When I add the Herbivore Tour safari on a workday date to my cart
    And I add the T-Rex Rumble safari on a workday date to my cart
    Then the Herbivore Tour should be listed on the cart page
    And the T-Rex Rumble should be listed on the cart page
    And I am shown a summary when I checkout