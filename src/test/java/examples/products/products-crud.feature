Feature: Obtener listado completo de productos desde la API DummyJSON

  Scenario: Consultar todos los productos disponibles
    Given url 'https://dummyjson.com'
    And path 'products'
    When method GET
    Then status 200
    * def total = response.products.length
    * assert total > 0
    And match response.products[0].title != null
    And assert response.products[0].price >= 0

  Scenario: Obtener un producto específico por ID
    Given url 'https://dummyjson.com'
    And path 'products', 1
    When method GET
    Then status 200
    And match response.id == 1
    And match response.title != null
    And assert response.price >= 0

  Scenario: Crear un nuevo producto
    Given url 'https://dummyjson.com'
    And path 'products', 'add'
    And request
      """
      {
        "title": "Auriculares Bluetooth",
        "description": "Auriculares inalámbricos con cancelación de ruido",
        "price": 49
      }
      """
    When method POST
    Then status 201
    And match response.title == "Auriculares Bluetooth"
    And match response.description contains "cancelación"
    And assert response.price == 49
    And assert response.id != null

  Scenario: Actualizar un producto existente
    Given url 'https://dummyjson.com'
    And path 'products', 1
    And request
      """
      {
        "title": "Nuevo nombre del producto",
        "price": 99
      }
      """
    When method PUT
    Then status 200
    And match response.id == 1
    And match response.title == "Nuevo nombre del producto"
    And assert response.price == 99

  Scenario: Eliminar un producto por ID
    Given url 'https://dummyjson.com'
    And path 'products', 1
    When method DELETE
    Then status 200
    And match response.id == 1
    And match response.title != null
    And assert response.price >= 0
