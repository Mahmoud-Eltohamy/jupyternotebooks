*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource    resources/portals.ipynb
*** Variables ***
${VALID_USER}     admin
${VALID_PASSWORD}    test
${Invalid_USER}     admins
${Invalid_PASSWORD}    tests
${Empty_USER}     ${EMPTY}
${Empty_PASSWORD}    ${EMPTY}


${SELFCARE_BACKEND_URL}    https://alias-selfcare-backend-aliasnumbers-valid.kermit-noprod-b.itn.intraorange/aliasnumbers/anbservices/
${SELFCARE_BACKEND_SERVICE}    dfe2d2be-db5e-11e7-8a9f-005056b44c34
${SELFCARE_BACKEND_APPID}    demo1212
${SELFCARE_BACKEND_Auth}    Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiY2xpZW50YWRtaW5wb3J0YWxpZCJdLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInJlYWQiLCJ3cml0ZSJdLCJhbGlhc051bWJlcnNTZXJ2aWNlSWQiOiJkZmUyZDJiZS1kYjVlLTExZTctOGE5Zi0wMDUwNTZiNDRjMzQiLCJleHAiOjE1Nzk0NjEwNDUsImF1dGhvcml0aWVzIjpbIkFQSSIsIlJPTEVfVVNFUiJdLCJqdGkiOiJmNDY4MmE1Yy05OTkxLTQwNGQtYTNkMC0wOGQ0ODg3YWZkZTMiLCJjbGllbnRfaWQiOiJhbGlhcy1zZWxmY2FyZS12YWxpZCJ9.HctEkcevj_TfyMw6WzXC7s_pTqVsR14P0FkM6hu1Z2w



*** keywords ***
Logout Dropdown Is Pressed
    Click Element    //button[@id='dropdownUserMenu']
    Click Element    //div[@class='dropdown-menu show']
    
    
Back Button Is Pressed
    Sleep    3
    Go Back     
    

*** Test Cases ***
01. Login Tests - Valid Login - Valid Username And Valid Password
    [setup]    
    given The Browser Is Opened To Login Page
    and A ${VALID_USER} Username and ${VALID_PASSWORD} Credentials Is Used
    When Credentials Is Submitted
    Then Routes Page Should Be Opened
    [Teardown]    Close Browser
    
02. Login Tests - inValid Login - Invalid Username And Valid Password 
    [setup]    
    given The Browser Is Opened To Login Page
    And A ${Invalid_USER} Username and ${VALID_PASSWORD} Credentials Is Used
    When Credentials Is Submitted
    Then Login Error Message Should Be Displayed
    [Teardown]    Close Browser   
    
03. Login Tests - inValid Login - Valid Username And Invalid Password
    [setup]    
    Given The Browser Is Opened To Login Page
    And A ${VALID_USER} Username and ${Invalid_PASSWORD} Credentials Is Used
    When Credentials Is Submitted
    Then Login Error Message Should Be Displayed
    [Teardown]    Close Browser       
    
04. Login Tests - Invalid Login - Invalid Username And Invalid Password
    [setup]    
    Given The Browser Is Opened To Login Page
    And A ${Invalid_USER} Username and ${Invalid_PASSWORD} Credentials Is Used
    When Credentials Is Submitted
    Then Login Error Message Should Be Displayed
    [Teardown]    Close Browser

05. Login Tests - Invalid Login - Empty Username And valid Password
    [setup]    
    Given The Browser Is Opened To Login Page
    When A ${Empty_USER} Username and ${VALID_PASSWORD} Credentials Is Used
    Then User name Error Message Should Be Displayed
    And Login Button is Not Enabled
    [Teardown]    Close Browser    
    
06. Login Tests - Invalid Login - Valid Username And Empty Password
    [setup]    
    Given The Browser Is Opened To Login Page
    When A ${VALID_USER} Username and ${Empty_PASSWORD} Credentials Is Used
    Then Password Error Message Should Be Displayed
    And Login Button is Not Enabled
    [Teardown]    Close Browser        
    
07. Login Tests - Invalid Login - Empty Username And Empty Password
    [setup]    
    Given The Browser Is Opened To Login Page
    When A ${Empty_USER} Username and ${Empty_PASSWORD} Credentials Is Used
    Then User name Error Message Should Be Displayed
    And Password Error Message Should Be Displayed
    And Login Button is Not Enabled
    [Teardown]    Close Browser
    

08. Login Tests - logout
    [setup]    
    given The Browser Is Opened To Login Page
    and A ${VALID_USER} Username and ${VALID_PASSWORD} Credentials Is Used
    And Credentials Is Submitted
    And Routes Page Should Be Opened  
    When Logout Dropdown Is Pressed
    Then Login Page Should Be Open 
    [Teardown]    Close Browser    
    

09. Login Tests - logout with navigation
    [setup]    
    given The Browser Is Opened To Login Page
    and A ${VALID_USER} Username and ${VALID_PASSWORD} Credentials Is Used
    And Credentials Is Submitted
    And Routes Page Should Be Opened  
    and Logout Dropdown Is Pressed
    and Login Page Should Be Open
    when Back Button Is Pressed
    then Login Page Should Be Open
    [Teardown]    Close Browser    