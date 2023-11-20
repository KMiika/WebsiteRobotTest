*** Settings ***
Library    SeleniumLibrary
Variables    C:/temp/WebsiteRobotProject/resources/Variables.py

*** Variables ***
${CHATBOT_BUTTON}    xpath://button[contains(@class, 'ld-launch-btn')]
${ACCEPT_COOKIES}    xpath://button[contains(@onclick, "document.cookie='oamkcookiet=kaikki")]
${CHATBOT_PROMPT}    xpath://iframe[contains(@class, 'ld-chat-bot') and @title='Leadoo chatbotin käynnistin']
${CHATBOT_OPENED}    xpath://div[@class='chat' and @id='root']
${CHATBOT_FRAME}     xpath://iframe[@title='Leadoo chatbotin käynnistin']



*** Test Cases ***
Chatbot icon should be visible on the website
    Open the website and maximize window
    Click Element    ${ACCEPT_COOKIES}
    Sleep    3
    Element Should Be Visible    ${CHATBOT_PROMPT}
    Close Browser

Chatbot should open
    Open the website and maximize window
    Click Element    ${ACCEPT_COOKIES}
    Sleep    3
    Select Frame    ${CHATBOT_FRAME}
    Click Element    ${CHATBOT_BUTTON}
    Element Should Be Visible    ${CHATBOT_OPENED}
    Close Browser

Test chatbot for finding information
    Open the website and maximize window
    Set Selenium Implicit Wait    5
    Click Element    ${ACCEPT_COOKIES}
    Select Frame    ${CHATBOT_FRAME}
    Click Element    ${CHATBOT_BUTTON}
    Unselect Frame
    Select Frame    //iframe[@class='ld-chat-bot ld-chat-window' and @title='Leadoon chatbotti-ikkuna']
    Find opinto-opas
    Switch to new window and assert title
    Close Browser


*** Keywords ***
Open the website and maximize window
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option("excludeSwitches", ["enable-logging"])
    Maximize Browser Window

Find opinto-opas
    Click Element    xpath://button[contains(@class, 'ld-button') and contains(@class, 'shadow') and .//strong[contains(text(), 'Opiskelijalle')]]
    sleep    4
    Click Element    xpath://button[@class='ld-button shadow' and div[contains(text(), 'Opinto-opas')]]
    sleep    4
    Click Element    xpath://button[@class='ld-button shadow' and div[contains(text(), 'Siirry opinto-oppaaseen')]]
    sleep    4

Switch to new window and assert title
    ${window_handles} =    Get Window Handles
    Switch Window    ${window_handles}[1]
    ${title} =    Get Title
    Should Be Equal As Strings    ${title}    Oulun ammattikorkeakoulu :: Opinto-opas

