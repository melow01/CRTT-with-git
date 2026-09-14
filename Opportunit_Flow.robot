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

*** Test Cases ***

Login to Salesforce
    ${RandomSuffix}    Generate Random String      5                      [LETTERS][NUMBER]
    ${CurrentTime}     Get Current Date            result_format=%H:%M
    ${CloseDate}       Get Current Date            increment=7 days       result_format=%d/%m/%Y
    ${DynamicName}     Catenate                    Garvansh               ${CurrentTime}

    # ${DynamicCompany}                            Catenate               Comp                 ${RandomSuffix}


    TypeText           Username                    ${username}
    ClickText          Log in
    TypeText           Password                    ${password}
    ClickText          Log in
    TypeText           Verification Code           ${passkey}
    ClickText          Verify
    VerifyText         Developer Edition

Opportunity Flow
    ClickText          Opportunities
    ClickText          New
    UseModal           On
    ClickText          Opportunity Name
    TypeText           Opportunity Name            ${DynamicName}
    PickList           Stage                       Qualification
    ClickText          Close Date
    TypeText           Close Date                  ${CloseDate}

