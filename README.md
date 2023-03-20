# Flutter GitHub Repositories App

This project is a Flutter app that fetches data from the GitHub API (REST) to display a list of repositories for a specified user. The user can save favorite repositories and view them on a separate screen. 

## Technologies

- flutter- to build a multi-platform  natively compiled application.
- http - to make requests to the GitHub API.
- go_routes_flow - to manage navigation between screens.
- intl - to format date
- shared_preferences - to store favorite repositories.
- provider - to manage the state of the application.
- url_launcher - to open the repository page on browser.
- google_fonts - to load custom fonts.

## Features

- State management with Provider package
- Badge widget to display the number of favorite repositories
- Unit and widget tests with flutter_test package
- Pull to refresh functionality
- Feature-first
- Error feedback to the user
- Portrait orientation support
- Favorites are stored locally
- Option to launch the GitHub page for each repository by tapping on it

## Screenshots

<div style="display: flex; flex-direction: row;">
  <img src="https://i.postimg.cc/bJzjQ78w/Screenshot-from-2023-03-17-15-15-54.png" alt="Home Screen" width="400" />
  <img src="https://i.postimg.cc/9fPhwW6k/Screenshot-from-2023-03-17-15-16-13.png" alt="Favorites Screen" width="400" />
</div>

## Architecture

I opted for the Feature-First architecture, which is an approach that puts features at the center of the application instead of focusing on layers (such as models, views, and controllers). With this approach, each feature is organized in an independent folder with its set of classes and files.

Feature-first is considered very scalable and easy to read, even for small projects like this one, and if it eventually needs to take on more responsibilities, it will be easier to adapt the abstractions by feature.

```
...
│ 
lib
├── app
│   ├── favorites
│   │   ├── widgets
│   │   ├── favorites_model.dart
│   │   ├── favorites_page.dart
│   │   ├── favorites_provider.dart
│   │   └── favorites_controller.dart
│   └── repositories
│       ├── widgets
│       ├── repositories_model.dart
│       ├── repositories_page.dart
│       └── repositories_controller.dart
├── core
│   ├── routes.dart
│   └── theme.dart
├── main.dart
│ 
...
```

## How to run

    1. Clone the repository.
    2. Open the project in your preferred IDE.
    3. Run `flutter pub get` to install the required packages.
    4. Run the app on a simulator or a physical device.

## Future improvements

- Pagination to limit the number of repositories fetched at once
- Search functionality to find repositories by name
- User authentication for accessing private repositories and extend the number of requests
- Implement cache to repositories requests, turning a local-first application
- Packaging the "core" as a library
