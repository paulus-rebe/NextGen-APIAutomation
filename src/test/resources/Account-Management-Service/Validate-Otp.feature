@Validate-Otp
Feature: Test cases covering get otp call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/account-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/validate-otp' with method GET
    Given path  '/get-otp'
    * def emailObj = Java.type('utility.Utilities')
    * def emailGenerated = new emailObj().createRandomEmail();
    And param email = emailGenerated
    And method GET
    Then print response
    * def otpRetrieved = response.data
    And path '/validate-otp'
    And request {  "otp": "#(otpRetrieved)","email": "#(emailGenerated)"}
    And method POST
    Then print response
    Then assert responseStatus == 200

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/validate-otp' with method GET
    Given path  '/get-otp'
    * def emailObj = Java.type('utility.Utilities')
    * def emailGenerated = new emailObj().createRandomEmail();
    And param email = emailGenerated
    And method GET
    Then print response
    * def otpRetrieved = response.data
    And path '/validate-otp'
    And request {  "otp": "#(otpRetrieved)","email": "#(emailGenerated)"}
    And method POST
    Then print response
    Then assert responseStatus == 200
    And match response == read('classpath:payload/ValidateOTP_Response.json')

  @InvalidEndPoint
  Scenario: Validate schema when front end developer utilise the endpoint - '/validate-otp' with method GET
    Given path  '/get-otp'
    * def emailObj = Java.type('utility.Utilities')
    * def emailGenerated = new emailObj().createRandomEmail();
    And param email = emailGenerated
    And method GET
    Then print response
    * def otpRetrieved = response.data
    And path '/validatee-otp'
    And request {  "otp": "#(otpRetrieved)","email": "#(emailGenerated)"}
    And method POST
    Then print response
    Then assert responseStatus == 404

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise '/validate-otp'  with null or empty values
    Given path '/validate-otp'
    And request {  "otp": <otp>,"email": <email>}
    And method POST
    Then print response

    Examples: 
      | otp  | email          | Status |
      | null | test@gmail.com |    400 |
      | ''   | test@gmail.com |    400 |
      | 1234 | null           |    400 |
      | 1234 | ''             |    400 |

  @BusinessValidation
  Scenario: Validate error message when front end developer enters wrong otp with endpoint - '/validate-otp' and method GET
    Given path  '/get-otp'
    * def emailObj = Java.type('utility.Utilities')
    * def emailGenerated = new emailObj().createRandomEmail();
    And param email = emailGenerated
    And method GET
    Then print response
    * def otpRetrieved = response.data
    And path '/validate-otp'
    And request {  "otp": 0001,"email": "#(emailGenerated)"}
    And method POST
    Then print response
    Then assert responseStatus == 404
    And match response == { "timestamp": "#string","status": 404,"error": "Not Found","message": "Can't find OTP in DB","path": "#string"}
