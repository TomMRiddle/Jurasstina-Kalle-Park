*** Settings ***
Documentation    Test cases for good passing grade
Library          Examples
Resource         resources/VG_del_Victor_Ek.resource
Resource         resources/base.resource
Test Setup       Open Browser    ${url}    ${BROWSER}
Test Teardown    Close Browser

*** Test Cases ***
The price for ${ticket_category} ${ticket_type} ${safari_type} is $${{ ${ticket_price} + ${safari_price} }}
    [Documentation]    This uses the Examples library, having the steps in the test case like here makes more sense
    ...                then how everything ends up in the keyword like in the 'Test with template' test.
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

Test with template
    [Documentation]    This have an empty Setup and Teardown because they are only run once before the first
    ...                iteration and after the last iteration, the keyword handles setup and teardown instead
    [Setup]
    [Template]    The price of ${ticket_category} ${ticket_type} ${safari_type} is $${ticket_price} plus $${safari_price}
                               Regular            Child          Herbivore Tour                       30    120
                               Regular            Adult          T-Rex Rumble                         50    150
                               VIP                Child          Herbivore Tour with Feeding          60    180
                               VIP                Adult          T-Rex Rumble eXtreme Thrill Pack    100    220
    [Teardown]


*** Keywords ***
The price of ${ticket_category} ${ticket_type} ${safari_type} is $${ticket_price} plus $${safari_price}
    VAR    ${total_price}    ${{${ticket_price}+${safari_price}}}
    Open Browser    ${url}    ${BROWSER}
    Given I am logged in as Stina-Kalle
    And I have a ${ticket_category} ${ticket_type} ticket in my cart
    And I am on the safari page
    And I add the ${safari_type} safari on a workday date to my cart
    When I navigate to the cart page
    Then the ${ticket_category} ${ticket_type} should be listed on the cart page
    And the ${safari_type} should be listed on the cart page
    And the total price should be $${total_price}
    Close Browser