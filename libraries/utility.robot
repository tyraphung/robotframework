*** Settings ***
Library    String

*** Variables ***
${uuid_value}

*** Keywords ***
Generate UUID
    [Documentation]    This one for generate UUID data
    ${number4}=    Generate random string        4     [NUMBERS]
    ${number8}=    Generate random string        8     [NUMBERS]
    ${number12}=    Generate random string        12     [NUMBERS]
    ${final}=    Catenate    SEPARATOR=-    ${number8}    ${number4}    ${number4}    ${number4}    ${number12}
    ${View_callsrc_LowerCase}=    Evaluate     "${final}".lower()
    set Suite variable    ${uuid_value}    ${View_callsrc_LowerCase}