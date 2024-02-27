*** Settings ***
Library           Browser

*** Variables ***
${SEARCH_TERM}      kekkonen
${EXPECTED_TEXT}    Urho Kekkonen
${SEARCH_LOCATOR}   //*[@aria-label="Search"]

*** Test Cases ***
#@DDT-Test:
Google search for ${SEARCH_TERM} finds ${EXPECTED_TEXT}
    New Browser         chromium    headless=No
    New Page            https://www.google.com/search?q=${SEARCH_TERM}
    Click               //*[text()="Accept all"]
    ${actual_text}=     Get Text    //*[@id="search"]
    Should Contain      ${actual_text}    ${EXPECTED_TEXT}
    Sleep               3s
    [Teardown]          Close Browser

#@DDT-Data:
# ID       | SEARCH_TERM | EXPECTED_TEXT
# HAKU0001 | Kekkonen    | Urho Kekkonen
# HAKU0002 | Koivisto    | Presidentti Mauno Koivisto
# Haku0003 | Mersu       | Mercedes-Benz-henkilöautot
#@DDT-Data-end

Toinen testi
    New Browser         chromium    headless=No
    New Page            https://www.vr.fi
    Click               //*[@data-testid="accept"]
    Sleep               3s
