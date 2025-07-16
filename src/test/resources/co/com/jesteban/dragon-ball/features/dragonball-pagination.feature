Feature: Validacion de Paginacion para la API de Personajes

  Scenario: Validar paginacion exitosa para la primera pagina con 2 personajes por limite
    # Preparamos la solicitud para obtener los personajes de la página 1 con un límite de 2.
    Given url 'https://dragonball-api.com/api/characters?page=1&limit=2'

    # Enviamos la solicitud para obtener los datos paginados.
    When method GET

    # Verificamos que la respuesta sea exitosa y tenga la estructura esperada de paginación.
    Then status 200
    And match response == { items: '#array', meta: '#object', links: '#object' }

    # Confirmamos que la sección 'items' es un array.
    And match response.items == '#array'

    # Validamos que la cantidad de elementos devueltos coincide con el recuento indicado en los metadatos.
    * def itemLength = response.items.length
    And match itemLength == response.meta.itemCount