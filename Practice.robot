*** Settings ***

Documentation             New test suite
Library                   QForce
Library                   String
Library                   DateTime
Library                   RequestsLibrary
Library                   Collections
Suite Setup               Open Browser                ${loginURL}    chrome
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
    #                     ${Random_Time}              Get Current Date
    #                     ${Dynamic_name}             Catenate       Garvansh            ${Random_Time}
    #                     Login salesforce
    #                     ClickText                   Contacts
    #                     ClickText                   New
    #                     ClickText                   Last Name
    #                     TypeText                    Last Name      ${Dynamic_name}
    #                     ScrollTo                    xpath\=//label[text()\='Email']
    #                     TypeText                    Email          Duplicate@mail123.com
    #                     ClickText                   Save           partial_match=False

    # Opportunity stage check
    # Login salesforce
    # ${popup_exists}     GetElementCount             xpath\=//button[contains(text(),'Dismiss')]
    # IF                  ${popup_exists} > 0
    #                     ClickText                   Dismiss
    # END
    # CLickText           Opportunities

    # FOR                 ${Opportunities}            IN             @{Opportunities}
    #                     ${Stage}                    GetText        xpath\=
    #                     IF

    #                     END

    # END
Direct record creation using REST API 
    ${Random}=       Get Current Date     result_format=%H:%M
    ${Dynamic}=           Catenate                    Garvansh       ${Random}
    Wait Until Keyword Succeeds                       2x             3s    ClientAuthenticate    ${domain}                   ${ClientId}    ${client_secret}
    
    ${Accounts}            Create record               Account      Name=${Dynamic}    Rating=Hot
    Log To Console         ${Accounts}
    
    ${Query}               QueryRecords                query= Select id,Name from Account Where CreatedDate = TODAY Order By CreatedDate Desc limit 1


