*** Settings ***
Library      SeleniumLibrary
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