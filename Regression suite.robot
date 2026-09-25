*** Settings ***

Documentation                   New test suite
Library                         QForce
Library                         String
Library                         DateTime
Library                         Collections
Suite Setup                     Open Browser                ${loginURL}                 chrome
Suite Teardown                  Close All Browsers

Resource    File.resource
# -------------------------------------------------------Regression suite for a user journey from lead creating till quote generation------------------------
*** Test Cases ***
Login salesforce
    TypeText    Username    ${username}
    ClickText                   Log in
    TypeText                    Password                    ${password}
    ClickText                   Log in
    TypeText                    Verification Code           ${passkey}
    ClickText                   Verify
    VerifyText                  Developer Edition

Lead Creation and Conversion
    ClickText             Leads
    ClickText             New
    VerifyText            Lead Information
    Clicktext             Salutation                  Mr.
    ClickText             Last Name
    TypeText              Last Name                   ${DynamicLastName}
    ClickText             Company
    TypeText              Company                     ${DynamicCompany}
    Picklist              Lead Status                 Open - Not Contacted
    ClickText             Save                        partial_match=False
    ClickElement          xpath=//*[text()='Show more actions']
    ClickText             Convert
    VerifyText            Convert Lead
    VerifyPickList        Converted Status            Closed - Converted
    ClickText             Convert
    VerifyText            Your lead has been converted
    ClickText             ${DynamicCompany}
    ClickText             Details
    VerifyText            ${DynamicCompany}
    ClickText             Related
    VerifyText            ${DynamicLastName}
    ClickText             ${DynamicLastName}
    Clicktext             Details
    VerifyText            ${DynamicCompany}
    ClickText             Related
    ClickElement          xpath=//article[contains(@aria-label,'Opportunities')]//a[.//span[contains(text(),'View All')]]
    ClickText             ${DynamicCompany}
    ClickText             Details