# Blog Explorer

Blog Explorer is an engaging Flutter application that fetches and displays a list of blogs from a RESTful API. It provides users with interactive features to explore and engage with the blogs.

## Features

- Fetch and display a list of blogs from a RESTful API.
- Cache blogs locally using Hive for offline access.
- Mark blogs as favorites.
- View blog details.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter
- Android Studio or Xcode: For building and running on Android and iOS devices

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/ShahnawazDev/blog_explorer.git
    cd blog_explorer
    ```

2. Install dependencies:

    ```sh
    flutter pub get
    ```

3. Initialize Hive:

    ```sh
    flutter packages pub run build_runner build
    ```

### Running the App

#### Android

To run the app on an Android device or emulator:

```sh
flutter run --dart-define=ADMIN_SECRET=your_admin_secret_token
```

#### iOS

To run the app on an iOS device or simulator:

```sh
flutter run --dart-define=ADMIN_SECRET=your_admin_secret_token
```

### Building the App

#### Android

To build the APK for Android:

```sh
flutter build apk --dart-define=ADMIN_SECRET=your_admin_secret_token
```

#### iOS

To build the app for iOS:

```sh
flutter build ios --dart-define=ADMIN_SECRET=your_admin_secret_token
```

## Project Structure

```
lib
|   app.dart
|   firebase_options.dart
|   main.dart
|   
+---blocs
|   +---auth_bloc
|   |       auth_bloc.dart
|   |       auth_event.dart
|   |       auth_state.dart
|   |       
|   \---blog_bloc
|           blog_bloc.dart
|           blog_event.dart
|           blog_state.dart
|           
+---cubits
|       theme_cubit.dart
|       
+---models
|       blog_model.dart
|       blog_model.g.dart
|       user_model.dart
|       
+---repositories
|       auth_repository.dart
|       blog_repository.dart
|       
+---screens
|   +---auth
|   |       login_screen.dart
|   |       signup_screen.dart
|   |       splash_screen.dart
|   |       
|   \---blog
|           blog_detail_screen.dart
|           blog_list_screen.dart
|           
+---services
|       auth_service.dart
|       blog_service.dart
|       
\---widgets
        blog_item.dart
        
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter
- Hive
- Bloc
- Firebase

---

Feel free to contribute to this project by submitting issues or pull requests. Happy coding!