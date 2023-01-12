@Get-Otp
Feature: Test cases covering get otp call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/account-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/get-otp' with method GET
    Given path  '/get-otp'
    * def emailObj = Java.type('utility.Utilities')
    * def emailGenerated = new emailObj().createRandomEmail();
    And param email = emailGenerated
    And method GET
    Then print response
    And print responseStatus

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/get-otp' with method GET
    Given path  '/get-otp'
    * def emailObj = Java.type('utility.Utilities')
    * def emailGenerated = new emailObj().createRandomEmail();
    And param email = emailGenerated
    And method GET
    And match response == read('classpath:payload/GetOTP_Response.json')
    Then print response

  @InvalidEndPoint
  Scenario: Validate when front end developer utilise '/get-otp' with invalid endpoint
    Given path  '/get-otpp'
    * def emailObj = Java.type('utility.Utilities')
    * def emailGenerated = new emailObj().createRandomEmail();
    And param email = emailGenerated
    And method GET
    Then print response
    And match response.status == 404

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise '/get-otp' with null or empty values
    Given path  '/get-otp'
    And param email = <email>
    And method GET
    Then print response
    Then print responseStatus = <Status>
    Then print response.message = <message>

    Examples: 
      | email | Status | message                             |
      | null  |    400 | "The provided email is not correct" |
      | ''    |    400 | "The provided email is not correct" |
