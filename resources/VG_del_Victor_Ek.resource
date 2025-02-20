*** Settings ***
Library      BuiltIn
Library      Collections
Library      String
Resource     resources/base.resource

*** Keywords ***
I should see an error message with the text ${text}
    Element Text Should Be    ${${page}_message}    ${text}
    
I should see a success alert
    Alert Should Be Present    ${${page}_success_alert}

I have a ${ticket} category ticket in my cart
    I have a ${ticket} Adult ticket in my cart

the ${item_name} should not be listed on the cart page
    [Tags]    Victor
    I navigate to the cart page
    Element Should Not Contain    ${cart_items}    ${item_name}

I should see ticket type options for
    [Arguments]    @{list_items}
    @{list_on_page_items}    Get List Items    ${tickets_type_select}
    List Should Contain Sub List        ${list_on_page_items}    ${list_items}
    
I have every ticket type there is for Regular and VIP category tickets in my cart
    I navigate to the tickets page
    @{ticket_types}                Get List Items    ${tickets_type_select}
    VAR    @{ticket_types}         @{ticket_types}    scope=TEST
    VAR    @{ticket_categories}    Regular    VIP    scope=TEST

    FOR    ${ticket_type}    IN    @{ticket_types}
        FOR    ${ticket_category}    IN    @{ticket_categories}
            I add a ${ticket_category} ${ticket_type} ticket to my cart
        END
    END

the VIP category tickets price should be double the price of a Regular category ticket of the same type
    FOR    ${ticket_type}    IN    @{ticket_types}
        FOR    ${ticket_category}    IN    @{ticket_categories}
            ${${ticket_category}_ticket}    Get Text             xpath://*[@id="cart-details"]//*[contains(text(),"${ticket_category} ${ticket_type}")]
            ${${ticket_category}_ticket}    Fetch From Right     ${${ticket_category}_ticket}        $
            ${${ticket_category}_ticket}    Fetch From Left      ${${ticket_category}_ticket}        \n
            ${${ticket_category}_ticket}    Convert To Number    ${${ticket_category}_ticket}
        END
        Should Be Equal      ${vip_ticket}        ${{${regular_ticket}*2}}
    END
