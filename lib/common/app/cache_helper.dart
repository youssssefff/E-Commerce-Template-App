import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/common/singletons/cache.dart';
import 'package:flutter/material.dart'; // Import for ThemeMode
import 'package:shop/extensions/theme_mode_extension.dart';

class CacheHelper {
  // Constructor to accept an instance of SharedPreferences
  const CacheHelper(this._prefs);

  // Singleton instance
  final SharedPreferences _prefs;

  // Keys for SharedPreferences
  static const String _sessionTokenKey = 'USER_SESSION_TOKEN';
  static const String _userIdKey = 'USER_ID';
  static const String _themeModeKey = 'THEME_MODE';
  static const String _firstTimeKey = 'IS_FIRST_TIME';

  // Set session token
  Future<bool> cacheSessionToken(String token) async {
    try {
      final result = await _prefs.setString(_sessionTokenKey, token);
      Cache.instance.setSessionToken(token); // Update Cache instance
      return result;
    } catch (e) {
      print('Error caching session token: $e');
      return false;
    }
  }

  // Set user ID
  Future<bool> cacheUserId(String userId) async {
    try {
      final result = await _prefs.setString(_userIdKey, userId);
      Cache.instance.setUserId(userId); // Update Cache instance
      return result;
    } catch (e) {
      print('Error caching user ID: $e');
      return false;
    }
  }

  // Set theme mode
  Future<bool> cacheThemeMode(ThemeMode themeMode) async {
    try {
      final result = await _prefs.setString(_themeModeKey, themeMode.toJson());
      Cache.instance.setThemeMode(themeMode); // Update Cache instance
      return result;
    } catch (e) {
      print('Error caching theme mode: $e');
      return false;
    }
  }

  // Set first-time flag
  Future<void> cacheFirstTime() async {
      final result = await _prefs.setBool(_firstTimeKey, false);
  }

  // Get session token
  Future<String?> getSessionToken() async {
    return _prefs.getString(_sessionTokenKey);
  }

  // Get user ID
  Future<String?> getUserId() async {
    return _prefs.getString(_userIdKey);
  }

  // Get theme mode
  Future<ThemeMode?> getThemeMode() async {
    final themeModeStr = _prefs.getString(_themeModeKey);
    final themeMode = themeModeStr != null ? ThemeModeExtension.fromJson(themeModeStr) : ThemeMode.system;
    Cache.instance.setThemeMode(themeMode); // Update Cache instance
    return themeMode;
  }

  // Get first-time flag
  bool isFirstTime() {
    final isFirstTime = _prefs.getBool(_firstTimeKey) ?? true;
    return isFirstTime;
  }

  // Reset session
  Future<bool> resetSession() async {
    try {
      final result = await Future.wait([
        _prefs.remove(_sessionTokenKey),
        _prefs.remove(_userIdKey),
        _prefs.remove(_themeModeKey),
        _prefs.remove(_firstTimeKey),
      ]);
      Cache.instance.resetSession(); // Update Cache instance
      return result.every((r) => r); // Return true if all removals were successful
    } catch (e) {
      print('Error resetting session: $e');
      return false;
    }
  }
}

