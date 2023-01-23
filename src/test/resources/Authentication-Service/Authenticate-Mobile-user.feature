@AuthenticateMobileUser
Feature: Test cases covering mobile user authentication test cases

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/account-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint -  '/auth' with method POST
    Given path  '/create-mobile-user'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateMobilePayload = read('classpath:payload/CreateMobileUser_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match response.message == '201 CREATED'
    And path  '/forget-password'
    And param email = email
    And method GET
    Then print response
    And match responseStatus ==200
    * def tokenValue = response.data
    * def token = tokenValue.substring(tokenValue.indexOf("=")+1);
    * print token
    And path '/reset-password'
    And request {"resetToken": '#(token)', "newPassword": "pass123"}
    Then method POST
    Then print response
    And match responseStatus ==200
    Given url 'https://qa.rvdo.link/api-gateway/api/v1/authentication/auth'
    And request {"email": '#(email)', "password": "pass123"}
    Then method POST
    Then print response
    And match responseStatus ==200

  @SchemaValidation
  Scenario: Validate response schema when front end developer utilise the endpoint -  '/auth' with method POST
    Given url 'https://qa.rvdo.link/api-gateway/api/v1/authentication/auth'
    And request { "email": "donotremoveuser@gmail.com","password": "Test@123"}
    And method POST
    Then print response
    And match response == read('classpath:payload/AuthenticateMobileUser_Response.json')

  @InvalidEndPoint
  Scenario: Validate response when front end developer utilise the endpoint -  '/auth' with invalid endpoint
    Given url 'https://qa.rvdo.link/api-gateway/api/v1/authentication/authen'
    And request { "email": "donotremoveuser@gmail.com","password": "Test@123"}
    And method POST
    Then print response
    And match response.status == 404

  @Null&EmptyResponseValidate
  Scenario Outline: Validate response schema when front end developer utilise the endpoint -  '/auth' with null or empty values
    Given url 'https://qa.rvdo.link/api-gateway/api/v1/authentication/auth'
    And request { "email": <email>,"password": <password>}
    And method POST
    Then print response
    Then print responseStatus = <Status>

    Examples: 
      | email                     | password | Status |
      | null                      | Test@123 |    400 |
      | ''                        | Test@123 |    400 |
      | donotremoveuser@gmail.com | null     |    400 |
      | donotremoveuser@gmail.com | ''       |    400 |

  @BusinessValidations
  Scenario Outline: Validate response schema when front end developer utilise the endpoint -  '/auth' with method POST
    Given url 'https://qa.rvdo.link/api-gateway/api/v1/authentication/auth'
    And request { "email": <email>,"password": <password>}
    And method POST
    Then print response
    Then print responseStatus = <Status>
    And match response.message == <message>

    Examples: 
      | email                      | password  | Status | message                        |
      | thisiswrongemail@gmail.com | Test@123  |    404 | "Can't recognise user in DB"     |
      | donotremoveuser@gmail.com  | Wrong@123 |    401 | "Provided password is incorrect" |
