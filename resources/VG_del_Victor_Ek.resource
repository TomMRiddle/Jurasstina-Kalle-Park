*** Settings ***
Library      SeleniumLibrary
Library      BuiltIn
Library      Collections
Library      String
Variables    variables_VG_del_Victor_Ek.py
Variables    variables_base.py
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
    VAR    ${list_on_page_items}    Get List Items    ${tickets_type_select}
    List Should Contain Sub List        ${list_on_page_items}    ${list_items}
    
I add every ticket type there is for Regular and VIP category tickets to my cart
    @{ticket_types}    Get List Items    ${tickets_type_select}
    VAR    @{ticket_types}    @{ticket_types}    scope=TEST
    VAR    @{ticket_categories}    Regular    VIP    scope=TEST
    FOR    ${ticket_type}    IN    @{ticket_types}
        FOR    ${ticket_category}    IN    @{ticket_categories}
            I add a ${ticket_category} ${ticket_type} ticket to my cart
        END
    END

the VIP category tickets price should be double the price of a Regular category ticket of the same type
    FOR    ${ticket_type}    IN    @{ticket_types}
        ${regular_ticket}    Get Text             xpath://*[@id="cart-details"]//*[contains(text(),"Regular ${ticket_type}")]
        ${vip_ticket}        Get Text             xpath://*[@id="cart-details"]//*[contains(text(),"VIP ${ticket_type}")]
        ${regular_ticket}    Remove String        ${regular_ticket}        \nRemove
        ${vip_ticket}        Remove String        ${vip_ticket}            \nRemove
        ${regular_ticket}    Fetch From Right     ${regular_ticket}        $
        ${vip_ticket}        Fetch From Right     ${vip_ticket}            $
        ${regular_ticket}    Convert To Number    ${regular_ticket}
        ${vip_ticket}        Convert To Number    ${vip_ticket}
        Should Be Equal      ${vip_ticket}        ${{${regular_ticket}*2}}
    END
