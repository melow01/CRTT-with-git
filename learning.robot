*** Settings ***

Documentation             New test suite
# You can change imported library to "QWeb" if testing generic web application, not Salesforce.
Library                   QForce
Library                   String
Suite Setup               Open Browser                ${loginURL}             chrome
Suite Teardown            Close All Browsers

*** Variables ******
${loginURL}               https://login.salesforce.com/
${username}               garvanshcrt@cyntexa.com
${password}               @Mittal123
${passkey}                3AMXUHMRBR
# ${Last name}            Garvansh test2
# ${Company}              JohnDeer Pvt.Ltd.


*** Test Cases ***


Login to Salesforce
    ${RandomSuffix}       Generate Random String      5                       [LETTERS][NUMBER]
    ${DynamicLastName}    Catenate                    Garvansh                ${RandomSuffix}
    ${DynamicCompany}     Catenate                    Comp                    ${RandomSuffix}


    TypeText              Username                    ${username}
    ClickText             Log in
    TypeText              Password                    ${password}
    ClickText             Log in
    TypeText              Verification Code           ${passkey}
    ClickText             Verify
    VerifyText            Developer Edition

    # Logout from Salesforce
    #                     ClickText                   View profile
    #                     ClickText                   Log Out

    # Creating Account record and Verifying it

    #                     ClickText                   Accounts
    #                     ClickText                   New
    #                     VerifyText                  New Account
    #                     ClickText                   Account Name
    #                     TypeText                    Account Name            Test Account2
    #                     PickList                    Rating                  Hot
    #                     ClickText                   Save                    partial_match= False
    #                     ClickText                   Details
    #                     VerifyText                  Account Name            Test Account2

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

    # VerifyText          ${DynamicCompany}
    # ClickText           ${DynamicCompany}
    # Clicktext           ${Company}
    # VerifyText          ${Last name}
    # VerifyElement       xpath=//*[text()='JohnDeer Pvt.Ltd.-']
