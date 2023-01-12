@Mobile-user-exists
Feature: Test cases covering mobile user exits call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/account-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/is-exist-email-mobile-user' with method GET
    Given path  '/create-mobile-user'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateMobilePayload = read('classpath:payload/CreateMobileUser_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match response.message == '201 CREATED'
    And path '/is-exist-email-mobile-user'
    And param email = email
    And method GET
    Then assert responseStatus == 409
    Then print responseStatus

  @SchemaValidations
  Scenario: Validate response when front end developer utilise the endpoint - '/is-exist-email-mobile-user' with method GET
    Given path  '/create-mobile-user'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateMobilePayload = read('classpath:payload/CreateMobileUser_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match response.message == '201 CREATED'
    And path '/is-exist-email-mobile-user'
    And param email = email
    And method GET
    Then print response
    And match response == read('classpath:payload/MobileUserExists_Response.json')

  @InvalidEndPoint
  Scenario: Scenario: Validate response when front end developer utilise invalid endpoint for  - '/is-exist-email-mobile-user' with method GET
    Given path  '/create-mobile-user'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateMobilePayload = read('classpath:payload/CreateMobileUser_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match response.message == '201 CREATED'
    And path '/iis-exist-email-mobile-user'
    And param email = email
    And method GET
    Then assert responseStatus == 404

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise '/is-exist-email-mobile-user'  with null or empty values
    Given path  '/is-exist-email-mobile-user'
    And param email = <email>
    And method GET
    Then print response
    Then print responseStatus = <Status>
    Then print response.message = <message>

    Examples: 
      | email | Status | message              |
      | null  |    200 | "Email is not exist" |
      | ''    |    200 | "Email is not exist" |
