@apiTest
Feature: Gestion de Personajes y Planetas de Dragon Ball

  # Configuración globales para todas las pruebas de esta funcionalidad.
  Background:
    * url urlBase
    * def commonHeaders = karate.read('classpath:co/com/jesteban/dragon-ball/data/headers.json')
    * def expectedGokuResponse = karate.read('classpath:co/com/jesteban/dragon-ball/data/expected-goku-response.json')
    * def expectedCharacterResponse = karate.read('classpath:co/com/jesteban/dragon-ball/data/expected-character-response.json')
    * def expectedPlanetError = karate.read('classpath:co/com/jesteban/dragon-ball/error/body-planet-error.json')

  @CheckCharacterDetailById
  Scenario: Validar detalles del personaje Goku por ID y sus campos obligatorios
    # Preparamos la solicitud para obtener a Goku.
    Given path 'characters/1'
    And headers commonHeaders

    # Enviamos la solicitud.
    When method GET

    # Verificamos que la respuesta sea exitosa y contenga la información esperada de Goku y su planeta.
    Then status 200
    And match response == expectedGokuResponse
    And match response.name == 'Goku'
    And match response.race == 'Saiyan'
    And match response.originPlanet.id == 3
    And match response.originPlanet.name == 'Vegeta'
    And match response.originPlanet.isDestroyed == true


  @GetAllCharacterThenCheckOneById
  Scenario: Obtener una lista de personajes paginada y luego consultar un personaje específico con su transformacion
    # Consultamos la lista de personajes con paginación.
    Given path 'characters'
    And param page = 1
    And param limit = 2
    And headers commonHeaders
    When method GET
    Then status 200
    # Validamos la estructura de la respuesta paginada y el segundo personaje.
    And match response == { items: '#array', meta: '#object', links: '#object' }
    And match response.items[1] == expectedCharacterResponse
    # Extraemos el ID del personaje para la siguiente consulta.
    * def characterId = response.items[1].id
    * print 'ID del character obtenido: ' + characterId

    # Consultamos los detalles del personaje extraído.
    Given path 'characters/' + characterId
    And headers commonHeaders
    When method GET
    Then status 200
    # Validamos que el personaje tenga transformaciones y la cantidad esperada.
    And match response contains { transformations: '#[]' }
    * def totalTransformations = response.transformations.length
    And match totalTransformations == 5

  @CheckPlanetByIdNotFound
  Scenario: Verificar que se retorna un error al buscar un planeta con un ID invalido
    # Preparamos la solicitud con un ID de planeta inexistente.
    Given path 'planets/999999999'
    And headers commonHeaders

    # Enviamos la solicitud.
    When method GET

    # Validamos que la API responda con un error esperado.
    Then status 400
    And match response == expectedPlanetError