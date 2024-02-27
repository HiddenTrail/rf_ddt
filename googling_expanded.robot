*** Settings ***
Library           Browser

*** Variables ***
${SEARCH_TERM}      kekkonen
${EXPECTED_TEXT}    Urho Kekkonen
${SEARCH_LOCATOR}   //*[@aria-label="Search"]

*** Test Cases ***
HAKU0001 Google search for Kekkonen finds Urho Kekkonen
    New Browser         chromium    headless=No
    New Page            https://www.google.com/search?q=Kekkonen
    Click               //*[text()="Accept all"]
    ${actual_text}=     Get Text    //*[@id="search"]
    Should Contain      ${actual_text}    Urho Kekkonen
    Sleep               3s
    [Teardown]          Close Browser

HAKU0002 Google search for Koivisto finds Presidentti Mauno Koivisto
    New Browser         chromium    headless=No
    New Page            https://www.google.com/search?q=Koivisto
    Click               //*[text()="Accept all"]
    ${actual_text}=     Get Text    //*[@id="search"]
    Should Contain      ${actual_text}    Presidentti Mauno Koivisto
    Sleep               3s
    [Teardown]          Close Browser

Haku0003 Google search for Mersu finds Mercedes-Benz-henkilöautot
    New Browser         chromium    headless=No
    New Page            https://www.google.com/search?q=Mersu
    Click               //*[text()="Accept all"]
    ${actual_text}=     Get Text    //*[@id="search"]
    Should Contain      ${actual_text}    Mercedes-Benz-henkilöautot
    Sleep               3s
    [Teardown]          Close Browser


Toinen testi
    New Browser         chromium    headless=No
    New Page            https://www.vr.fi
    Click               //*[@data-testid="accept"]
    Sleep               3s

