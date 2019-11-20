import 'package:beyond/service/service_common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' if (dart.library.html) 'dart:html';

abstract class SharedPreferencesService implements Startable {
  @override
  Future start();

  Future<bool> setString(String key, String value);

  String getString(String key);
}

class MobileSharedPreferencesService extends SharedPreferencesService {
  SharedPreferences prefs;

  @override
  Future start() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setString(String key, String value) {
    return prefs.setString(key, value);
  }

  @override
  String getString(String key) {
    return prefs.getString(key);
  }
}

class WebSharedPreferencesService extends SharedPreferencesService {
  Storage _localStorage;

  @override
  Future start() async {
    _localStorage = window.localStorage;
  }

  @override
  Future<bool> setString(String key, String value) {
    _localStorage[key] = value;
    return Future.value(true);
  }

  @override
  String getString(String key) {
    return _localStorage[key];
  }
}
