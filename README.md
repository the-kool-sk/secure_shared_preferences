<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features
![Encryption is important](./encrypt_image.jpeg  "Just hide it!")

- Simple to use yet powerful package to encypt shared preferences in android and UserDefaults in iOS.
- You have an option to by pass encryption just by passing a ```bool```.

## Getting started

1. add dependency in ``` pubspec.yaml``` file ```secure_shared_preferences:0.0.1-beta```
2. add import  ```import 'package:secure_shared_preferences/secure_shared_preferences.dart';```

## Usage
1. To save string data type to secure storage.
```dart
    var pref = await SecureSharedPref.getInstance();
    pref.putString("Key", "This is data I want to save to local storage", true);
```
1. To get string data type to secure storage.
```dart
    var pref = await SecureSharedPref.getInstance();
    pref.getString("Key", true);
```

## Additional information
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
