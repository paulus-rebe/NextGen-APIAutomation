@Update-ProjectStatus-ById
Feature: Test cases covering update project status by id validations

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
   	And match response.status == "active"
   	* def idVal = response.id
   	And path 'projects-status'
   	And request {"projectIds":[#(idVal)],"status":"inactive"}
   	 And method PUT
    Then print response
    And match responseStatus == 200
    And path '/projects'
    And param ids = idVal
    And method GET
    Then print response
    And match responseStatus == 200
		And match response[0].status == "inactive"