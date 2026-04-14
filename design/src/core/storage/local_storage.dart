/// Local Database abstraction.
/// Completely hides the `SharedPreferences`, `FlutterSecureStorage`, 
/// or `Hive` implementation details from the features.
abstract class LocalStorage {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> remove(String key);
  Future<void> clearAll();
}

// Example Implementation using SharedPreferences:
/*
// import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorageImpl implements LocalStorage {
  final SharedPreferences _prefs;

  SharedPreferencesStorageImpl(this._prefs);

  @override
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
*/
