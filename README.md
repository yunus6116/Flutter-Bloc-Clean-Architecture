# Flutter Clean Architecture Bloc News App

This Flutter application follows the Clean Architecture principles and utilizes the Bloc pattern for state management. The app fetches daily news from the News API, displays them, and provides the option to save news articles to a local SQLite database.

## Architecture Overview

The project follows the Clean Architecture principles, separating the app into different layers:

- **Presentation Layer**: Contains the Flutter widgets, Blocs, and UI-related logic.
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Manages data sources such as APIs and local databases.

## State Management

The app uses the Bloc pattern for state management. Blocs are responsible for managing the application's state and business logic.

## Service Locator

The `get_it` package is used as a service locator for dependency injection. It helps manage the app's dependencies in a clean and organized way.

## API Requests

Retrofit is used for making API requests to the News API. It provides a type-safe way to interact with RESTful APIs.

## Dart Object Comparison

The `equatable` package is employed for efficient comparison of Dart objects. This is particularly useful when working with Blocs and state changes.

## Local Database

The app uses the Floor library to interact with a local SQLite database. News articles can be saved to the local database for offline access.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/yunus6116/Flutter-Bloc-Clean-Architecture.git
