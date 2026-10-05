*** Settings ***

Documentation             New test suite
Library                   QForce
Library                   String
Library                   DateTime
Library                   RequestsLibrary
Library                   Collections
Suite Setup               Open Browser                ${loginURL}              chrome
Suite Teardown            Close All Browsers
Resource                  File.resource



*** Keywords ***
Login salesforce
    TypeText              Username                    ${username}
    ClickText             Log in
    TypeText              Password                    ${password}
    ClickText             Log in
    TypeText              Verification Code           ${passkey}
    ClickText             Verify
    VerifyText            Developer Edition


*** Variables ***
${domain}                 https://orgfarm-55fe4cdac9-dev-ed.develop.my.salesforce.com
${ClientId}               3MVG91oqviqJKoEFP0o2GjFFWVIq5JktxHDTBhZfoeOt6xL75qlB5MOxA8.3wDFU7HWHZ9HIyH4nd5C2nNZEu
${ClientSecret}           8FF9D5E9842AA5FC14B6BC7D08ED531D2CB84C559097CA81CF36F13EC4F3EF41
*** Test Cases ***
# Duplicate check 
#     ${Random_Time}        Get Current Date
#     ${Dynamic_name}       Catenate                    Garvansh                 ${Random_Time}
#     Login salesforce
#     ClickText             Contacts
#     ClickText             New
#     ClickText             Last Name
#     TypeText              Last Name                   ${Dynamic_name}
#     ScrollTo              xpath\=//label[text()\='Email']
#     TypeText              Email                       Duplicate@mail123.com
#     ClickText             Save                        partial_match=False

    # Opportunity stage check
    # Login salesforce
    # ${popup_exists}     GetElementCount             xpath\=//button[contains(text(),'Dismiss')]
    # IF                  ${popup_exists} > 0
    #                     ClickText                   Dismiss
    # END
    # CLickText           Opportunities

    # FOR                 ${Opportunities}            IN                       @{Opportunities}
    #                     ${Stage}                    GetText                  xpath\=
    #                     IF

    #                     END

    # END
Direct record creation using REST API 
    # Step 1: Fetch Access Token (Same as Postman Call 1)
    Create Session    sf_api    ${domain}    verify=True
    &{auth_data}=     Create Dictionary    grant_type=client_credentials    client_id=${CLIENT_ID}    client_secret=${CLIENT_SECRET}
    ${token_resp}=    POST On Session      sf_api    /services/oauth2/token    data=${auth_data}    expected_status=200
    ${access_token}=  Set Variable         ${token_resp.json()}[access_token]
    
    # Step 2: Prepare Authorization Header
    &{auth_headers}=  Create Dictionary    Authorization=Bearer ${access_token}    Content-Type=application/json
    
    Login salesforce
    
    # Step 3: Create Account via POST /sobjects/Account/
    &{acc_body}=      Create Dictionary    Name=Copado CRT API Account    Rating=Hot    Industry=Technology
    ${acc_resp}=      POST On Session      sf_api    /services/data/v60.0/sobjects/Account/    json=${acc_body}    headers=${auth_headers}    expected_status=201
    ${account_id}=    Set Variable         ${acc_resp.json()}[id]
    Log To Console    Created Account ID: ${account_id}
    
    # Step 4: Create Opportunity Linked to that Account (Using AccountId!)
    &{opp_body}=      Create Dictionary    Name=Copado CRT Linked Deal    StageName=Prospecting    CloseDate=2026-10-21    AccountId=${account_id}
    ${opp_resp}=      POST On Session      sf_api    /services/data/v60.0/sobjects/Opportunity/    json=${opp_body}    headers=${auth_headers}    expected_status=201
    ${opp_id}=        Set Variable         ${opp_resp.json()}[id]
    Log To Console    Created Linked Opportunity ID: ${opp_id}

