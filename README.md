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

![Encryption is important](https://github.com/the-kool-sk/secure_shared_preferences/blob/main/encrypt_image.jpeg  "Just hide it!")

[![pub points](https://badges.bar/secure_shared_preferences/pub%20points)](https://pub.dev/packages/secure_shared_preferences/score)
[![Pub](https://img.shields.io/pub/v/secure_shared_preferences)](https://pub.dev/packages/secure_shared_preferences)
## Features

- Simple to use yet powerful package to encypt shared preferences in android and UserDefaults in iOS.
- You have an option to by pass encryption just by passing a ```bool```.
- Supports ```String, int, bool, double, map and List<String>```.
- Uses advance ```AES-CBC-128``` algorithm for encryption.
- Encrypts both key and value.
- Integration unit tests available [here](./example/integration_test/app_test.dart)

## Getting started

1. add dependency in ``` pubspec.yaml``` file ```secure_shared_preferences:0.0.4```
2. add import  ```import 'package:secure_shared_preferences/secure_shared_preferences.dart';```

## Usage
1. To save string data type to secure storage.
```dart
    var pref = await SecureSharedPref.getInstance();
    pref.putString("Key", "This is data I want to save to local storage", isEncrypted : true);
```
1. To get string data type to secure storage.
```dart
    var pref = await SecureSharedPref.getInstance();
    pref.getString("Key", isEncrypted : true);
```

## Additional information
#### Encryption flow chart
![FlowChart](https://github.com/the-kool-sk/secure_shared_preferences/blob/main/flow_chart.png)
#### Usage
1. Save :
```
    var pref = await SecureSharedPref.getInstance();
    await pref.putString("StringEncrypted", "This is my first string test",isEncrypted: true);
    await pref.putInt("key", 100, isEncrypted: true);
    await pref.putMap("mapKey", {"Hello":true}, isEncrypted: true);
    await pref.putDouble("doubleKey", 20.32, isEncrypted: true);
    await pref.putBool("boolKey", true,isEncrypted:  true);
    await pref.putStringList("listKey", ["S","K"], isEncrypted: true);
```
First parameter is the 'key'
Second parameter is the value
Third parameter is whether you want to encrypt this key/value or not.

2. Fetch :
```
    var pref = await SecureSharedPref.getInstance();
    await pref.getString("StringEncrypted", isEncrypted: true);
    await pref.getInt("key", isEncrypted: true);
    await pref.getMap("mapKey", isEncrypted: true);
    await pref.getDouble("doubleKey", isEncrypted: true);
    await pref.getBool("boolKey",isEncrypted: true);
    await pref.getStringList("listKey", isEncrypted: true);
```
First parameter is the 'key'
Second parameter is whether you have encrypted this key/value or not.


