*** Settings ***

Documentation           New test suite
Library                 QForce
Library                 String
Library                 DateTime
Library                 Collections
Suite Setup             Open Browser          ${loginURL}    chrome
Suite Teardown          Close All Browsers
Resource                File.resource
*** Keywords ***
Login salesforce
    TypeText            Username              ${username}
    ClickText           Log in
    TypeText            Password              ${password}
    ClickText           Log in
    TypeText            Verification Code     ${passkey}
    ClickText           Verify
    VerifyText          Developer Edition



*** Test Cases ***
Duplicate check 
    ${Random_Time}      Get Current Date
    ${Dynamic_name}     Catenate              Garvansh       ${Random_Time}
    Login salesforce
    ClickText           Contacts
    ClickText           New
    ClickText           Last Name
    TypeText            Last Name             ${Dynamic_name}
    ScrollTo            xpath\=//label[text()\='Email']
    TypeText            Email                 Duplicate@mail123.com
    ClickText           Save                  partial_match=False
    