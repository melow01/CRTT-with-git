*** Variables ***
${loginURL}           https://login.salesforce.com/
${username}           garvanshcrt@cyntexa.com
${password}           @Mittal123
${passkey}            WRCQVZR832

#--------------------------------------Dynamic Values------------------------
*** Variables ***
${RandomSuffix}       Generate Random String      5                      [LETTERS][NUMBER]
${CurrentTime}        Get Current Date            result_format=%H:%M
${CloseDate}          Get Current Date            increment=7 days       result_format=%m/%d/%Y
${DynamicName}        Catenate                    Garvansh               ${CurrentTime}
${DynamicLastName}    Catenate                    Garvansh               ${RandomSuffix}
${DynamicCompany}     Catenate                    Comp                   ${RandomSuffix}