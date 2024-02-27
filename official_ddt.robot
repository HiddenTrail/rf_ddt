*** Settings ***
Library           Browser
Test Template     Google search with template

*** Variables ***
${SEARCH_LOCATOR}   //*[@aria-label="Search"]

*** Test Cases ***                   SEARCH_TERM                EXPECTED_TEXT
Google search with different terms   Kekkonen                   Urho Kekkonen
                                     Koivisto                   Presidentti Mauno Koivisto
                                     Mersu                      Mercedes-Benz-henkilöautot

*** Keywords ***
Google search with template
    [Arguments]         ${SEARCH_TERM}    ${EXPECTED_TEXT}
    New Browser         chromium          headless=No
    New Page            https://www.google.com/search?q=${SEARCH_TERM}
    Click               //*[text()="Accept all"]
    ${actual_text}=     Get Text    //*[@id="search"]
    Should Contain      ${actual_text}    ${EXPECTED_TEXT}
    Sleep               3s
    [Teardown]          Close Browser
