*** Settings ***
Library    SeleniumLibrary

*** Variables ***

${URL}    Kuvaa varten paskaa
${BROWSER}      Kuvaa varten Sontaa


*** Keywords ***

Open the website and maximize window
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option("excludeSwitches", ["enable-logging"])
    Maximize Browser Window