*** Settings ***

*** Variables ***

*** Keywords ***
Assert response code    [Arguments]    ${code}    ${respone}
    [Documentation]    This one for assert the response code
    ${statusCode}=      Convert To Integer      ${respone}
    Should Be Equal As Integers    ${statusCode}    ${code}
Assert error code in body    [Arguments]    ${code}    ${respone}
    [Documentation]    This one for assert the error code this the response body
    ${codeError}=      Convert To String      ${respone}
    Should Be Equal As Strings    ${codeError}    ${code}
Assert a string in body    [Arguments]    ${expected_string}    ${respone}
    [Documentation]    This one for assert a string value in the response body
    ${actual_string}=      Convert To String      ${respone}
    Should Be Equal As Strings    ${actual_string}    ${expected_string}
