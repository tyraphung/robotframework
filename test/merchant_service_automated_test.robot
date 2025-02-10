** Settings **
Library               RequestsLibrary
Library               Collections
Resource    ../libraries/readData.robot
Resource    ../config/env.robot
Resource    ../libraries/assert.robot
Resource    ../libraries/utility.robot

** Variables **
${token}
${new_merchant_id}

*** Test Cases ***
Before Test
    [Documentation]    This one to generate the token
    Get information to generate token
    Create Session    mySession    ${TOKEN_URL}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${body}=        Create Dictionary    clientId=${clientId}    redirectUri=${redirectUri}    grantType=${grantType}    refreshToken=${refreshToken}
    ${response}=    POST On Session    mySession    ${path_token}   headers=${headers}   json=${body}
    set Suite variable  ${token}  Bearer ${response.json()["id_token"]}
TC01-01 - Create a merchant succssfully
    [documentation]     When user using valid values Then it's possible to create a merchant successfully
    Generate UUID
    Get data to create merchant data
    Create Session    mySession    ${BASE_URL}
    ${category}=    Create Dictionary    categoryName=${categoryName}    categoryCode=${categoryCode}    riskLevel=${riskLevel}    description=${description}
    ${true}=    Convert To Boolean    true
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${body}=        Create Dictionary    merchantId=${uuid_value}    baseCurrency=${baseCurrency}    dueAfter=${${dueAfter}}    invoicePrefix=${invoicePrefix}    nextInvoiceNumber=${${nextInvoiceNumber}}    mcc=${mcc}    mccName=${mccName}    loyaltyEligible=${true}    category=${category}
    ${response}=    POST On Session    mySession    ${PATH}        headers=${header}    json=${body}
    Assert response code    201    ${response.status_code}
    Assert a string in body    ${baseCurrency}    ${response.json()["data"]["baseCurrency"]}
    Assert a string in body    ${invoicePrefix}    ${response.json()["data"]["invoicePrefix"]}
    Assert a string in body    ${mccName}    ${response.json()["data"]["mccName"]}
    set Suite variable  ${new_merchant_id}    ${response.json()["data"]["merchantId"]}
TC01-02 - Create a merchant with invalid token
    [documentation]     When user using invalid token Then user get error 401
    Generate UUID
    Get data to create merchant data
    Get error message from file
    Create Session    mySession    ${BASE_URL}
    ${category}=    Create Dictionary    categoryName=${categoryName}    categoryCode=${categoryCode}    riskLevel=${riskLevel}    description=${description}
    ${false}=    Convert To Boolean    false
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${AUTH_HEADER_INVALID_VALUE}
    ${body}=        Create Dictionary    merchantId=${uuid_value}    baseCurrency=${baseCurrency}    dueAfter=${${dueAfter}}    invoicePrefix=${invoicePrefix}    nextInvoiceNumber=${${nextInvoiceNumber}}    mcc=${mcc}    mccName=${mccName}    loyaltyEligible=${true}    category=${category}
    ${response}=    POST On Session    mySession    ${PATH}        headers=${header}    json=${body}    expected_status=401
    Assert response code    401    ${response.status_code}
    Assert a string in body    ${missingTokenError}    ${response.json()["message"]}
TC01-03 - Create a merchant with empty baseCurrency
    [documentation]     When user using empty baseCurrency Then user get the error 400
    Generate UUID
    Get data to create merchant data
    Get error code from csv
    Create Session    mySession    ${BASE_URL}
    ${category}=    Create Dictionary    categoryName=${categoryName}    categoryCode=${categoryCode}    riskLevel=${riskLevel}    description=${description}
    ${false}=    Convert To Boolean    false
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${body}=        Create Dictionary    merchantId=${uuid_value}    baseCurrency=    dueAfter=${${dueAfter}}    invoicePrefix=${invoicePrefix}    nextInvoiceNumber=${${nextInvoiceNumber}}    mcc=${mcc}    mccName=${mccName}    loyaltyEligible=${true}    category=${category}
    ${response}=    POST On Session    mySession    ${PATH}        headers=${header}    json=${body}    expected_status=400
    Assert response code    400    ${response.status_code}
    Assert error code in body    ${errorCode}    ${response.json()["errors"][0]["code"]}
TC02-01 - Retrieve an existing merchant successful
    [documentation]     When user get infomation of a specific merchant Then user can see the correct information
    Create Session    mySession    ${BASE_URL}
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${response}=  GET On Session    mySession    ${PATH}/${new_merchant_id}    headers=${header}
    Assert response code    200    ${response.status_code}
TC02-02 - Retrieve an existing merchant with invalid token
    [documentation]     When user get infomation with an invalid token Then user get error 401
    Get error message from file
    Create Session    mySession    ${BASE_URL}
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${AUTH_HEADER_INVALID_VALUE}
    ${response}=  GET On Session    mySession    ${PATH}/${new_merchant_id}        headers=${header}    expected_status=401
    Assert response code    401    ${response.status_code}
    Assert a string in body    ${missingTokenError}    ${response.json()["message"]}
TC02-03 - Retrieve an existing merchant with invalid merchantId
    [documentation]     When user get infomation with an invalid merchantId Then user get error 400
    Get error code from csv
    Create Session    mySession    ${BASE_URL}
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${response}=  GET On Session    mySession    ${PATH}/test-123        headers=${header}    expected_status=400
    Assert response code    400    ${response.status_code}
    Assert error code in body    ${errorCode}    ${response.json()["errors"][0]["code"]}
TC03-01 - Retrieve all existing merchant successful
    [documentation]     When user get infomation without any parameters Then user can see all merchant
    Create Session    mySession    ${BASE_URL}
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${response}=  GET On Session    mySession    ${PATH}        headers=${header}
    Assert response code    200    ${response.status_code}
TC03-02 - Retrieve all existing merchant with invalid token
    [documentation]     When user get infomation with an invalid token Then user get error 401
    Get error message from file
    Create Session    mySession    ${BASE_URL}
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${AUTH_HEADER_INVALID_VALUE}
    ${response}=  GET On Session    mySession    ${PATH}        headers=${header}    expected_status=401
    Assert response code    401    ${response.status_code}
    Assert a string in body    ${missingTokenError}    ${response.json()["message"]}
TC03-03 - Retrieve all existing merchant with valid parameter mccName
    [documentation]     When user get infomation with an valid mccName Then user get all merchant with the same mccName
    Get data to create merchant data
    Create Session    mySession    ${BASE_URL}
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${params} =    Create Dictionary    mccName=${mccName}
    ${response}=  GET On Session    mySession    ${PATH}        headers=${header}    params=${params}
    Assert response code    200    ${response.status_code}
    Assert a string in body    ${mccName}    ${response.json()["data"][0]["mccName"]}
TC03-04 - Retrieve all existing merchant with invalid pagination
    [documentation]     When user get infomation with an invalid pagination Then user get error 400
    Get error code from csv
    Create Session    mySession    ${BASE_URL}
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${params} =    Create Dictionary    pageNumber=test123
    ${response}=  GET On Session    mySession    ${PATH}        headers=${header}    params=${params}    expected_status=400
    Assert response code    400    ${response.status_code}
    Assert error code in body    ${errorCode}    ${response.json()["errors"][0]["code"]}
TC04-01 - Update a merchant’s invoicePrefix and loyaltyEligible
    [documentation]     When user update infomation with new merchant’s invoicePrefix and loyaltyEligible Then user get the new information
    Get data to create merchant data
    Get data to update merchant data
    Create Session    mySession    ${BASE_URL}
    ${false}=    Convert To Boolean    false
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${body}=        Create Dictionary    baseCurrency=${baseCurrency}    dueAfter=${${dueAfter}}   invoicePrefix=${invoicePrefixUpdate}    nextInvoiceNumber=${${nextInvoiceNumber}}    mcc=${mcc}    mccName=${mccName}    loyaltyEligible=${false}
    ${response}=    PATCH On Session    mySession    ${PATH}/${new_merchant_id}        headers=${header}    json=${body}
    Assert response code    200    ${response.status_code}
    Assert a string in body    ${invoicePrefixUpdate}    ${response.json()["data"]["invoicePrefix"]}
    Assert a string in body    ${false}    ${response.json()["data"]["loyaltyEligible"]}
TC04-02 - Update a merchant with invalid token
    [documentation]     When user update infomation with invalid token Then user get error 401
    Get data to create merchant data
    Get data to update merchant data
    Get error message from file
    Create Session    mySession    ${BASE_URL}
    ${false}=    Convert To Boolean    false
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${AUTH_HEADER_INVALID_VALUE}
    ${body}=        Create Dictionary    baseCurrency=${baseCurrency}    dueAfter=${${dueAfter}}   invoicePrefix=${invoicePrefixUpdate}    nextInvoiceNumber=${${nextInvoiceNumber}}    mcc=${mcc}    mccName=${mccName}    loyaltyEligible=${false}
    ${response}=    PATCH On Session    mySession    ${PATH}/${new_merchant_id}        headers=${header}    json=${body}    expected_status=401
    Assert response code    401    ${response.status_code}
    Assert a string in body    ${missingTokenError}    ${response.json()["message"]}
TC04-03 - Update a merchant with emplty baseCurrency
    [documentation]     When user update infomation with emplty baseCurrency Then user get error 400
    Get data to create merchant data
    Get data to update merchant data
    Get error code from csv
    Create Session    mySession    ${BASE_URL}
    ${false}=    Convert To Boolean    false
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${body}=        Create Dictionary    baseCurrency=    dueAfter=${${dueAfter}}   invoicePrefix=${invoicePrefixUpdate}    nextInvoiceNumber=${${nextInvoiceNumber}}    mcc=${mcc}    mccName=${mccName}    loyaltyEligible=${false}
    ${response}=    PATCH On Session    mySession    ${PATH}/${new_merchant_id}        headers=${header}    json=${body}    expected_status=400
    Assert response code    400    ${response.status_code}
    Assert error code in body    ${errorCode}    ${response.json()["errors"][0]["code"]}
After Test
    [documentation]     Delete the created merchant - clear data test
    Create Session    mySession    ${BASE_URL}
    ${header}=  Create Dictionary      Content-Type=application/json    Authorization=${token}
    ${response}=    DELETE On Session    mySession    ${PATH}/${new_merchant_id}       headers=${header}
    Assert response code    204    ${response.status_code}