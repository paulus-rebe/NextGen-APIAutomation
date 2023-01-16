@Create-Mobile-User
Feature: Test cases covering create mobile user call validations

  Background: 
    * def hostUrl = 'https://qa.rvdo.link/api-gateway/api/v1/account-management'
    * print hostUrl
    * url hostUrl

  @HappyPath
  Scenario: Validate response when front end developer utilise the endpoint - '/create-mobile-user with method POST
    Given path  '/create-mobile-user'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateMobilePayload = read('classpath:payload/CreateMobileUser_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match response.message == '201 CREATED'
    And match response == read('classpath:payload/CreateMobileUser_Response.json')

  @SchemaValidations
  Scenario: Validate schema when front end developer utilise the endpoint - '/create-mobile-user' with method POST
    Given path  '/create-mobile-user'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateMobilePayload = read('classpath:payload/CreateMobileUser_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match response.message == '201 CREATED'
    And match response == read('classpath:payload/CreateMobileUser_Response.json')

  @InvalidEndPoint
  Scenario: Validate when front end developer utilise create-mobile-user with invalid endpoint
    Given path  '/create-mobile-userr'
    * def emailObj = Java.type('utility.Utilities')
    * def email = new emailObj().createRandomEmail();
    * def CreateMobilePayload = read('classpath:payload/CreateMobileUser_Request.json')
    And request CreateMobilePayload
    And method POST
    Then print response
    And match response.status == 404
  #@Null&EmptyResponseValidate
  #Scenario Outline: Validate when front end developer utilise create-mobile-user with null or empty values
    #Given path  '/create-mobile-user'
    #And request {"email" : <email>,"password" : <password>,"firstName" : <firstName>,"lastName" : <lastName>,"dob" : <dob>,"gender" : <gender>}
    #And method POST
    #Then print response
    #And match response.status == 500
#
    #Examples: 
      #| email                | password | firstName | lastName   | dob                      | gender |
      #| null                 | Test@123 | Test      | Automation | 1994-01-11T10:50:25.762Z | Male   |
      #| ABCTest2@gmail.com   | null     | Test      | Automation | 1994-01-11T10:50:25.762Z | Male   |
      #| ABCTest27@gmail.com  | Test@123 | null      | Automation | 1994-01-11T10:50:25.762Z | Male   |
      #| ABCTest28@gmail.com  | Test@123 | Test      | null       | 1994-01-11T10:50:25.762Z | Male   |
      #| ABCTest29@gmail.com  | Test@123 | Test      | Automation | null                     | Male   |
      #| ABCTest210@gmail.com | Test@123 | Test      | Automation | 1994-01-11T10:50:25.762Z | null   |
      #| null                 | null     | null      | null       | null                     | null   |
      #| ''                   | Test@123 | Test      | Automation | 1994-01-11T10:50:25.762Z | Male   |
      #| ABCTest211@gmail.com | ''       | Test      | Automation | 1994-01-11T10:50:25.762Z | Male   |
      #| ABCTest212@gmail.com | Test@123 | ''        | Automation | 1994-01-11T10:50:25.762Z | Male   |
      #| ABCTest213@gmail.com | Test@123 | Test      | ''         | 1994-01-11T10:50:25.762Z | Male   |
      #| ABCTest214@gmail.com | Test@123 | Test      | Automation | ''                       | Male   |
      #| ABCTest215@gmail.com | Test@123 | Test      | Automation | 1994-01-11T10:50:25.762Z | ''     |
      #| ''                   | ''       | ''        | ''         | ''                       | ''     |
