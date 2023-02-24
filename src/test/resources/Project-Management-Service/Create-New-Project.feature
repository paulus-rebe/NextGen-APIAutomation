@Create-New-Project
Feature: Test cases covering create create new project validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/project-management'
    * print hostUrl
    * url hostUrl
    * def dbObj = Java.type('utility.DBConnector')
    * def deleteAllProjects = new dbObj().clearAllProjects();

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/project' with method POST
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And match response.id == "#number"

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/project' with method POST
    Given path  '/project'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == 200
    And match response == read('classpath:payload/CreateNewProject_Response.json')

  @InvalidEndPoint
  Scenario: Validate schema when front end developer utilise create new project with invalid endpoint
    Given path  '/projecttt'
    * def CreateMobilePayload = read('classpath:payload/CreateNewProject_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match response.status == 404

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise '/reset-password' with null or empty values
    Given path  '/project'
    * def CreateMobilePayload = {"email":<email>,"userId":<userId>,"name":<name>,"title":<title>,"description":<description>,"status":<status>,"templateIds":[<templateId>]}
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == <responseStatus>

    Examples: 
      | email                       | userId                                 | name   | title   | description   | status   | templateId | responseStatus |
      | null                        | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | "title" | "description" | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | null                                   | "name" | "title" | "description" | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | null   | "title" | "description" | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | null    | "description" | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | "title" | null          | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | "title" | "description" | null     |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | "title" | "description" | "active" | null       |            500 |
      | ""                          | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | "title" | "description" | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | ""                                     | "name" | "title" | "description" | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | ""     | "title" | "description" | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | ""      | "description" | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | "title" | ""            | "active" |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | "title" | "description" | ""       |          9 |            200 |
      | "donotremoveuser@gmail.com" | "2c61269b-02ca-4ec7-ad7b-8acf7c35c271" | "name" | "title" | "description" | "active" | ""         |            500 |
      | null                        | null                                   | null   | null    | null          | null     | null       |            500 |
      | ""                          | ""                                     | ""     | ""      | ""            | ""       | ""         |            500 |

  @BusinessValidations
  Scenario Outline: Validate status value in the payload when front end developer utilise '/reset-password'
    Given path  '/project'
    * def CreateMobilePayload = {"email":"donotremoveuser@gmail.com","userId":"2c61269b-02ca-4ec7-ad7b-8acf7c35c271","name":"Name","title":"title","description":"description","status":<status>,"templateIds":[9]}
    And request CreateMobilePayload
    And method POST
    Then print response
    And match responseStatus == <responseStatus>

    Examples: 
      | status     | responseStatus |
      | "active"   |            200 |
      | "inactive" |            200 |
      | "#$$@@"    |            200 |
      | "12211"    |            200 |
