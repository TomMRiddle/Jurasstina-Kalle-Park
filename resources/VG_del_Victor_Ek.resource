*** Settings ***
Library      SeleniumLibrary
Variables    variables_VG_del_Victor_Ek.py

*** Keywords ***
the total price should be ${total_price}
    Element Text Should Be    id:cart-total    Total: ${total_price}

