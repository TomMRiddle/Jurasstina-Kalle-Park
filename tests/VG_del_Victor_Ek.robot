*** Settings ***
Documentation    Test cases for good passing grade
Library          Examples
Resource         resources/VG_del_Victor_Ek.resource
Resource         resources/base.resource
Test Setup       Open Browser    ${url}    ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
The price for ${ticket_category} ${ticket_type} ${safari_type} is $${{ ${ticket_price} + ${safari_price} }}
    Given I am logged in as Stina-Kalle
    And I have a ${ticket_category} ${ticket_type} ticket in my cart
    And I am on the safari page
    And I add the ${safari_type} safari on a workday date to my cart
    When I navigate to the cart page
    Then the ${ticket_category} ${ticket_type} should be listed on the cart page
    And the ${safari_type} should be listed on the cart page
    And the total price should be $${{ ${ticket_price} + ${safari_price} }}

    Examples:    Ticket category    Ticket type    Ticket price    Safari type                         Safari price    --
    ...          Regular            Child                    30    Herbivore Tour                               120
    ...          Regular            Adult                    50    T-Rex Rumble                                 150
    ...          VIP                Child                    60    Herbivore Tour with Feeding                  180
    ...          VIP                Adult                   100    T-Rex Rumble eXtreme Thrill Pack             220