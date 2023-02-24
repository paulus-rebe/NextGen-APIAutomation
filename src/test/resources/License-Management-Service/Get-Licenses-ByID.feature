@Get-Licenses-ByID
Feature: Test cases covering get licenses by ID validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/license-management'
    * print hostUrl
    * url hostUrl
    * def dbObj = Java.type('utility.DBConnector')
    * def deleteAllProjects = new dbObj().clearAllLicense();

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/licenses' with method GET
    Given path  '/create-license'
    * def CreateLicensePayload = read('classpath:payload/CreateNewLicense_Request.json')
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == 201
    * def idVal = response.id
    And path  '/licenses'
    And param ids = idVal
    And method GET
    Then print response
    And match responseStatus == 200
    And match response[0].id == idVal
    And match response[0].name == "automationtest"
