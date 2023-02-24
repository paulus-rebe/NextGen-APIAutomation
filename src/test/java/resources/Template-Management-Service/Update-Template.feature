@Update-Template
Feature: Test cases covering template management call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/template-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/template' with method POST
    Given path  '/template'
    * def UpdateTemplatePayload = read('classpath:payload/UpdateTemplate_Request.json')
    When request UpdateTemplatePayload
    And method PUT
    Then print response
    And status 200
    And match response == read('classpath:payload/UpdateTemplate_Response.json')
    And match response.status == 'DRAFT'

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/template' with method POST
    Given path  '/template'
    * def UpdateTemplatePayload = read('classpath:payload/UpdateTemplate_Request.json')
    When request UpdateTemplatePayload
    * print 'createdIdVar:',UpdateTemplatePayload.id
    And method PUT
    Then print response
    And status 200
    And match response == read('classpath:payload/UpdateTemplate_Response.json')

  @InvalidEndPoint
  Scenario: Validate when front end developer utilise template with invalid endpoint
    Given path  '/templates'
    * def UpdateTemplatePayload = read('classpath:payload/CreateTemplate_Request.json')
    And request UpdateTemplatePayload
    And method PUT
    Then print response
    And assert response.status == null