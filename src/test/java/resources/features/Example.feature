Feature: Integrate Allure with Karate

  Background:
    * url baseUrl
    * header Accept = Accept
    * header Content-Type = ContentType

  @allure.label.parentSuite:Karate
  @allure.label.suite:Labels
  @allure.label.subSuite:User
  @allure.label.severity:blocker
  Scenario: Register a new user
    And path '/users/'
    And request
    """
        {
          "name" : "Joe Doe",
          "username": "Joe",
          "email" : "joe.doe@exmaple.com",
          "address": {
            "street": "Example",
            "suite": "Apt. 123",
            "city": "Lima"
          },
          "phone": '947387438',
          "website": "google.com"
        }
        """
    When method POST
    Then status 201