*** Settings ***
Library          SeleniumLibrary
Variables        resources/variables_base.py

*** Keywords ***
I am on the ${page_name} page
    [Tags]    Kelley    Victor_refactored
    [Documentation]    Navigates to the specified page using the link id, saves the page name as a variable for later
    ...                use by steps in the same test. Uses nested variables prefixed with the page name.
    Set Test Variable    ${page}    ${page_name}
    Click Link    ${${page}_link}
    Wait Until Element Is Visible    ${${page}_section}

I navigate to the ${page_name} page
    [Tags]    Kelley    Victor_refactored
    I am on the ${page_name} page

I enter username ${username}
    [Tags]    Victor
    Input Text    ${${page}_username_input}    ${username}

I have entered a valid username
    [Tags]    Kelley
    Input Text    ${register_username_input}    ${username_with_letters}

I enter a username using special characters
    [Tags]    Kelley
    Input Text    ${register_username_input}    ${username_with_special_characters}

I enter a username using numbers
    [Tags]    Victor
    Input Text    ${register_username_input}    ${username_with numbers}

I enter a valid password
    [Tags]    Kelley    Victor_refactored
    Input Password    ${${page}_password_input}    ${password_long}

I enter an invalid password
    [Tags]    Kelley
    Input Text    ${register_password_input}    ${password_short}

submit the form
    [Tags]    Victor
    Submit Form    ${${page}_form}

I should be redirected to the ${page_name} page
    [Tags]    Kelley    Victor_refactored
    [Documentation]    Used to assert that a redirect have been made and updates the page variable initially set in
    ...                the "I am on the page_name page" keyword
    Wait Until Element Is Visible    ${${page_name}_section}
    Set Test Variable    ${page}    ${page_name}

I should be logged in
    [Tags]    Victor
    Wait Until Element Is Visible    ${logout_link}

I am registered as ${username}
    [Tags]    Victor
    I am on the register page
    And I enter username ${username}
    And I enter a valid password
    And submit the form
    And I should be redirected to the login page

I am logged in as ${username}
    [Tags]    Kelley    Victor_refactored
    I am registered as ${username}
    And I enter username ${username}
    And I enter a valid password
    And submit the form
    And I should be logged in

Message Should Be Visible
    [Arguments]    ${error_message_element}    ${error_message_text}
    Wait Until Element Is Visible    ${error_message_element}
    Element Text Should Be    ${error_message_element}    ${error_message_text}
   
Click on the register button
    [Tags]    Kelley
    Click Button    ${register_button}

I should see a message confirming successful registration
    [Tags]    Kelley
    Message Should Be Visible    ${register_message}    ${register_success_message}
    
I should see an error message
    [Tags]    Kelley
    Message Should Be Visible    ${register_message}   ${register_error_short_password}
    
I add a ${ticket_category} ${ticket_type} ticket to my cart
    [Tags]    Kelley    Victor_refactored
    [Documentation]    Adds desired ticket type to cart, utilizing the standard ticket quantity of 1
    ...                Skipped if ticket category is NONE
    IF    $ticket_category == 'NONE'    RETURN
    Select From List By Value    ${tickets_category_select}    ${ticket_category}
    Select From List By Value    ${tickets_type_select}    ${ticket_type}
    Click Button    ${tickets_button}
    Handle Alert
    
I have a ${ticket_category} ${ticket_type} ticket in my cart
    [Tags]    Victor
    I navigate to the tickets page
    I add a ${ticket_category} ${ticket_type} ticket to my cart
    
I add the ${safari_type} safari on ${yyyy-mm-dd} to my cart
    [Tags]    Victor
    [Arguments]    ${handle_alert}=TRUE
    Set Focus To Element    ${safari_type_select}
    Set Focus To Element    ${safari_date_input}
    Input Text    ${safari_date_input}    ${yyyy-mm-dd}
    Select From List By Value    ${safari_type_select}    ${safari_type}
    submit the form
    IF    $handle_alert==True    Handle Alert

I add the ${safari_type} safari on a ${date_var_name} to my cart
    [Tags]    Victor
    [Documentation]    Allows a name of a variable to be specified instead of hardcoding a date into the test case
    [Arguments]    ${handle_alert}=TRUE
    I add the ${safari_type} safari on ${safari_${date_var_name}} to my cart    handle_alert=${handle_alert}

    
the ${item_name} should be listed on the cart page
    [Tags]    Victor
    I navigate to the cart page
    Element Should Contain    ${cart_items}    ${item name}
    

