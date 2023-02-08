@Project-Detail-ByID
Feature: Test cases covering project details by id validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/project-management'
    * print hostUrl
    * url hostUrl
    * def dbObj = Java.type('utility.DBConnector')
    * def deleteAllProjects = new dbObj().clearAllProjects();

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/projects' with method GET
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path '/projects'
    And param ids = response.id
    And method GET
    Then print response
    And match responseStatus == 200

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/projects' with method GET
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path '/projects'
    And param ids = response.id
    And method GET
    Then print response
    And match responseStatus == 200
    And match response == read('classpath:payload/ProjectDetailById_Response.json')

  @InvalidEndPoint
  Scenario: Validate schema when front end developer utilise the api with invalid endpoint
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path '/projjects'
    And param ids = response.id
    And method GET
    Then print response
    And match responseStatus == 404

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise the endpoint - '/projects' with null or empty params and method GET
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path '/projects'
    And param ids = <id>
    And method GET
    Then print response
    And match responseStatus == <Status>

    Examples: 
      | id   | Status |
      | null |    400 |
      | ""   |    200 |
