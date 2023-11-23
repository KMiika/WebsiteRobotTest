*** Settings ***
Library    SeleniumLibrary
Variables    C:/temp/WebsiteRobotProject/resources/Variables.py
Resource    C:/temp/WebsiteRobotProject/resources/Keywords.robot

*** Variables ***
${HAKU_BUTTON}      xpath://a[@href='javascript://' and contains(@onclick, "$('#elahakualue').fadeToggle()")]
${HAE_BUTTON}       xpath://button[@title='Hae' and @value='HAE']
${INPUT_FIELD}      xpath://input[@id='hakusana' and @class='searchtext autosuggest ui-autocomplete-input']
${SEARCH_RESULT}    xpath://*[@id="ela_hakutulokset"]/div[1]

*** Test Cases ***
Test search with atleast one hit
    Open the website and maximize window
    Click Element    ${HAKU_BUTTON}
    Input Text    ${INPUT_FIELD}    testihakusana
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

Test search with special characters and symbols
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
