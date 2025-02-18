*** Settings ***
Documentation    Test cases for good passing grade
Library          Examples
Resource         resources/VG_del_Victor_Ek.resource
Resource         resources/base.resource
Test Setup       Open Browser    ${url}    ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
Having a ${ticket} when booking a ${safari} safari on a ${date} will give an error message
    [Documentation]    Verifies that users with the incorrect ticket, or no ticket, cannot book a safari
    [Tags]    Victor
    Given I am logged in as a user
    And I have a ${ticket} category ticket in my cart
    And I am on the safari page
    When I add the ${safari} safari on a ${date} to my cart    handle_alert=No
    Then I should see an error message with the text ${text}
    And the ${safari} should not be listed on the cart page
       
    Examples:    Ticket     Safari                       Date            Text                              --
    ...          NONE       ${safari_regular_option1}    workday date    ${safari_error_no_ticket}
    ...          Regular    ${safari_vip_option1}        workday date    ${safari_error_no_vip}
    ...          Regular    ${safari_regular_option1}    weekend date    ${safari_error_weekend_no_vip}

Having a ${ticket} ticket and booking a ${safari} safari on a ${date} will give a success alert
    [Documentation]    Verifies that users with the correct ticket can book a safari
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

#There are ticket types for Adult, Child and Senior

#VIP category tickets should have double the price of a regular category ticket of the same ticket type