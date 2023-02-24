@DeleteAll-License
Feature: Test cases covering delete all license validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/license-management'
    * print hostUrl
    * url hostUrl
    * def dbObj = Java.type('utility.DBConnector')
    * def deleteAllProjects = new dbObj().clearAllLicense();

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/all-licenses' with method DELETE
    Given path  '/create-license'
    * def CreateLicensePayload = read('classpath:payload/CreateNewLicense_Request.json')
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == 201
    And path '/all-licenses'
    And method DELETE
    Then print response
    And match responseStatus == 200
    And match response == 'All licenses deleted'
