# approach_to_charge

A new Flutter project.

## Overview

This project is a Flutter application designed to demonstrate the use of Clean Architecture and TDD (Test-Driven Development). It focuses on scalability and maintainability, utilizing various libraries and patterns to achieve these goals.

## Architecture

The application follows the principles of Clean Architecture, which separates the code into different layers, each with specific responsibilities:

- **Application Layer**: Contains use cases that represent the application's business logic.
    - `call_catlist_usecase.dart`
    - `get_list_cat_error.dart`
    - `search_cat_error.dart`
  - **Domain Layer**: Contains the core business logic and entities.
      - `cat.dart`
      - `weight.dart`
  - **Infrastructure Layer**: Contains the implementation details, such as data providers and repositories.
      - **Provider**: Manages the state and business logic.
          - `home_provider.dart`
          - `home_provider_error.dart`
      - **Repository**: Handles data retrieval and manipulation.
          - `cat_http.dart`
      - **Router**: Manages navigation and routes.
          - `details_router.dart`
          - `home_router.dart`
          - `main_router.dart`
  - **Presentation Layer**: Contains the UI code.
      - **View**: Manages the visual elements of the application.
          - `home_screen.dart`
      - **Components**: Contains reusable UI components.
          - `cat_card.dart`

## Libraries Used

- **Flutter**: Framework for building the UI.
  - **Provider**: State management library.
  - **GoRouter**: Library for routing and navigation.
  - **Mockito**: For creating mock objects in tests.
  - **Flutter Test**: For writing and running unit tests.
  - **Either Dart**: For handling error and success states.

## Getting Started

### Prerequisites

Ensure you have Flutter installed on your machine. You can follow the official Flutter installation guide [here](https://docs.flutter.dev/get-started/install).

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/FrancoAlv/base_proyect_flutter.git
   ```
   2. Navigate to the project directory:
      ```sh
      cd approach_to_charge
      ```
   3. Get the dependencies:
      ```sh
      flutter pub get
      ```

### Running the Application

Run the following command to start the application:
```sh
flutter run
```

### Running Tests

To run the tests, use the following command:
```sh
flutter test
```

For generating mock files, run:
```sh
flutter pub run build_runner build
```

## Project Structure

The project is divided into the following main directories:

- **application**: Contains use cases and error handling.
  - **domain**: Contains the core business logic, entities, and repository interfaces.
  - **infrastructure**: Contains implementations of repositories, providers, and routing.
  - **presentation**: Contains UI code, including screens and components.

## Scalability

The use of Clean Architecture ensures that the project is highly maintainable and scalable. Each layer is independent and can be modified without affecting the others. The use of TDD ensures that the code is robust and less prone to bugs.

## Conclusion

This project demonstrates how to build a scalable and maintainable Flutter application using Clean Architecture and TDD. By following these principles and using the mentioned libraries, you can create a robust application that is easy to extend and maintain.

## Video Presentation

Check out the video presentation of the app on YouTube:




https://github.com/user-attachments/assets/10ba2d74-6180-4afb-b861-bcf59e3c5762




