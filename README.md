# Pokedex Flutter App

**Pokedex Flutter App** es un proyecto de Flutter que sirve como un **Code Challenge** para Petit. Esta aplicación permite a los usuarios explorar los primeros 151 Pokémon, capturarlos y gestionar su lista de Pokémon capturados. A continuación, se describe la funcionalidad de la aplicación y la tecnología utilizada.

## Funcionalidades

### Pokedex
- **Visualización de Pokémon**: Muestra los primeros 151 Pokémon ordenados por ID.
- **Búsqueda y Filtros**: Un campo de búsqueda permite filtrar Pokémon a medida que se escribe.
- **Detalles del Pokémon**: Al hacer clic en un Pokémon, se accede a una pantalla con los detalles del Pokémon seleccionado.

### Captura de Pokémon
- **Captura**: Desde la pantalla de detalles, puedes capturar o eliminar un Pokémon.
- **Lista de Capturados**: Visualiza todos los Pokémon capturados.
- **Ordenación y Filtros**: Ordena la lista por ID, nombre, o filtra según el tipo de Pokémon.
- **Swipe to Delete**: Elimina Pokémon capturados deslizando.

### Cambio de Tema
- **Tema Dinámico**: El tema de la aplicación cambia según el tipo de Pokémon capturados. Ejemplo: Paleta roja para Pokémon de tipo fuego, verde para tipo planta, etc.

## Tecnología

- **Estado**: `Provider` para la gestión del estado.
- **Navegación**: `Go Router` para la navegación entre pantallas.
- **Peticiones HTTP**: `http` para las solicitudes de datos.
- **Persistencia de Datos**:
  - **Versión Principal**: `Hive` para la gestión local de datos en todas las plataformas.
  - **Rama Alternativa**: `Isar` para móviles y escritorio (no compatible con web en la versión actual).

## Enlaces

- **[Aplicación Web en Netlify](https://pokedex-danimtnz.netlify.app/)**
- **[APK para Android](https://drive.google.com/file/d/16ZeQo53VtZprm60j9Dv5SPdDJ3bcfdNG/view?usp=sharing)**
- **[EXE para Windows](https://drive.google.com/file/d/1wHV_xbmiH4Nu6piJm4I7kC4I9JmLHc_b/view?usp=sharing)**

## Dependencias

<details>
  <summary>Ver dependencias y versiones</summary>

  ```yaml
  name: pokedex_flutter_app
  description: "A new Flutter project."
  publish_to: 'none'
  version: 0.1.0

  environment:
    sdk: '>=3.5.0-47.0.dev <4.0.0'

  dependencies:
    cached_network_image: ^3.3.1
    flutter:
      sdk: flutter
    go_router: ^14.2.1
    hive: ^2.2.3
    hive_flutter: ^1.1.0
    http: ^1.2.1
    path_provider: ^2.1.3
    provider: ^6.1.2

  dev_dependencies:
    build_runner: ^2.4.11
    flutter_lints: ^3.0.0
    flutter_test:
      sdk: flutter
    hive_generator: ^2.0.1

  flutter:
    uses-material-design: true
