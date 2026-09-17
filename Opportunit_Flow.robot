*** Settings ***

Documentation                   New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                         QForce
Library                         String
Library                         DateTime
Library                         Collections
Suite Setup                     Open Browser                ${loginURL}                 chrome
Suite Teardown                  Close All Browsers
*** Keywords ***
Login salesforce
    TypeText                    Username                    ${username}
    ClickText                   Log in
    TypeText                    Password                    ${password}
    ClickText                   Log in
    TypeText                    Verification Code           ${passkey}
    ClickText                   Verify
    VerifyText                  Developer Edition

*** Variables ******
${loginURL}                     https://login.salesforce.com/
${username}                     garvanshcrt@cyntexa.com
${password}                     @Mittal123
${passkey}                      LI8WH67EX3
${Is_Visible}                   IsElementVisible            //span[@title='Cases']


*** Test Cases ***

Login

    # ${DynamicCompany}         Catenate                    Comp                        ${RandomSuffix}




Opportunity Flow
    ${RandomSuffix}             Generate Random String      5                           [LETTERS][NUMBER]
    ${CurrentTime}              Get Current Date            result_format=%H:%M
    ${CloseDate}                Get Current Date            increment=7 days            result_format=%m/%d/%Y
    ${DynamicName}              Catenate                    Garvansh                    ${CurrentTime}
    #-----------------------------------------------------------------------------------Opportunity Creation--------------------------------------------
    Login salesforce
    ClickText                   Opportunities
    ClickText                   New
    UseModal                    On
    ClickText                   Opportunity Name
    TypeText                    Opportunity Name            ${DynamicName}
    PickList                    Stage                       Qualification
    ClickText                   Close Date
    TypeText                    Close Date                  ${CloseDate}
    ClickText                   Save                        partial_match=False
    ClickText                   Related
    # ClickText                 Garvansh 08:25
    #-----------------------------------------------------------------------------------Adding Products-----------------------------------------------
    ClickElement         xpath\=//a[contains(@href, 'OpportunityLineItems')]
    ClickElement         xpath=//div[@title='Add Products']
    #@{price_list}              Create List
    &{Product_Price}            Create Dictionary
    @{Product_list}             Create List                 GenWatt Diesel 1000kW       Installation: Industrial - High                SLA: Gold
    @{Quantity_List}            Create List                 1                           2                           3
    # &{Product_qty}            Create Dictionary           GenWatt Diesel 1000kW= 2    Installation: Industrial - High= 1             SLA: Gold= 2
    ClickElement                xpath=//input[@aria-describedby='Search']
    FOR                         ${Product}                  IN                          @{Product_list}
        TypeText                Search Products             ${Product}
        ClickElement            xpath=//lightning-icon[@icon-name='utility:search']
        ClickElement            xpath=//div[@role='listbox']
        ClickCheckbox           ${Product}                  on
        # ${price}              Get Text                    xpath\=//tr[.//a[text()\='${Product}']]//span[contains(@class,'forceOutputCurrency')]

    END
    ClickElement                xpath=//button[@title='Next']
    # Log Dictionary            ${Product_Price}
    # Log                       ${Product_Price}

    FOR                         ${index}                    ${Product}                  IN ENUMERATE                @{Product_list}
        ClickElement            xpath=//tr[.//a[text()='${Product}']]//button[contains(@title,'Edit Quantity')]     clicks=2
        # ${Sales_price}        Get Text                    xpath\=//tr[.//a[text()\='${Product}']]//span[contains(@class,'forceOutputCurrency')]
        TypeText                Quantity                    ${Quantity_List}[${index}]                              anchor=${Product}
        # Set To Dictionary     ${Product_Price}            ${Product}                  ${Sales_price}
    END
    ClickText                   Save
    ClickElement                xpath=//a[text()='${DynamicName}']
    ClickText                   Details

    #---------------------------------------------------------------------------------------Price Validation-----------------------------------------
    ClickText                   Products                    partial_match=False

    &{product_price}            Create Dictionary
    &{product_quantity}         Create Dictionary
    FOR                         ${prod}                     IN                          @{Product_list}
        ${quantity}=            Get Text                    xpath\=//tr[.//a[text()\='${prod}']]//span[contains(@class,'uiOutputNumber')]
        ${sales_price}=         Get Text                    xpath\=//tr[.//a[text()\='${prod}']]//span[contains(@class,'forceOutputCurrency')]
        ${product_quantity}[${prod}]=                       Set Variable                ${quantity}
        ${product_price}=       Set Variable                ${sales_price}
    END
    ${total_amount}=            Set Variable                0
    FOR                         ${produ}                    IN                          @{Product_list}
        ${quantity}=            Convert To Number           ${quantity}
        ${sales_price}=         Remove String               ${sales_price}              $                           ,
        ${product_total}=       Evaluate                    ${quantity} * ${sales_price}
        ${total_amount}=        Evaluate                    ${total_amount} + ${product_total}
    END
    ClickElement                xpath=//a[contains(text(),'${DynamicName}')]
    CLickText                   Details
    ${opportunity_amount}=      Get Text                    xpath\=//sfa-output-opportunity-amount[@slot\='outputField']
    ${opportunity_amount}=      Remove String               ${opportunity_amount}       $                           ,

    IF                          ${total_amount} != ${opportunity_amount}
        Log                     Product Total and Opportunity Amount are equal:${total_amount} : ${opportunity_amount}
    ELSE
        Log                     Product Total and Opportunity Amount are NOT equal
    END


    # &{Qty_SP}                 Create Dictionary
    # &{Product_SP}             Create Dictionary
    # FOR                       ${Product}                  IN                          @{Product_list}
    #                           ${qty_count}                Get Text                    xpath\=//li[contains(.,'${product}')]//div[@title\='Quantity:']/following-sibling::div//span
    #                           ${price}                    GetText                     xpath\=//li[contains(.,'${product}')]//div[@title\='Sales Price:']/following-sibling::div//span
    #                           Set To Dictionary           &{Qty_SP}                   ${qty_count}
    #                           Set To Dictionary           &{Product_SP}               ${price}
    #                           ${Product_amount}           Evaluate                    ${qty_count}' * ${price}

    #                           Log                         ${product} - Qty: ${qty_count}, Price: ${price}, Amount: ${Product_amount}

    # END





    # TypeText                  Search                      GenWatt Diesel 1000kW
    #
    # ${OpportunityCount}=      Get Element Count           xpath=//table//tbody//tr//th//a
    # FOR                       ${Index}                    IN RANGE                    1                           ${OpportunityCount + 1}
    #                           ClickElement                xpath=(*[@title='Opportunity Name'])[${Index}]
    #                           ${StageValue}=              GetText                     xpath=//*[text()='Stage']
    #                           IF                          '${StageValue}' == 'Negotiation/Review'
    #                           # Yaha required action perform karo
    #                           Log                         Required Opportunity found
    #                           ClickText                   Edit Amount
    #                           TypeText                    Amount                      1
    #                           Exit For Loop
    #                           END
    #                           GoBack
    #                           ClickText                   Opportunities
    # END


    # Practice For Conditions
    #                           ClickText                   Contacts
    #                           # ClickElement              xpath=//button[@name='pipelineInspectionToListView']
    #                           ClickText                   Test
    #                           ClickText                   Details
    #                           # Store value of Email field
    #                           ${ContactEmail}=            Get Text                    Email
    #                           ${ContactEmail}=            Get Text                    xpath\=//records-record-layout-item[@field-label\='Email']
    #                           ${Assistant}=               Get Text                    xpath\=//records-record-layout-item[@field-label\='Assistant']
    #                           ${Name}=                    Get Text                    xpath\=//records-record-layout-item[@field-label\='Name']

    #                           log                         ${Assistant}
    #                           VerifyText                  ${Assistant}
    #                           log                         ${Name}
    #                           VerifyText                  ${Name}
    #                           Debug Element Count
    #                           ${count}                    GetElementCount             xpath\=//a[contains(@href\='OpportunityLineItems')]
    #                           Log                         ${count}

    # Practice Loop
    # Login salesforce
    # @{Contact_Names}=         Create List                 Trial1                      Trial2                      Trial3
    # ClickText                 Contacts
    # ClickText                 New


    # FOR                       ${Contact_Name}             IN                          @{Contact_Names}

    #                           ClickText                   Last Name
    #                           TypeText                    Last Name                   ${Contact_Name}
    #                           ClickText                   Save & New                  partial_match=TRUE
    #                           Log                         Current Account: ${Contact_Name}
    # END                       @{Quantity_List}[0]         anchor=${Product}           anchor=${Product}

