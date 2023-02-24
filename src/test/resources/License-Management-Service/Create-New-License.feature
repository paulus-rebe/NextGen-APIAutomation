@Create-New-License
Feature: Test cases covering create new license validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/license-management'
    * print hostUrl
    * url hostUrl
    * def dbObj = Java.type('utility.DBConnector')
    * def deleteAllProjects = new dbObj().clearAllLicense();

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/create-license' with method POST
    Given path  '/create-license'
    * def CreateLicensePayload = read('classpath:payload/CreateNewLicense_Request.json')
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == 201
    And match response.id == "#number"
    And match response.name == "automationtest"

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/create-license' with method POST
    Given path  '/create-license'
    * def CreateLicensePayload = read('classpath:payload/CreateNewLicense_Request.json')
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == 201
    And match response == read('classpath:payload/CreateNewLicense_Response.json')

  @InvalidEndPoint
  Scenario: Validate schema when front end developer utilise invalid endpoint for - '/create-license' with method POST
    Given path  '/create-licnse'
    * def CreateLicensePayload = read('classpath:payload/CreateNewLicense_Request.json')
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == 404

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise '/create-license' with null or empty values
    Given path  '/create-license'
    * def CreateLicensePayload = {"name":<name>,"status":<status>,"createdBy":<createdby>,"price":<price>,"validFrom":<validFrom>,"validUntil":<validUntil>,"licenseTypeId":<TypeId>,"licenseObject":{"objectId":<objectId>,"objectType":<ObjectType>}}
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == <responseStatus>

    Examples: 
      | name             | status      | createdby            | price | validFrom                  | validUntil                 | TypeId | objectId | ObjectType | responseStatus |
      | null             | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            400 |
      | "automationtest" | null        | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            400 |
      | "automationtest" | "AVAILABLE" | null                 |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            201 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" | null  | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            201 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | null                       | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            201 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | null                       |      1 |        0 | TEMPLATE   |            201 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" | null   |        0 | TEMPLATE   |            400 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 | null     | TEMPLATE   |            400 |
      | ''               | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            400 |
      | "automationtest" | ''          | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            400 |
      | "automationtest" | "AVAILABLE" | ''                   |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            400 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" | ''    | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            201 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | ''                         | "2024-02-23T07:33:14.483Z" |      1 |        0 | TEMPLATE   |            201 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | ''                         |      1 |        0 | TEMPLATE   |            201 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" | ''     |        0 | TEMPLATE   |            400 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 | ''       | TEMPLATE   |            400 |
      | "automationtest" | "AVAILABLE" | "autotest@gmail.com" |     0 | "2023-02-23T07:33:14.483Z" | "2024-02-23T07:33:14.483Z" |      1 |        0 | ''         |            400 |

  @BusinessValidations
  Scenario Outline: Validate object types in the payload when front end developer utilise '/create-license'
    Given path  '/create-license'
    * def CreateLicensePayload = {"name":"automationtest","status":"AVAILABLE","createdBy":"test@gmail.com","price":0,"validFrom":"2023-02-23T07:33:14.483Z","validUntil":"2027-02-23T07:33:14.483Z","licenseTypeId":1,"licenseObject":{"objectId":0,"objectType":<ObjectType>}}
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == <responseStatus>

    Examples: 
      | ObjectType  | responseStatus |
      | "TEMPLATE"  |            201 |
      | "td_object" |            201 |

  @BusinessValidations
  Scenario Outline: Validate object types in the payload when front end developer utilise '/create-license'
    Given path  '/create-license'
    * def CreateLicensePayload = {"name":"automationtest","status":"AVAILABLE","createdBy":"test@gmail.com","price":0,"validFrom":"2023-02-23T07:33:14.483Z","validUntil":"2027-02-23T07:33:14.483Z","licenseTypeId":1,"licenseObject":{"objectId":0,"objectType":<ObjectType>}}
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == <responseStatus>

    Examples: 
      | ObjectType  | responseStatus |
      | "TEMPLATE"  |            201 |
      | "td_object" |            201 |

  @BusinessValidations
  Scenario Outline: Validate license types in the payload when front end developer utilise '/create-license'
    Given path  '/create-license'
    * def CreateLicensePayload = {"name":"automationtest","status":"AVAILABLE","createdBy":"test@gmail.com","price":0,"validFrom":"2023-02-23T07:33:14.483Z","validUntil":"2027-02-23T07:33:14.483Z","licenseTypeId":<LicenseID>,"licenseObject":{"objectId":0,"objectType":"TEMPLATE"}}
    And request CreateLicensePayload
    And method POST
    Then print response
    And match responseStatus == <responseStatus>

    Examples: 
      | LicenseID | responseStatus |
      |         1 |            201 |
      |         2 |            201 |
      |         3 |            201 |
      |         4 |            201 |
      |         5 |            400 |
