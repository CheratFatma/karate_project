Feature: 

  Background:
    * url 'https://api.efi-academy.com'
    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()
    * def randomEmail = faker.internet().emailAddress()

    Given path 'auth/login' 
    * def body_login = 
    """
        {
      "username": "admin",
      "password": "admin123"
    }
    """
    And request body_login
    When method post
    Then status 200

    * def token = response.accessToken
    
  @getAllEmployees
  Scenario: get all employees and then get an employe by id
    Given path 'public/employees' , 2
    When method get
    Then status 200

  @createEmployee1
  Scenario: creer un employe - public
    * url 'https://api.efi-academy.com'
    Given path 'public/employees'

    * def body_emp = 
    """
        {
      "firstName": "Alicjhjhe",
      "lastName": "Dupont",
      "email": "#(randomEmail)",
      "position": "Software Engineer",
      "salary": 55000,
      "hireDate": "2022-01-15",
      "status": "ACTIVE"
    }

    """
    And request body_emp
    When method post
    Then status 201
    * def msg_res = response.message
    * def msg_att = "Employee created."
    Then match msg_res == msg_att
    Then match response.data.firstName == body_emp.firstName

    * def id_res = response.data.id
    * def body_upd = 
    """
       {
      "firstName": "Lam"   
    }
    """
    Given path 'public/employees', id_res
    And request body_upd
    When method put
    Then status 200
    * def res = response.data.firstName

    Then match res == body_upd.firstName

    Given path 'public/employees', id_res
    And request body_upd
    When method delete
    Then status 200 
    * def res1 =  response.message
    * def res2 = "Employee "+id_res+" deleted."
    Then match res1 == res2

  @createEmployee2
  Scenario: creer un employe - api
    * url 'https://api.efi-academy.com'
    Given path 'api/employees'

    * def body_emp = 
    """
        {
      "firstName": "Alicjhjhe",
      "lastName": "Dupont",
      "email": "#(randomEmail)",
      "position": "Software Engineer",
      "salary": 55000,
      "hireDate": "2022-01-15",
      "status": "ACTIVE"
    }

    """
    And request body_emp
    * header Authorization = 'Bearer ' + token
    When method post
    Then status 201
    * def msg_res = response.message
    * def msg_att = "Employee created."
    Then match msg_res == msg_att
    Then match response.data.firstName == body_emp.firstName

    * def id_res = response.data.id
    * def body_upd = 
    """
       {
      "firstName": "Lam"   
    }
    """
    Given path 'api/employees', id_res
    And request body_upd
    * header Authorization = 'Bearer ' + token

    When method put
    Then status 200
    * def res = response.data.firstName

    Then match res == body_upd.firstName

    Given path 'public/employees', id_res
    And request body_upd
    * header Authorization = 'Bearer ' + token 
    When method delete
    Then status 200 
    * def res1 =  response.message
    * def res2 = "Employee "+id_res+" deleted."
    Then match res1 == res2
   

   

   