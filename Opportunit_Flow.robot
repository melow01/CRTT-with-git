*** Settings ***

Documentation          New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                QForce
Library                String
Library                DateTime
Suite Setup            Open Browser                ${loginURL}            chrome
Suite Teardown         Close All Browsers

*** Variables ******
${loginURL}            https://login.salesforce.com/
${username}            garvanshcrt@cyntexa.com
${password}            @Mittal123
${passkey}             0UJKJA9V82
${Is_Visible}            IsElementVisible    //span[@title='Cases']

*** Test Cases ***

Login to Salesforce
    ${RandomSuffix}    Generate Random String      5                      [LETTERS][NUMBER]
    ${CurrentTime}     Get Current Date            result_format=%H:%M
    ${CloseDate}       Get Current Date            increment=7 days       result_format=%m/%d/%Y
    ${DynamicName}     Catenate                    Garvansh               ${CurrentTime}

    # ${DynamicCompany}                            Catenate               Comp                      ${RandomSuffix}


    TypeText           Username                    ${username}
    ClickText          Log in
    TypeText           Password                    ${password}
    ClickText          Log in
    TypeText           Verification Code           ${passkey}
    ClickText          Verify
    VerifyText         Developer Edition

    # Opportunity Flow
    # ClickText        Opportunities
    # ClickText        New
    # UseModal         On
    # ClickText        Opportunity Name
    # TypeText         Opportunity Name            ${DynamicName}
    # PickList         Stage                       Qualification
    # ClickText        Close Date
    # TypeText         Close Date                  ${CloseDate}
    # ClickText        Save                        partial_match=False
    # ClickText        Related
    # ClickElement     //*[text()='Products']
    # ${OpportunityCount}=                         Get Element Count      xpath=//table//tbody//tr//th//a
    # FOR              ${Index}                    IN RANGE               1                         ${OpportunityCount + 1}
    #                  ClickElement                xpath=(*[@title='Opportunity Name'])[${Index}]
    #                  ${StageValue}=              GetText                xpath=//*[text()='Stage']
    #                  IF                          '${StageValue}' == 'Negotiation/Review'
    #                  # Yaha required action perform karo
    #                  Log                         Required Opportunity found
    #                  ClickText                   Edit Amount
    #                  TypeText                    Amount                 1
    #                  Exit For Loop
    #                  END
    #                  GoBack
    #                  ClickText                   Opportunities
    # END
Practice For Conditions
    ClickText          Contacts
    ClickText          Test Lead 1
    # Store value of Email field
    ${ContactEmail}    GetText    xpath=//div[@data-target-selection-name='sfdc:RecordField.Contact.Email']

    log                ${ContactEmail}
    VerifText          ${ContactEmail}
    