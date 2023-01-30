@ForgotPassword
Feature: Test cases covering forgot password test cases

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/account-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint -  '/forget-password' with method POST
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
    And request {"resetToken": '#(token)', "newPassword": "Pass@123"}
    Then method POST
    Then print response
    And match responseStatus ==200
    Given url 'https://qa.rvdo.link/api-gateway/api/v1/authentication/auth'
    And request {"email": '#(email)', "password": "Pass@123"}
    Then method POST
    Then print response
    And match responseStatus ==200

  @SchemaValidations
  Scenario: Validate response when front end developer utilise the endpoint -  '/forget-password' with method POST
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
    And match response == read('classpath:payload/forgetpassword_Response.json')
    * def tokenValue = response.data
    * def token = tokenValue.substring(tokenValue.indexOf("=")+1);
    * print token
    And path '/reset-password'
    And request {"resetToken": '#(token)', "newPassword": "Pass@123"}
    Then method POST
    Then print response
    And match response == read('classpath:payload/resetpassword_Response.json')

  @InvalidEndPoint
  Scenario: Validate response when front end developer utilise the endpoint -  '/forget-password' with invalid endpoint
    Given path  '/forgetpassword'
    And param email = 'donotremoveuser@gmail.com'
    And method GET
    Then print response
    And match response.status == 404

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise '/forget-password' with null or empty values
    Given path  '/forget-password'
    And param email = <email>
    And method GET
    Then print responseStatus = <Status>

    Examples: 
      | email | Status |
      | null  |    400 |
      | ''    |    400 |

  @Null&EmptyResponseValidate
  Scenario Outline: Validate when front end developer utilise '/reset-password' with null or empty values
    Given path  '/reset-password'
    And request {  "resetToken": <token>,"newPassword": <password>}
    And method POST
    Then print responseStatus = <Status>

    Examples: 
      | token             | password   | Status |
      | null              | 'Pass@123' |    400 |
      | 'email@gmail.com' | null       |    400 |
