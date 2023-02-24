@Get-Template
Feature: Test cases covering get template call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/template-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/template' with method GET
    Given path  '/template'
    And param id = createdId
    And method GET
    Then print response
    And status 200


  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/template' with method GET
    Given path  '/template'
    And param id = createdId
    And method GET
    And status 200
    And match response == read('classpath:payload/GetTemplate_Response.json')
    Then print response

  @InvalidEndPoint
  Scenario: Validate when front end developer utilise '/template' with invalid endpoint
    Given path  '/templates'
    And param id = createdId
    And method GET
    Then print response
    And assert response.status == 404 || response.status == 'BAD_REQUEST'
