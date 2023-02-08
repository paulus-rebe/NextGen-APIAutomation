@Permanently-Delete-Projects
Feature: Test cases covering permanently delete projects validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/project-management'
    * print hostUrl
    * url hostUrl
    * def dbObj = Java.type('utility.DBConnector')
    * def deleteAllProjects = new dbObj().clearAllProjects();

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/projects' with method DELETE
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And path '/projects'
    * def idVal = response.id 
    And param ids = response.id
    And method GET
    Then print response
    And match responseStatus == 200
    And path '/projects'
    And request [#(idVal)]
    And method DELETE
    And print karate.prevRequest
    Then print response
    And match responseStatus == 204
    And path '/projects'
    And param ids = idVal
    And method GET
    Then match response == []
    
