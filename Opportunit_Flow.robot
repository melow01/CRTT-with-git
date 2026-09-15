*** Settings ***

Documentation            New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                  QForce
Library                  String
Library                  DateTime
Suite Setup              Open Browser                ${loginURL}               chrome
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
${passkey}               GOLF05N0TY
${Is_Visible}            IsElementVisible            //span[@title='Cases']


*** Test Cases ***

Login to Salesforce
    ${RandomSuffix}      Generate Random String      5                         [LETTERS][NUMBER]
    ${CurrentTime}       Get Current Date            result_format=%H:%M
    ${CloseDate}         Get Current Date            increment=7 days          result_format=%m/%d/%Y
    ${DynamicName}       Catenate                    Garvansh                  ${CurrentTime}

    # ${DynamicCompany}                              Catenate                  Comp                      ${RandomSuffix}

    Login salesforce


    # Opportunity Flow
    #                    ClickText                   Opportunities
    #                    ClickText                   New
    #                    UseModal                    On
    #                    ClickText                   Opportunity Name
    #                    TypeText                    Opportunity Name          ${DynamicName}
    #                    PickList                    Stage                     Qualification
    #                    ClickText                   Close Date
    #                    TypeText                    Close Date                ${CloseDate}
    #                    ClickText                   Save                      partial_match=False
    #                    ClickText                   Related
    #                    ClickElement                xpath\=//a[contains(@href, 'OpportunityLineItems')]
    #                    ClickElement                xpath=//div[@title='Add Products']
    #                    ClickElement                xpath=//input[@aria-describedby='Search']
    #                    TypeText                    Search                    GenWatt Diesel 1000kW
    #                    ClickElement                xpath=//lightning-icon[@icon-name='utility:search']
    # ${OpportunityCount}=                           Get Element Count         xpath=//table//tbody//tr//th//a
    # FOR                ${Index}                    IN RANGE                  1                         ${OpportunityCount + 1}
    #                    ClickElement                xpath=(*[@title='Opportunity Name'])[${Index}]
    #                    ${StageValue}=              GetText                   xpath=//*[text()='Stage']
    #                    IF                          '${StageValue}' == 'Negotiation/Review'
    #                    # Yaha required action perform karo
    #                    Log                         Required Opportunity found
    #                    ClickText                   Edit Amount
    #                    TypeText                    Amount                    1
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
    #                    ${ContactEmail}=            Get Text                  Email
    #                    ${ContactEmail}=            Get Text                  xpath\=//records-record-layout-item[@field-label\='Email']
    #                    ${Assistant}=               Get Text                  xpath\=//records-record-layout-item[@field-label\='Assistant']
    #                    ${Name}=                    Get Text                  xpath\=//records-record-layout-item[@field-label\='Name']

    #                    log                         ${Assistant}
    #                    VerifyText                  ${Assistant}
    #                    log                         ${Name}
    #                    VerifyText                  ${Name}
    #                    Debug Element Count
    #                    ${count}                    GetElementCount           xpath\=//a[contains(@href\='OpportunityLineItems')]
    #                    Log                         ${count}

Practice Loop
    # Login salesforce
    @{Contact_Names}=    Create List                 Trial1                  Trial2                  Trial3
    ClickText            Contacts
    ClickText        New


    FOR                  ${Contact_Name}             IN                        @{Contact_Names}
       
        ClickText        Last Name
        TypeText         Last Name                ${Contact_Name}
        ClickText        Save & New                  partial_match=TRUE
        Log              Current Account: ${Contact_Name}
    END