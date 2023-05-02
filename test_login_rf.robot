*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}      https://scouts-test.futbolkolektyw.pl/en
${BROWSER}        Chrome
${SIGNINBUTTON}     xpath=//*[(text()= 'Sign in')]
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
${SIGNOUTBUTTON}          xpath=//ul[2]//div[@role='button'][2]
${LOGINFORM}               xpath=//*[@id='__next']/form
${CHANGELANGUAGEBUTTON}   xpath=//ul[2]//div[@role='button'][1]
${MAINPAGE}           xpath=//ul[1]//div[@role='button'][1]
${ADD PLAYER BUTTON}            xpath=//a[contains(@href,'add')]
${FORM TITLE}                   xpath=//form//*[contains(@class, 'h5')]
${PLAYER NAME FIELD}            xpath=//input[@name='name']
${PLAYER SURNAME FIELD}         xpath=//input[@name='surname']
${PLAYER AGE FIELD}             xpath=//input[@name='age']
${PLAYER MAIN POSITION FIELD}   xpath=//input[@name='mainPosition']
${PROGRESS BAR TOASTER}         xpath=//*[@role='alert']
${PLAYERS BUTTON}               xpath=//ul[1]//div[@role='button'][2]


*** Test Cases ***
Log in to the system
     Open login page
     Type in email
     Type in password
     Click on the Submit button
     Assert dashboard
     [Teardown]    Close Browser

Log out from the system
    Open login page
    Type In email
    Type in password
    Click on the Sign in button
    Click on the Sign out button
    Assert Login page
    [Teardown]    Close Browser

Change language
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Click on the Change language button
    Assert language change
    [Teardown]    Close Browser

Click players button
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Click On The Players button
    Assert Players Page
    [Teardown]    Close Browser

Add new player
    Open login page
    Type in email
    Type in password
    Click on the Sign in button
    Click on the Add player button
    Type in name
    Type in surname
    Type in age
    Type in main position
    Click on the Submit button
    Assert edit page
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}    Test-1234
Click on the Submit button
    Click Element    xpath=//*[@id="__next"]/div[1]/main/div[2]/form/div[3]/button[1]/span[1]
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be    Scouts panel
    Capture Page Screenshot    alert.png
Click on the Sign in button
    Click Element    ${SIGNINBUTTON}
Click on the Sign out button
    Wait Until Element Is Visible    ${SIGN OUT BUTTON}
    Click Element    ${SIGNOUTBUTTON}
Assert login page
    Wait Until Element Is Visible    ${LOGINFORM}
    Title Should Be     Scouts panel - sign in
    Capture Page Screenshot    alert_login_page.png
Click on the Change language button
    Wait Until Element Is Visible    ${MAINPAGE}
    Click Element    ${CHANGELANGUAGEBUTTON}
Assert language change
    Element Text Should Be      ${CHANGELANGUAGEBUTTON}     English
    Capture Page Screenshot     alert_change_language.png
Click on the Add player button
    Wait Until Element Is Visible       ${MAINPAGE}
    Click Element    ${ADD PLAYER BUTTON}
Click on the Players button
    Wait Until Element Is Visible    ${MAINPAGE}
    Click Element   xpath=//ul[1]//div[@role='button'][2]
Assert players page
    Title Should Be    Players (3543) page 1
    Capture Page Screenshot    alert_players.png
Type in name
    Wait Until Element Is Visible       ${FORM TITLE}
    Input Text      ${PLAYER NAME FIELD}    Marek
Type in surname
    Input Text      ${PLAYER SURNAME FIELD}     Nowak
Type in age
    Input Text      ${PLAYER AGE FIELD}     21/04/1997
Type in main position
    Input Text      ${PLAYER MAIN POSITION FIELD}       Forward
Assert edit page
    Wait Until Element Is Visible    ${PROGRESS BAR TOASTER}
    Element Should Contain      ${FORM TITLE}   Edit player
    Capture Page Screenshot    alert_add-player.png