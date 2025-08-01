#  Proyecto Base de Karate para pruebas de integración en AcceptanceTest - REST, GraphQL, SOAP
_Karate es una herramienta de código abierto que combina la automatización de pruebas de API, simulacros , pruebas de rendimiento e incluso la automatización de la interfaz de usuario en un marco único y unificado . La sintaxis BDD popularizada por Cucumber es un lenguaje neutro y fácil incluso para los no programadores. Las afirmaciones y los informes HTML están integrados y puede ejecutar pruebas en paralelo para aumentar la velocidad._

_Si está familiarizado con Cucumber / Gherkin, la gran diferencia aquí es que no necesita escribir código extra de "pegamento" o "definiciones de pasos" de Java._

**RECOMENDACION !!!**: Visitar la documentación oficial para obtener todas las ventajas de este potencial framework: https://github.com/intuit/karate
## Comenzando

### Instalación ?

**IMPORTANTE**: Este proyecto es una demo, proyecto base, para estructurar las pruebas de integración (AcceptanceTest) que se realizarán. Este proyecto es funcional yo consume la pet-store  API en su versión 3 (https://petstore3.swagger.io/api/v3), sin embargo, a continuación te contamos que debes modificar y configurar para comenzar en tu contexto de aplicación con las pruebas:
- Ir al karate-config.js y modificar la `urlBase` por la url o endpoint de tu aplicación.
- Ir al karate-config.js y modificar la `oasUrl` por el path y nombre de la deficnicón open Api de la API a testear.
- Ir a los archivos .feature (src>test>resources>co.com.jesteban) agregar tus escenarios, métodos de prueba, aserciones, y todo lo necesario para tus pruebas en particular.


- TestParallel -> Clase general en java que ejecuta los TESTS de karate en Paralelo y tambien genera el reporte de dichos TESTS en formato json que luego se convierte en reporte cucumber

## Ejecutando las pruebas ??
Este proyecto soporta ejecución por features tageados de manera independiente, como es el caso del feature demo.feature el cual tiene el tag @acceptanceTest.

```gradle
gradlew clean test "-Dkarate.options=--tags @acceptanceTest" -i
```

De esta manera se ejecutaran todos los features con el tag @acceptanceTest.

Por otra parte, si lo que se quiere es ejecutar todos los features almacenados en el proyecto bastará con ejecura el comando

```gradle
gradlew clean test -i
```
