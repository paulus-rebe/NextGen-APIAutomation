@Delete-Template
Feature: Test cases covering get template call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/template-management'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * url hostUrl
    Given path  '/template'
    * def CreateTemplatePayload = read('classpath:payload/CreateTemplate_Request.json')
    * print CreateTemplatePayload
    When request CreateTemplatePayload
    And method POST
    Then print response
    And status 201
    * def createdId = response.id

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/templates' with method DELETE
    Given path  '/templates'
    And param ids = createdId
    And method DELETE
    Then print response
    And status 200
    And print responseStatus
    And match response == 'Templates deleted'
    

  @InvalidEndPoint
  Scenario: Validate when front end developer utilise '/template' with invalid endpoint
    Given path  '/template'
    And param ids = createdId
    And method DELETE
    Then print response
    And assert response.status == null
