import 'package:example/main.dart' as mainProgram;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';

void main() {
  //Non Encrypted => String, int, bool, double, map, String List,
  //Encrypted => String, int, bool, double, map, String List,
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  mainProgram.main();
  group('Non-Encrypted test', () {
    test('Set and Get String Data Type from normal SharedPref', () {
      SecureSharedPref.getInstance().then((value) async {
        await value.putString("StringNonEncrypted", "This is my first string test", false);
        expect(await value.getString("StringNonEncrypted", false), "This is my first string test");
      });
    });
    test('Set and Get Int Data Type from normal SharedPref', () {
      SecureSharedPref.getInstance().then((value) async {
        await value.putInt("IntNonEncrypted", 100, false);
        expect(await value.getInt("IntNonEncrypted", false), 100);
      });
    });

    test('Set and Get Boolean Data Type from normal SharedPref', () {
      SecureSharedPref.getInstance().then((value) async {
        await value.putBool("BoolNonEncrypted", false, false);
        expect(await value.getBool("BoolNonEncrypted", false), false);
      });
    });
    test('Set and Get Double Data Type from normal SharedPref', () {
      SecureSharedPref.getInstance().then((value) async {
        await value.putDouble("DoubleNonEncrypted", 0.213, false);
        expect(await value.getDouble("DoubleNonEncrypted", false), 0.213);
      });
    });
    test('Set and Get Map Data Type from normal SharedPref', () {
      SecureSharedPref.getInstance().then((value) async {
        await value.putMap("MapNonEncrypted", {"Hello": 100}, false);
        expect(await value.getMap("MapNonEncrypted", false), {"Hello": 100});
      });
    });
    test('Set and Get StringList Data Type from normal SharedPref', () {
      SecureSharedPref.getInstance().then((value) async {
        await value.putStringList("StringListNonEncrypted", ["S", "U", "R", "A", "J"], false);
        expect(await value.getStringList("StringListNonEncrypted", false), ["S", "U", "R", "A", "J"]);
      });
    });
  });
  group('Encrypted test', () {
    test('Set and Get String Data Type from encrypted SharedPref', () {
      SecureSharedPref.getInstance().then((value) {
        value.putString("StringEncrypted", "This is my first string test", true).then((value2) {
          value.getString("StringEncrypted", true).then((value3) {
            expect(value3, "This is my first string test");
          });
        });
      });
    });
    test('Set and Get Int Data Type from encrypted SharedPref', () {
      SecureSharedPref.getInstance().then((value) {
        value.putInt("IntEncrypted", 100, true).then((value2) {
          value.getInt("IntEncrypted", true).then((value3) {
            expect(value3, 100);
          });
        });
      });
    });

    test('Set and Get Boolean Data Type from encrypted SharedPref', () {
      SecureSharedPref.getInstance().then((value) {
        value.putBool("BoolEncrypted", false, true).then((value2) {
          value.getBool("BoolEncrypted", true).then((value3) {
            expect(value3, false);
          });
        });
      });
    });
    test('Set and Get Double Data Type from encrypted SharedPref', () {
      SecureSharedPref.getInstance().then((value) {
        value.putDouble("DoubleEncrypted", 0.213, true).then((value2) {
          value.getDouble("DoubleEncrypted", true).then((value3) {
            expect(value3, 0.213);
          });
        });
      });
    });
    test('Set and Get Map Data Type from encrypted SharedPref', () {
      SecureSharedPref.getInstance().then((value) {
        value.putMap("MapEncrypted", {"Hello": 100}, true).then((value2) {
          value.getMap("MapEncrypted", true).then((value3) {
            expect(value3, {"Hello": 100});
          });
        });
      });
    });
    test('Set and Get StringList Data Type from encrypted SharedPref', () {
      SecureSharedPref.getInstance().then((value) {
        value.putStringList("StringListEncrypted", ["S", "U", "R"], true).then((value2) {
          value.getStringList("StringListEncrypted", true).then((value3) {
            expect(value3, ["S", "U", "R"]);
          });
        });
      });
    });
  });
}
