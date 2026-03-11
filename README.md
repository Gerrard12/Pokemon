Aplicación Pokémon

Es una aplicación  desarrollada en Swift y UIKit que consume la API pública de Pokémon para mostrar una lista de Pokémon y sus detalles.

Funcionalidades:

- Obtener una lista de Pokémon desde la API
- Buscar Pokémon por nombre
- Ver el detalle de un Pokémon
- Carga de imágenes con cache
- Networking desacoplado mediante un cliente genérico
- Pruebas unitarias para la lógica principal de la aplicación

Arquitectura

El proyecto sigue el patrón MVVM + Coordinator + Repository, lo que permite separar responsabilidades y mejorar la mantenibilidad y testabilidad del código.

Patrones de diseño utilizados

- MVVM (Model - View - ViewModel)
- Repository Pattern
- Dependency Injection
- Async/Await
- Coordinator

Requisitos:

- iOS 15+
- Xcode 15+
- Swift 5.9+

Instalación:

- Clonar el repositorio:
git clone https://github.com/tuusuario/pokemon-ios-app.git
- Abrir el proyecto:
Pokemon.xcodeproj
- Ejecutar la aplicación en un simulador o dispositivo.

Posibles mejoras - Debido al tiempo de duració de la prueba, queda como mejora:
- Soporte para paginación.
- Implementació de Pull to Request.
- Uso de Diffable Data Source en la tabla.
- Mejor manejo de errores en la UI.
- Pruebas de snapshot para UI.
