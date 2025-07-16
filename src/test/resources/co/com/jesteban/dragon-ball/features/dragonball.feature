@acceptanceTest
Feature: As a user I want to search for Dragon Ball characters

  # Configuración esencial para todas las pruebas en este feature.
  Background:
    * url urlBase
    * def globalHeaders = karate.read('classpath:co/com/jesteban/dragon-ball/data/headers.json')
    * def bodyResponse = read('classpath:co/com/jesteban/dragon-ball/data/body-response-planet.json')
    * def bodyPlanetError = read('classpath:co/com/jesteban/dragon-ball/error/body-planet-error.json')

  Scenario: Validate the characters by id and Goku with mandatory fields
    # Solicitamos los detalles del personaje Goku por su ID.
    Given path 'characters/1'
    And headers globalHeaders
    When method get
    # Validamos que la respuesta es exitosa y contiene los campos clave de Goku y su planeta de origen.
    Then status 200
    And match response contains { name: 'Goku' }
    And match response contains { race: 'Saiyan' }
    And match response.originPlanet contains { id: 3, name: 'Vegeta', isDestroyed: true }

  Scenario: Validate the planets and get a planet by id
    # Obtenemos una lista de planetas.
    Given path 'planets'
    And headers globalHeaders
    When method get
    # Verificamos la respuesta de la lista y extraemos el ID del planeta Tierra.
    Then status 200
    And match response.items[1] contains { id: 2, name: 'Tierra', isDestroyed: false }
    * def planetId = response.items[1].id
    * print 'Planet id: ' + response.items[1].id
    # Usamos el ID para obtener los detalles específicos del planeta Tierra.
    Given path 'planets/' + planetId
    And headers globalHeaders
    When method get
    # Confirmamos que los detalles del planeta son correctos y que incluye personajes asociados.
    Then status 200
    And match response contains { id: 2, name: 'Tierra', isDestroyed: false }
    And match response contains { characters: '#[]' }

  Scenario: Get an error searching a invalid id planet
    # Intentamos buscar un planeta con un ID que no existe.
    Given path 'planets/9'
    And headers globalHeaders
    When method get
    # Verificamos que la API retorna un error esperado para la solicitud inválida.
    Then status 400
    And match response == bodyPlanetError