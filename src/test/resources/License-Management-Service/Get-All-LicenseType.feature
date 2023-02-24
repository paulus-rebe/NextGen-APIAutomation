@Get-All-LicenseType
Feature: Test cases covering get all licenses type validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/license-management'
    * print hostUrl
    * url hostUrl
    * def dbObj = Java.type('utility.DBConnector')
    * def deleteAllProjects = new dbObj().clearAllLicense();

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/license-types' with method GET
    Given path  '/license-types'
    And param sortField = 'ID'
    And param ascending = true
    And method GET
    Then print response
    And match responseStatus == 200

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/license-types' with method GET
    Given path  '/license-types'
    And param sortField = 'ID'
    And param ascending = true
    And method GET
    Then print response
    And match responseStatus == 200
    And match response == read('classpath:payload/GetAllLicenseType_Response.json')

  @InvalidEndPoint
  Scenario: Validate schema when front end developer utilise the invalid endpoint for - '/license-types' with method GET
    Given path  '/licenses-types'
    And param sortField = 'ID'
    And param ascending = true
    And method GET
    Then print response
    And match response.status == 404

  @BusinessValidations
  Scenario Outline: Validate business validations for sorting when front end developer utilise - '/license-types' with method GET
    Given path  '/license-types'
    * params { sortField: <Field>, ascending: <SortTrueorFalse> }
    And method GET
    Then print response
    And match responseStatus == 200

    Examples: 
      | Field           | SortTrueorFalse |
      | 'ID'            | true            |
      | 'NAME'          | true            |
      | 'DESCRIPTION'   | true            |
      | 'DISPLAY_ORDER' | true            |
      | 'ID'            | false           |
      | 'NAME'          | false           |
      | 'DESCRIPTION'   | false           |
      | 'DISPLAY_ORDER' | false           |
