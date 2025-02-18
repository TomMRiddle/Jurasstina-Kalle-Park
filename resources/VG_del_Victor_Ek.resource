*** Settings ***
Library      SeleniumLibrary
Library      Collections
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
    VAR    @{ticket_categories}    Regular    VIP
    FOR    ${ticket_type}    IN    @{ticket_types}
        FOR    ${ticket_category}    IN    @{ticket_categories}
            I add a ${ticket_category} ${ticket_type} ticket to my cart
        END
    END

the VIP category tickets price should be double the price of a Regular category ticket of the same type
    @{cart_web_items}    Get WebElements    ${cart_items} ul li
    FOR    ${ticket_type}    IN    @{ticket_types}
        FOR    ${cart_web_item}    IN    @{cart_web_items}
            ${item_text}    Evaluate    $cart_web_item.text
            Log    t:${ticket_type} c:${item_text}    INFO
        END
    END
