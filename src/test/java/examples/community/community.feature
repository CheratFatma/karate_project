Feature: 

  Background:
    * url 'https://preprod.thrundrz.fr/backendpublic/public/api'
    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()

    * def titre = faker.book.title()
    * def contenu = faker.lorem.sentence()

    #1
    Given path 'v1/login/client' 
    * def body_login = 
    """
      {
        "email": "jeanlamia@example.com",
        "password": "motdepasse123",
        "fcm_token": "fcm_xxx"
      }
    """
    And request body_login
    When method post
    Then status 200

    * def token = response.token
    
  @community
  Scenario: 
    #2
    Given path 'v1/posts/share-event'
    * def body_event = 
    """
      {
        "even_id": 42,
        "titre": "#(titre)",
        "contenu": "#(contenu)"
      }
    """
    And request body_event
    * header Authorization = 'Bearer ' + token
    When method post
    Then status 201
    Then match response.data.titre == body_event.titre
    Then match response.data.contenu == body_event.contenu
    * def id = response.data.id

    #3
    Given path 'v1/posts',id,'comments'
     * def body_comment = 
    """
      {
      "contenu": "Super, je viens aussi !",
      "parent_id": null
      }
    """
    And request body_comment
    * header Authorization = 'Bearer ' + token

    When method post
    Then status 201
    Then match response.success == true

    #4
    Given path 'v1/posts',id,'like'
    * header Authorization = 'Bearer ' + token
    When method post
    Then status 200
    Then match response.success == true

    #5
    Given path 'v1/posts',id
    * header Authorization = 'Bearer ' + token
    When method delete
    Then status 200
    Then match response.success == true
    Then match response.message == "Publication supprimée"





 
   
  

    



  

  

  

  

   

   