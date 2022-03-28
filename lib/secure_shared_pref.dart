import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_shared_pref_impl.dart';

class SecureSharedPref extends SuperSecureSharedPref {
  //String, int, bool, double, map, String List,

  SecureSharedPref._() : super() {
    _init();
  }

  static Future<SecureSharedPref> getInstance() async {
    var object = SecureSharedPref._();
    await object._init();
    return object;
  }

  Future<String?> getString(String key, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        return await _secureStorage?.read(key: key);
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncrypterKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                return await _decrypt(_sharedPreferences.getString(value) ?? "", keys.last);
              }
            }
          }
        } else {
          throw Exception("Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      return _sharedPreferences.getString(key);
    }
    return null;
  }

  Future<int?> getInt(String key, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        return int.tryParse(await _secureStorage?.read(key: key) ?? "0");
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          print("_isMasterKeyAvailable true}");
          var keys = await _getEncrypterKeys();
          print("_getEncrypterKeys $keys}");
          for (var value in _sharedPreferences.getKeys()) {
            print("keys $value}");
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                print("decoded $decoded}");
                return int.tryParse(await _decrypt(_sharedPreferences.getString(value) ?? "", keys.last));
              }
            }
          }
        } else {
          throw Exception("Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      return _sharedPreferences.getInt(key);
    }
    return 0;
  }

  Future<bool?> getBool(String key, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        String? result = await _secureStorage?.read(key: key);
        return result?.parseBool();
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncrypterKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (value.length >= 2 && _getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                String result = await _decrypt(_sharedPreferences.getString(value) ?? "", keys.last);
                return result.parseBool();
              }
            }
          }
        } else {
          throw Exception("Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      return _sharedPreferences.getBool(key);
    }
    return null;
  }

  Future<double?> getDouble(String key, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        String? result = await _secureStorage?.read(key: key);
        return double.tryParse(result ?? "0.0");
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncrypterKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                String result = await _decrypt(_sharedPreferences.getString(value) ?? "", keys.last);
                return double.tryParse(result);
              }
            }
          }
        } else {
          throw Exception("Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      return _sharedPreferences.getDouble(key);
    }
    return null;
  }

  Future<Map?> getMap(String key, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        String? result = await _secureStorage?.read(key: key);
        return jsonDecode(result ?? "{}");
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncrypterKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                String result = await _decrypt(_sharedPreferences.getString(value) ?? "", keys.last);
                return jsonDecode(result);
              }
            }
          }
        } else {
          throw Exception("Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      return jsonDecode(_sharedPreferences.getString(key) ?? "{}");
    }
    return null;
  }

  Future<List<String>> getStringList(String key, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        String? result = await _secureStorage?.read(key: key);
        return _getStringListFromString(result!);
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable()) {
          var keys = await _getEncrypterKeys();
          for (var value in _sharedPreferences.getKeys()) {
            if (_getIntListFromString(value).length == 16) {
              String decoded = await _decrypt(value, keys.first);
              if (decoded == key) {
                String result = await _decrypt(_sharedPreferences.getString(value) ?? "", keys.last);
                return _getStringListFromString(result);
              }
            }
          }
        } else {
          throw Exception("Failed to get data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      return _sharedPreferences.getStringList(key) ?? [];
    }
    return [];
  }

  Future<void> putString(String key, String val, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val);
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncrypterKeys();
          final algorithm = _getAlgorithm();

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[SuperSecureSharedPref.keyForKey]!), nonce: keys.first[SuperSecureSharedPref.ivForKey]);
          final encryptedValue = await algorithm.encrypt(val.codeUnits,
              secretKey: SecretKey(keys.last[SuperSecureSharedPref.keyForKey]!), nonce: keys.last[SuperSecureSharedPref.ivForKey]);
          _sharedPreferences.setString(encryptedKey.cipherText.toString(), encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() && _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(await _getMasterKeyFromKeyChain());
          putString(key, val, isEncrypted);
          //throw Exception("Failed to save data something is not correct, please report issue on github");
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      _sharedPreferences.setString(key, val);
    }
  }

  Future<void> putInt(String key, int val, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val.toString());
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncrypterKeys();
          final algorithm = _getAlgorithm();

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[SuperSecureSharedPref.keyForKey]!), nonce: keys.first[SuperSecureSharedPref.ivForKey]);
          final encryptedValue = await algorithm.encrypt(val.toString().codeUnits,
              secretKey: SecretKey(keys.last[SuperSecureSharedPref.keyForKey]!), nonce: keys.last[SuperSecureSharedPref.ivForKey]);
          print("encryptedKey.cipherText ${encryptedKey.cipherText}");
          _sharedPreferences.setString(encryptedKey.cipherText.toString(), encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() && _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(await _getMasterKeyFromKeyChain());
          putInt(key, val, isEncrypted);
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      _sharedPreferences.setInt(key, val);
    }
  }

  Future<void> putBool(String key, bool val, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val.toString());
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncrypterKeys();
          final algorithm = _getAlgorithm();

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[SuperSecureSharedPref.keyForKey]!), nonce: keys.first[SuperSecureSharedPref.ivForKey]);
          final encryptedValue = await algorithm.encrypt(val.toString().codeUnits,
              secretKey: SecretKey(keys.last[SuperSecureSharedPref.keyForKey]!), nonce: keys.last[SuperSecureSharedPref.ivForKey]);
          _sharedPreferences.setString(encryptedKey.cipherText.toString(), encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() && _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(await _getMasterKeyFromKeyChain());
          putBool(key, val, isEncrypted);
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      _sharedPreferences.setBool(key, val);
    }
  }

  Future<void> putMap(String key, Map val, bool isEncrypted) async {
    await putString(key, jsonEncode(val), isEncrypted);
  }

  Future<void> putDouble(String key, double val, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val.toString());
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncrypterKeys();
          final algorithm = _getAlgorithm();

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[SuperSecureSharedPref.keyForKey]!), nonce: keys.first[SuperSecureSharedPref.ivForKey]);
          final encryptedValue = await algorithm.encrypt(val.toString().codeUnits,
              secretKey: SecretKey(keys.last[SuperSecureSharedPref.keyForKey]!), nonce: keys.last[SuperSecureSharedPref.ivForKey]);
          _sharedPreferences.setString(encryptedKey.cipherText.toString(), encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() && _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(await _getMasterKeyFromKeyChain());
          putDouble(key, val, isEncrypted);
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      _sharedPreferences.setDouble(key, val);
    }
  }

  Future<void> putStringList(String key, List<String> val, bool isEncrypted) async {
    _assetFunction(isEncrypted);
    if (isEncrypted) {
      if (Platform.isAndroid) {
        _secureStorage?.write(key: key, value: val.toString());
      } else if (Platform.isIOS) {
        if (await _isMasterKeyAvailable() && _areSubKeysAvailable()) {
          final keys = await _getEncrypterKeys();
          final algorithm = _getAlgorithm();

          final encryptedKey = await algorithm.encrypt(key.codeUnits,
              secretKey: SecretKey(keys.first[SuperSecureSharedPref.keyForKey]!), nonce: keys.first[SuperSecureSharedPref.ivForKey]);
          final encryptedValue = await algorithm.encrypt(val.toString().codeUnits,
              secretKey: SecretKey(keys.last[SuperSecureSharedPref.keyForKey]!), nonce: keys.last[SuperSecureSharedPref.ivForKey]);
          _sharedPreferences.setString(encryptedKey.cipherText.toString(), encryptedValue.cipherText.toString());
        } else {
          if (await _isMasterKeyAvailable() && _areSubKeysAvailable() == false) {
            await _deleteMasterKey();
          }
          var masterKey = await _createMasterKey();
          await _saveMasterKeyToKeychain(masterKey);
          await _generateAndSaveKeyAndValueSubKeys(await _getMasterKeyFromKeyChain());
          putStringList(key, val, isEncrypted);
        }
      } else {
        throw PlatformException(message: "Not Supported for ${Platform.operatingSystem} platform", code: "501");
      }
    } else {
      _sharedPreferences.setStringList(key, val);
    }
  }

  Future<List<Map<String, List<int>>>> _getEncrypterKeys() async {
    List<Map<String, List<int>>> list = List.empty(growable: true);
    String keyEncrypterSubKey = await getString(_packageInfo.packageName + keyCode, false) ?? "";
    String valueEncrypterSubKey = await getString(_packageInfo.packageName + valueCode, false) ?? "";
    final intList = _getIntListFromString(keyEncrypterSubKey);
    Map<String, List<int>> keyEncrypterKeysList = {};
    keyEncrypterKeysList.putIfAbsent(SuperSecureSharedPref.ivForKey, () => intList.getRange(0, 16).toList());
    keyEncrypterKeysList.putIfAbsent(SuperSecureSharedPref.keyForKey, () => intList.getRange(16, 32).toList());
    list.add(keyEncrypterKeysList);

    final valueIntList = _getIntListFromString(valueEncrypterSubKey);
    Map<String, List<int>> valueEncrypterKeysList = {};
    valueEncrypterKeysList.putIfAbsent(SuperSecureSharedPref.ivForKey, () => valueIntList.getRange(0, 16).toList());
    valueEncrypterKeysList.putIfAbsent(SuperSecureSharedPref.keyForKey, () => valueIntList.getRange(16, 32).toList());
    list.add(valueEncrypterKeysList);
    return list;
  }
}

class SuperSecureSharedPref {
  FlutterSecureStorage? _secureStorage;
  late PackageInfo _packageInfo;
  late SharedPreferences _sharedPreferences;

  final String keyCode = "secure_shared_preferences_super_key";
  final String valueCode = "secure_shared_preferences_super_value";
  static const String keyForKey = "keyForKey";
  static const String ivForKey = "ivForKey";

  SuperSecureSharedPref() {
    PackageInfo.fromPlatform().then((value) async {
      _packageInfo = value;
      const AndroidOptions _androidOptions = AndroidOptions(encryptedSharedPreferences: true);
      final IOSOptions _iosOptions = IOSOptions(accountName: value.packageName, synchronizable: false);
      _secureStorage ??= FlutterSecureStorage(aOptions: _androidOptions, iOptions: _iosOptions);
      _init();
    });
  }

  _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  List<String> _getStringListFromString(String result) => result.substring(1, result.length - 1).split(',').toList();

  void _assetFunction(bool isEncrypted) {
    assert(Platform.isAndroid || Platform.isIOS || isEncrypted,
        throw PlatformException(message: "Encryption Not Supported for ${Platform.operatingSystem} platform", code: "501"));
  }

  AesCbc _getAlgorithm() => AesCbc.with128bits(macAlgorithm: MacAlgorithm.empty);

  List<int> _getIntListFromString(String keyEncrypterSubKey) =>
      keyEncrypterSubKey.substring(1, keyEncrypterSubKey.length - 1).split(',').map((e) => int.tryParse(e) ?? 0).toList();

  Future<String> _decrypt(String string, Map<String, List<int>> keys) async {
    final box = SecretBox(_getIntListFromString(string), nonce: keys[ivForKey]!, mac: Mac.empty);
    final secretKey = SecretKey(keys[keyForKey]!);
    final decrypted = await _getAlgorithm().decrypt(box, secretKey: secretKey);
    print("decrypted $decrypted");
    return const Utf8Decoder().convert(decrypted);
  }

  Future<bool> _isMasterKeyAvailable() async {
    return _secureStorage?.read(key: _packageInfo.packageName) != null;
  }

  Future<String> _createMasterKey() async {
    final generator = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final masterKey = String.fromCharCodes(Iterable.generate(32, (_) => _chars.codeUnitAt(generator.nextInt(_chars.length))));
    return masterKey;
  }

  _deleteMasterKey() async {
    await _secureStorage?.delete(key: _packageInfo.packageName);
  }

  _saveMasterKeyToKeychain(String masterKey) async {
    await _secureStorage?.write(key: _packageInfo.packageName, value: masterKey);
  }

  Future<String> _getMasterKeyFromKeyChain() async {
    return await _secureStorage?.read(key: _packageInfo.packageName) ?? "";
  }

  bool _areSubKeysAvailable() {
    var keyKey = _sharedPreferences.getString(_packageInfo.packageName + keyCode);
    var valueKey = _sharedPreferences.getString(_packageInfo.packageName + valueCode);
    return keyKey != null && valueKey != null;
  }

  Future<void> _generateAndSaveKeyAndValueSubKeys(String masterKey) async {
    // AES-CBC with 128 bit keys and HMAC-SHA256 authentication.
    final keyAlgorithm = AesCbc.with128bits(
      macAlgorithm: MacAlgorithm.empty,
    );
    final List<int> subKeyKey = List.empty(growable: true);
    final secretKey = await keyAlgorithm.newSecretKey();
    final nonce = keyAlgorithm.newNonce();
    final keyBytes = await secretKey.extractBytes();
    subKeyKey.addAll(nonce);
    subKeyKey.addAll(keyBytes);
    await _sharedPreferences.setString(_packageInfo.packageName + keyCode, subKeyKey.toString());

    // AES-CBC with 128 bit keys and HMAC-SHA256 authentication.
    final valueAlgorithm = AesCbc.with128bits(
      macAlgorithm: MacAlgorithm.empty,
    );
    final List<int> subKeyValue = List.empty(growable: true);
    final secretKeyValue = await valueAlgorithm.newSecretKey();
    final nonceValue = valueAlgorithm.newNonce();
    final keyBytesValue = await secretKeyValue.extractBytes();
    subKeyValue.addAll(nonceValue);
    subKeyValue.addAll(keyBytesValue);
    await _sharedPreferences.setString(_packageInfo.packageName + valueCode, subKeyValue.toString());
  }
}
