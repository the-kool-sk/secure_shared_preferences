import 'package:flutter_test/flutter_test.dart';

import 'package:secure_shared_preferences/secure_shared_preferences.dart';

void main() {
  test('Set and Get String Data Type from normal SharedPref', () {
    SecureSharedPref.getInstance().then((value) async {
      value.putString("SecureKey", "This is my first string test", isEncrypted:false);
      expect(await value.getString("SecureKey", isEncrypted:false),
          "This is my first string test");
    });
  });
}
