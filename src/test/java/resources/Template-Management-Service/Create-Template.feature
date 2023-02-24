@Create-Template
Feature: Test cases covering template management call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/template-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/template with method POST'
    Given path  '/template'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateTemplatePayload = read('classpath:payload/CreateTemplate_Request.json')
    * print emailObj
    * print email
    * print CreateTemplatePayload
    When request CreateTemplatePayload
    And method POST
    Then print response
    And status 201
    * def createdId = response.id
    * print createdId
    And match response == read('classpath:payload/CreateTemplate_Response.json')
    * def getIdCall = call read('Get-Template.feature') {createdId: "#(createdId)"}
    * def updateIdCall = call read('Update-Template.feature') {createdId: "#(createdId)"}
    * def deleteIdCall = call read('Delete-Template.feature') {createdId: "#(createdId)"}

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/template' with method POST
    Given path  '/template'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateTemplatePayload = read('classpath:payload/CreateTemplate_Request.json')
    And request CreateTemplatePayload
    And method POST
    Then print response
    And status 201
    And copy responseCopy = response
    And print response.id
    And match response == read('classpath:payload/CreateTemplate_Response.json')

  @InvalidEndPoint
  Scenario: Validate when front end developer utilise template with invalid endpoint
    Given path  '/templates'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateTemplatePayload = read('classpath:payload/CreateTemplate_Request.json')
    And request CreateTemplatePayload
    And method POST
    Then print response
    And match response.status == null

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise template with null or empty values
    Given path  '/template'
    And request {"title" : <title>,"about" : <about>,"keywords" : <keywords>,"createdBy" : <createdBy>,"brief" : <brief>,"status" : <status>}
    And method POST
    Then print response
    And assert response.status == 500 || response.status == 'BAD_REQUEST'
    Examples: 
      | title               | about    | keywords    | createdBy           | brief       | status      |
      | Test-Template       | API-Test | API-Testing | testmail.@gmail.com | brief-Intro | ACTIVATED   |
      | Test-Template       | null     | API-Testing | testmail.@gmail.com | brief-Intro | ACTIVATED   |
      | Test-Template       | API-Test | null        | testmail.@gmail.com | brief-Intro | ACTIVATED   |
      | Test-Template       | API-Test | API-Testing | null                | brief-Intro | ACTIVATED   |
      | Test-Template       | API-Test | API-Testing | testmail.@gmail.com | null        | ACTIVATED   |
      | Test-Template       | API-Test | API-Testing | testmail.@gmail.com | brief-Intro | null        |
      | null                | null     | null        | null                | null        | null        |
      | ''                  | API-Test | API-Testing | testmail.@gmail.com | brief-Intro | ACTIVATED   |
      | Test-Template       | ''       | API-Testing | testmail.@gmail.com | brief-Intro | ACTIVATED   |
      | Test-Template       | API-Test | " "          | testmail.@gmail.com | brief-Intro | ACTIVATED  |
      | Test-Template       | API-Test | API-Testing | ''                  | brief-Intro | ACTIVATED   |
      | Test-Template       | API-Test | API-Testing | testmail.@gmail.com | ''          | ACTIVATED   |
      | Test-Template       | API-Test | API-Testing | testmail.@gmail.com | brief-Intro | ''          |
      | ''                  | ''       | ''          | ''                  | ''          | ''          |
      
      
