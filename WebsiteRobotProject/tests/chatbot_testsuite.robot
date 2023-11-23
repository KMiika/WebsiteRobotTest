*** Settings ***
Library    SeleniumLibrary
Variables    C:/temp/WebsiteRobotProject/resources/Variables.py
Resource    C:/temp/WebsiteRobotProject/resources/Keywords.robot

*** Variables ***
${CHATBOT_BUTTON}          xpath://button[contains(@class, 'ld-launch-btn')]
${ACCEPT_COOKIES}          xpath://button[contains(@onclick, "document.cookie='oamkcookiet=kaikki")]
${CHATBOT_OPENED}          xpath://div[@class='chat' and @id='root']
${CHATBOT_BUTTON_FRAME}    xpath://iframe[@title='Leadoo chatbotin käynnistin']
${CHATBOT_WINDOW_FRAME}    xpath://iframe[@class='ld-chat-bot ld-chat-window' and @title='Leadoon chatbotti-ikkuna']

*** Test Cases ***
Chatbot icon should be visible on the website
    Open the website and maximize window
    Click Element    ${ACCEPT_COOKIES}
    Sleep    3
    Element Should Be Visible    ${CHATBOT_BUTTON_FRAME}
    Close Browser

Chatbot should open
    Open the website and maximize window
    Click Element    ${ACCEPT_COOKIES}
    Sleep    3      # Wait for chatbot feature to load
    Select Frame    ${CHATBOT_BUTTON_FRAME}
    Click Element    ${CHATBOT_BUTTON}
    Unselect Frame
    Element Should Be Visible    ${CHATBOT_WINDOW_FRAME}
    Close Browser

Test chatbot for finding information
    Open the website and maximize window
    Set Selenium Implicit Wait    5
    Click Element    ${ACCEPT_COOKIES}
    Select Frame    ${CHATBOT_BUTTON_FRAME}
    Click Element    ${CHATBOT_BUTTON}
    Unselect Frame
    Select Frame    ${CHATBOT_WINDOW_FRAME}
    Find opinto-opas
    Switch to new window and check title
    Close Browser

Chatbot leave question feature should not accept empty question
    Open the website and maximize window
    Set Selenium Implicit Wait    10
    Click Element    ${ACCEPT_COOKIES}
    Select Frame    ${CHATBOT_BUTTON_FRAME}
    Click Element    ${CHATBOT_BUTTON}
    Unselect Frame
    Select Frame    ${CHATBOT_WINDOW_FRAME}
    Test empty question
    Close Browser


*** Keywords ***
Find opinto-opas
    Click Element    xpath://button[contains(@class, 'ld-button') and contains(@class, 'shadow') and .//strong[contains(text(), 'Opiskelijalle')]]
    sleep    4
    Click Element    xpath://button[@class='ld-button shadow' and div[contains(text(), 'Opinto-opas')]]
    sleep    4
    Click Element    xpath://button[@class='ld-button shadow' and div[contains(text(), 'Siirry opinto-oppaaseen')]]
    sleep    4

Switch to new window and check title
    ${window_handles} =    Get Window Handles
    Switch Window    ${window_handles}[1]
    Title Should Be    Oulun ammattikorkeakoulu :: Opinto-opas
    
Test empty question
    Click Element                xpath://button[contains(@class, 'ld-button') and contains(@class, 'shadow') and descendant::div[contains(text(), 'Opiskelijatarinat')]]
    ${window_handles} =          Get Window Handles
    Switch Window                ${window_handles}[0]
    Select Frame                 ${CHATBOT_WINDOW_FRAME}
    Sleep    4
    Click Element                xpath://button[contains(@class, 'ld-button') and contains(@class, 'shadow') and descendant::div[contains(text(), 'Jätä kysymys')]]
    Sleep    4
    Click Element                xpath://button[contains(@class, 'ld-button') and contains(@class, 'shadow') and contains(@class, 'ld-submit') and contains(@class, 'ld-input-btn') and contains(@class, 'ld-multiline')]
    Element Should Be Visible    xpath://span[@class='ld-validation-err with-button' and text()='Viesti ei voi olla tyhjä']




