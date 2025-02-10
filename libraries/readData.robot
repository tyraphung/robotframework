** Settings **
Library    Collections
Library    CSVLibrary

*** Variables ***
${clientId}
${redirectUri}
${grantType}
${refreshToken}
${errorCode}
${baseCurrency}
${dueAfter}
${invoicePrefix}
${nextInvoiceNumber}
${mcc}
${mccName}
${categoryName}
${categoryCode}
${riskLevel}
${description}
${invoicePrefixUpdate}
${missingTokenError}

*** Keywords ***
Get error code from csv
    [Documentation]    This one to get the error code from the file
    ${all data}=    read csv file to list    libraries/data.csv
    FOR    ${data}   IN   ${all data}
        set Suite variable  ${errorCode}  ${data}[5][1]
    END
Get information to generate token
    [Documentation]  This one to get the information to generate the token
    ${all data}=    read csv file to list    libraries/data.csv
    FOR    ${data}   IN   ${all data}
        set Suite variable  ${clientId}  ${data}[1][1]
        set Suite variable  ${redirectUri}  ${data}[2][1]
        set Suite variable  ${grantType}  ${data}[3][1]
        set Suite variable  ${refreshToken}  ${data}[4][1]
    END
Get data to create merchant data
    [Documentation]    This one to get the data to create a new merchant
    ${all data}=    read csv file to list    libraries/data.csv
    FOR    ${data}   IN   ${all data}
        set Suite variable  ${baseCurrency}  ${data}[6][1]
        set Suite variable  ${dueAfter}  ${data}[7][1]
        set Suite variable  ${invoicePrefix}  ${data}[8][1]
        set Suite variable  ${nextInvoiceNumber}  ${data}[9][1]
        set Suite variable  ${mcc}  ${data}[10][1]
        set Suite variable  ${mccName}  ${data}[11][1]
        set Suite variable  ${categoryName}  ${data}[12][1]
        set Suite variable  ${categoryCode}  ${data}[13][1]
        set Suite variable  ${riskLevel}  ${data}[14][1]
        set Suite variable  ${description}  ${data}[15][1]
    END
Get data to update merchant data
    [Documentation]    This one to get the data to update a merchant
    ${all data}=    read csv file to list    libraries/data.csv
    FOR    ${data}   IN   ${all data}
        set Suite variable  ${invoicePrefixUpdate}  ${data}[16][1]
    END
Get error message from file
    [Documentation]    this one to get the error message from file
    ${all data}=    read csv file to list    libraries/data.csv
    FOR    ${data}   IN   ${all data}
        set Suite variable  ${missingTokenError}  ${data}[17][1]
    END

