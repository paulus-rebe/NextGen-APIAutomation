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
    #And request {"email" : <email>,"password" : <password>,"firstName" : <firstName>,"lastName" : <lastName>,"dob" : <dob>,"gender" : <gender>,"countryCode": <code>,"platform": <platform>,"walletAddress": <address>,"walletType": <type>}
    #And method POST
    #Then print response
    #And match responseStatus == <status>
    #And match response.errors contains [<message>]
#
    #Examples: 
      #| email                       | password   | firstName | lastName     | dob                        | gender | code | platform  | address   | type       | status | message                                                                                                                                                 |
      #| null                       | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "email: must not be blank"         |
      #| "NullEmptyTest71@gmail.com" | null       | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "password: must not be blank"      |
      #| "NullEmptyTest72@gmail.com" | "Test@123" | null      | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "firstName: must not be blank"     |
      #| "NullEmptyTest73@gmail.com" | "Test@123" | "Test"    | null         | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "lastName: must not be blank"      |
      #| "NullEmptyTest74@gmail.com" | "Test@123" | "Test"    | "Automation" | null                       | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "dob: must not be null"            |
      #| "NullEmptyTest75@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | null   | "AL" | "Android" | "address" | "Metamask" |    400 | "gender: must not be blank"        |
      #| "NullEmptyTest76@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | null | "Android" | "address" | "Metamask" |    400 | "countryCode: must not be blank"   |
      #| "NullEmptyTest77@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | null      | "address" | "Metamask" |    400 | "platform: must not be blank"      |
      #| "NullEmptyTest78@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | null      | "Metamask" |    400 | "walletAddress: must not be blank" |
      #| "NullEmptyTest79@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | null       |    400 | "walletType: must not be blank"    |
      #| ""                          | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "email: must not be blank"                                                                                                                              |
      #| "NullEmptyTest80@gmail.com" | ""         | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "password: must not be blank","password: Please provide a valid password: from 8-32 characters, include lowercase, uppercase, digit, special character"|
      #| "NullEmptyTest81@gmail.com" | "Test@123" | ""        | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "firstName: must not be blank","firstName: size must be between 1 and 100"                                                                              |
      #| "NullEmptyTest82@gmail.com" | "Test@123" | "Test"    | ""           | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "lastName: must not be blank","lastName: size must be between 1 and 100"                                                                                |
      #| "NullEmptyTest833@gmail.com" | "Test@123" | "Test"    | "Automation" | ""                         | "Male" | "AL" | "Android" | "address" | "Metamask" |    400 | "dob: must not be null"                                                                                                                                 |
      #| "NullEmptyTest84@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | ""     | "AL" | "Android" | "address" | "Metamask" |    400 | "gender: must not be blank","gender: must be any of [male, female]                                                                                      |
      #| "NullEmptyTest85@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | ""   | "Android" | "address" | "Metamask" |    400 | "Country not found. Code: "                                                                                                                             |
      #| "NullEmptyTest86@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | ""        | "address" | "Metamask" |    400 | "platform: must be any of [Android, iOS]"                                                                                                               |
      #| "NullEmptyTest87@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | ""        | "Metamask" |    400 | "walletAddress: must not be blank"                                                                                                                      |
      #| "NullEmptyTest88@gmail.com" | "Test@123" | "Test"    | "Automation" | "1994-01-11T10:50:25.762Z" | "Male" | "AL" | "Android" | "address" | ""         |    400 | "walletType: must be any of [Metamask, Phantom, -]"                                                                                                     |
