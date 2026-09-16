*** Settings ***

Documentation            New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                  QForce
Library                  String
Library                  DateTime
Library                  Collections
Suite Setup              Open Browser                ${loginURL}                 chrome
Suite Teardown           Close All Browsers
*** Keywords ***
Login salesforce
    TypeText             Username                    ${username}
    ClickText            Log in
    TypeText             Password                    ${password}
    ClickText            Log in
    TypeText             Verification Code           ${passkey}
    ClickText            Verify
    VerifyText           Developer Edition

*** Variables ******
${loginURL}              https://login.salesforce.com/
${username}              garvanshcrt@cyntexa.com
${password}              @Mittal123
${passkey}               M9ATN7UXIW
${Is_Visible}            IsElementVisible            //span[@title='Cases']


*** Test Cases ***

Login to Salesforce
    ${RandomSuffix}      Generate Random String      5                           [LETTERS][NUMBER]
    ${CurrentTime}       Get Current Date            result_format=%H:%M
    ${CloseDate}         Get Current Date            increment=7 days            result_format=%m/%d/%Y
    ${DynamicName}       Catenate                    Garvansh                    ${CurrentTime}

    # ${DynamicCompany}                              Catenate                    Comp                        ${RandomSuffix}




Opportunity Flow
    Login salesforce
    ClickText            Opportunities
    # ClickText          New
    # UseModal           On
    # ClickText          Opportunity Name
    # TypeText           Opportunity Name            ${DynamicName}
    # PickList           Stage                       Qualification
    # ClickText          Close Date
    # TypeText           Close Date                  ${CloseDate}
    # ClickText          Save                        partial_match=False
    # ClickText          Related
    ClickText            Garvansh 08:25
    ClickElement         xpath\=//a[contains(@href, 'OpportunityLineItems')]
    ClickElement         xpath=//div[@title='Add Products']
    #@{price_list}       Create List
    &{Product_Price}     Create Dictionary
    @{Product_list}      Create List                 GenWatt Diesel 1000kW       Installation: Industrial - High            SLA: Gold
    @{Quantity_List}     Create List                 3                           2                                          1
    # &{Product_qty}       Create Dictionary           GenWatt Diesel 1000kW= 2     Installation: Industrial - High= 1          SLA: Gold= 2
    ClickElement         xpath=//input[@aria-describedby='Search']
    FOR                  ${Product}                  IN                          @{Product_list}
        TypeText         Search Products             ${Product}
        ClickElement     xpath=//lightning-icon[@icon-name='utility:search']
        ClickElement     xpath=//div[@role='listbox']
        ClickCheckbox    ${Product}                  on
        ${price}         Get Text                    xpath\=//tr[.//a[text()\='${Product}']]//span[contains(@class,'forceOutputCurrency')]
        Set To Dictionary                            ${Product_Price}            ${Product}                  ${price}
    END
    ClickElement         xpath=//button[@title='Next']
    Log Dictionary       ${Product_Price}
    Log                  ${Product_Price}

    FOR                  ${product_11}    IN                        @{Product_list}
        ClickElement    xpath=//tr[.//a[text()='${Product}']]//button[contains(@title,'Edit Quantity')]
        # TypeText        Quantity         @{Quantity_List}[0]            anchor=${Product_11}
    END


    # TypeText           Search                      GenWatt Diesel 1000kW
    #
    # ${OpportunityCount}=                           Get Element Count           xpath=//table//tbody//tr//th//a
    # FOR                ${Index}                    IN RANGE                    1                           ${OpportunityCount + 1}
    #                    ClickElement                xpath=(*[@title='Opportunity Name'])[${Index}]
    #                    ${StageValue}=              GetText                     xpath=//*[text()='Stage']
    #                    IF                          '${StageValue}' == 'Negotiation/Review'
    #                    # Yaha required action perform karo
    #                    Log                         Required Opportunity found
    #                    ClickText                   Edit Amount
    #                    TypeText                    Amount                      1
    #                    Exit For Loop
    #                    END
    #                    GoBack
    #                    ClickText                   Opportunities
    # END


    # Practice For Conditions
    #                    ClickText                   Contacts
    #                    # ClickElement              xpath=//button[@name='pipelineInspectionToListView']
    #                    ClickText                   Test
    #                    ClickText                   Details
    #                    # Store value of Email field
    #                    ${ContactEmail}=            Get Text                    Email
    #                    ${ContactEmail}=            Get Text                    xpath\=//records-record-layout-item[@field-label\='Email']
    #                    ${Assistant}=               Get Text                    xpath\=//records-record-layout-item[@field-label\='Assistant']
    #                    ${Name}=                    Get Text                    xpath\=//records-record-layout-item[@field-label\='Name']

    #                    log                         ${Assistant}
    #                    VerifyText                  ${Assistant}
    #                    log                         ${Name}
    #                    VerifyText                  ${Name}
    #                    Debug Element Count
    #                    ${count}                    GetElementCount             xpath\=//a[contains(@href\='OpportunityLineItems')]
    #                    Log                         ${count}

    # Practice Loop
    # Login salesforce
    # @{Contact_Names}=                              Create List                 Trial1                      Trial2         Trial3
    # ClickText          Contacts
    # ClickText          New


    # FOR                ${Contact_Name}             IN                          @{Contact_Names}

    #                    ClickText                   Last Name
    #                    TypeText                    Last Name                   ${Contact_Name}
    #                    ClickText                   Save & New                  partial_match=TRUE
    #                    Log                         Current Account: ${Contact_Name}
    # END

