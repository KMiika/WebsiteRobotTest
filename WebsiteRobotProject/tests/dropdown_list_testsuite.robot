*** Settings ***
Library    SeleniumLibrary
Variables    C:/temp/WebsiteRobotProject/resources/Variables.py

*** Variables ***
${DROPDOWN_LIST}     xpath=//*[@id="dj-megamenu90"]/li[2]/div
${DROPDOWN_ARROW}    xpath=//*[@id="dj-megamenu90"]/li[2]
${TEST_LINK}         xpath=//*[@id="dj-megamenu90"]/li[2]/div/div/div[1]/ul/li[1]


*** Test Cases ***
Dropdown list initial state should be hidden
    Open the website and maximize window
    Element Should Not Be Visible    ${DROPDOWN_LIST}
    Close Browser

Dropdown list should open when hovering over
    Open the website and maximize window
    Mouse Over    ${DROPDOWN_ARROW}
    Element Should Be Visible    ${DROPDOWN_LIST}
    Close Browser

Test dropdown menu links
    Open the website and maximize window
    Mouse Over    ${DROPDOWN_ARROW}
    Click Element    ${TEST_LINK}
    Title Should Be    Tutkintoon johtava koulutus
    Close Browser

Dropdown menu should be hidden when browser window is small
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option("excludeSwitches", ["enable-logging"])
    Set Window Size    600    600
    Element Should Not Be Visible    ${DROPDOWN_ARROW}
    Close Browser

*** Keywords ***
Open the website and maximize window
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option("excludeSwitches", ["enable-logging"])
    Maximize Browser Window