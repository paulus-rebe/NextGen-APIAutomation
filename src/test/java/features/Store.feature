@MyStore
Feature: Collections of MyStore Application

  @CreateSingleUser
  Scenario: Create Single User
    Given url StoreBaseURL
    * def query = {"id":11,"username":"Jack123","firstName":"Jack","lastName":"Sparrow","email":"jacksparrow@gmail.com","password":"Jack@1234","phone":"9003061057","userStatus":0}
    And request query
    * match query == {id:'#number',"username":"#string","firstName":"#string","lastName":"#string","email":"#string","password":"#string","phone":"#string","userStatus":'#number'}
    And method POST
    Then print response
    And match response.code == 200
    And match response.message == '#string'
    And match response.type == '#present'

  @CreateMultipleUser-JSON
  Scenario: Create Multiple Users using json array
    Given url StoreBaseURL
    And path '/createWithArray'
    * def userdata = read('classpath:data/userdata.json')
    And request userdata
    And method POST
    Then print response
    And match response.code == 200
    And match response.type == '#notnull'
