@Execute
Feature: Test Feature 

  @Test1
  Scenario: Sample test
  	 * def emailObj = Java.type('utility.Utilities')
  	 * def newEmail = new emailObj().createRandomEmail();
  	 * print newEmail
  #	 * def email = 'sarthakmay31@gmail.com'
     #* def CreateMobilePayload = read('classpath:payload/CreateMobileUser_Request.json')
     #* print CreateMobilePayload