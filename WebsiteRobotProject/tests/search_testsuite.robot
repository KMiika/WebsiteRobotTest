*** Settings ***
Library    SeleniumLibrary
Variables    C:/temp/WebsiteRobotProject/resources/Variables.py

*** Variables ***
${HAKU_BUTTON}      xpath://span[@class="hidden-xs"]
${HAE_BUTTON}       xpath://button[@title='Hae' and @value='HAE']
${INPUT_FIELD}      xpath://input[@id='hakusana' and @class='searchtext autosuggest ui-autocomplete-input']
${SEARCH_RESULT}    xpath://*[@id="ela_hakutulokset"]/div[1]

*** Test Cases ***
Test search with multiple hits
    Open the website and maximize window
    Click Element    ${HAKU_BUTTON}
    Input Text    ${INPUT_FIELD}    opinnäytetyö
    Click Element    ${HAE_BUTTON}
    Element Should Contain    ${SEARCH_RESULT}    tulosta
    Element Should Not Contain    ${SEARCH_RESULT}    0 tulosta
    Close Browser

Test search with zero hits
    Open the website and maximize window
    Click Element    ${HAKU_BUTTON}
    Input Text    ${INPUT_FIELD}    testihakusana
    Click Element    ${HAE_BUTTON}
    Element Should Contain    ${SEARCH_RESULT}    0 tulosta
    Close Browser

Test search with special characters and symbols hits
    Open the website and maximize window
    Click Element    ${HAKU_BUTTON}
    Input Text    ${INPUT_FIELD}    =><&*$#%^!?_|~'"`
    Click Element    ${HAE_BUTTON}
    Element Should Contain    ${SEARCH_RESULT}    0 tulosta
    Close Browser

Test with empty input field
    Open the website and maximize window
    Click Element    ${HAKU_BUTTON}
    Click Element    ${HAE_BUTTON}
    Element Should Not Be Visible    ${SEARCH_RESULT}
    Close Browser

*** Keywords ***
Open the website and maximize window
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option("excludeSwitches", ["enable-logging"])
    Maximize Browser Window