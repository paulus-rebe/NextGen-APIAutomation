@ListProjectByUserId
Feature: Test cases covering create list user by userid with pagination validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/project-management'
    * print hostUrl
    * url hostUrl
    * def dbObj = Java.type('utility.DBConnector')
    * def deleteAllProjects = new dbObj().clearAllProjects();

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/projects/' with method GET
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path  '/projects/2c61269b-02ca-4ec7-ad7b-8acf7c35c271'
    * param pageNumber = 1
    * param numberElementInPage = 10
    And method GET
    Then print response
    And match responseStatus == 200

  @SchemaValidations
  Scenario: Validate schema when when front end developer utilise the endpoint - '/projects/' with method GET
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path  '/projects/2c61269b-02ca-4ec7-ad7b-8acf7c35c271'
    * param pageNumber = 1
    * param numberElementInPage = 10
    And method GET
    Then print response
    And match responseStatus == 200
    And match response == read('classpath:payload/ListProjectByUserIdPagination_Response.json')

  @InvalidEndPoint
  Scenario: Validate when front end developer utilise - '/projects/' with invalid endpoint
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path  '/projectsttttt/2c61269b-02ca-4ec7-ad7b-8acf7c35c271'
    * param pageNumber = 1
    * param numberElementInPage = 10
    And method GET
    Then print response
    And match responseStatus == 404

  @NullAndEmptyParamsValidation
  Scenario Outline: Validate when front end developer utilise - '/projects/' with invalid endpoint
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path  '/project/2c61269b-02ca-4ec7-ad7b-8acf7c35c271'
    * param pageNumber = <pageNumber>
    * param numberElementInPage = <numberElementInPage>
    And method GET
    Then print response
    And match responseStatus == <Status>

    Examples: 
      | pageNumber | numberElementInPage | Status |
      | null       |                  10 |    404 |
      |          1 | null                |    404 |
      | ""         |                  10 |    404 |
      |          1 | ""                  |    404 |
      | null       | null                |    404 |
      | ""         | ""                  |    404 |
