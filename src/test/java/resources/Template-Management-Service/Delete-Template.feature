@Delete-Template
Feature: Test cases covering get template call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/template-management'
    * print hostUrl
    * url hostUrl

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
