@postRequestFeature
Feature: Post Request

  Background: Test Base
    Given url baseUrl

    @loginCaller
    Scenario: login scenario
    And path 'users/login'
    And header Content-Type = 'application/json'
    When request {"user":{"email":#(email),"password":#(password)}}
      Then method POST
    And status 200
      * def token = response.user.token
    * print 'TOKEN: ', token

  @smoke
  Scenario: post request
    * def tokenResponse = call read('classpath:features/conduit/PostRequest3.feature@loginCaller') {"email":"alicanozsoy11@gmail.com","password":"fenerbahce"}
    * def authToken = tokenResponse.token
    # * def token2 = tokenResponse.response.user.token
    * print authToken
    Given header Authorization = 'Token ' + authToken
    And path 'articles'
    And request {"article":{"title":"test title123456","description":"test","body":"karate api test","tagList":""}}
    When method POST
    And status 200
    * print  response