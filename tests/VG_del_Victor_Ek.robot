*** Settings ***
Documentation    Test cases for good passing grade
...              I have chosen the features number 5 and 6 in the list "features on the webpage" in Dokumentation - Labb GUI-testning mT24.pdf
Library          Examples
Resource         resources/VG_del_Victor_Ek.resource
Test Setup       Open Browser    ${url}    ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
There are ticket types for Adult, Child and Senior
    [Documentation]    Test for feature number 5, Verifies that the three ticket types exist
    [Tags]    Victor
    Given I am logged in as a user
    When I navigate to the tickets page
    Then I should see ticket type options for    Adult    Child    Senior

VIP category tickets have double the price of a regular category ticket
    [Documentation]    Test for feature number 5, Verifies that VIP tickets have double the price of regular tickets
    [Tags]    Victor
    Given I am logged in as a user
    And I have every ticket type there is for Regular and VIP category tickets in my cart
    When I navigate to the cart page
    Then the VIP category tickets price should be double the price of a Regular category ticket of the same type

Having a ${ticket} ticket when booking a ${safari} safari on a ${date} will give an error message
    [Documentation]    Test for feature number 6, Verifies that users with an incorrect ticket, or no ticket, cannot book a safari
    [Tags]    Victor
    Given I am logged in as a user
    And I have a ${ticket} category ticket in my cart
    And I am on the safari page
    When I add the ${safari} safari on a ${date} to my cart    handle_alert=No
    Then I should see an error message with the text ${error_message}
    And the ${safari} should not be listed on the cart page

    Examples:    Ticket     Safari                       Date            Error message                     --
    ...          NONE       ${safari_regular_option1}    workday date    ${safari_error_no_ticket}
    ...          Regular    ${safari_vip_option1}        workday date    ${safari_error_no_vip}
    ...          Regular    ${safari_regular_option1}    weekend date    ${safari_error_weekend_no_vip}

Having a ${ticket} ticket and booking a ${safari} safari on a ${date} will give a success alert
    [Documentation]    Test for feature number 6, Verifies that users with the correct ticket can book a safari
    [Tags]    Victor
    Given I am logged in as a user
    And I have a ${ticket} category ticket in my cart
    And I am on the safari page
    When I add the ${safari} safari on a ${date} to my cart    handle_alert=No
    Then I should see a success alert
    And the ${safari} should be listed on the cart page

    Examples:    Ticket     Safari                       Date            --
    ...          Regular    ${safari_regular_option1}    workday date
    ...          VIP        ${safari_vip_option1}        workday date
    ...          VIP        ${safari_regular_option1}    weekend date