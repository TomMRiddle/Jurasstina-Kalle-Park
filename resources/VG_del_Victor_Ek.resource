*** Settings ***
Library      SeleniumLibrary
Variables    variables_VG_del_Victor_Ek.py

*** Keywords ***
the total price should be ${ticket_price}
    Element Text Should Be    id:cart-total    Total: ${ticket_price}

