import 'package:flutter/material.dart';

class Cache {
  // Private constructor for singleton pattern
  Cache._internal();

  // Singleton instance
  static final Cache instance = Cache._internal();

  // Private fields for session token, user ID, and first-time flag
  String? _sessionToken;
  String? _userId;
  bool _isFirstTime = true;

  // Notifier for theme mode
  final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

  // Getter for session token
  String? get sessionToken => _sessionToken;

  // Setter for session token
  void setSessionToken(String? token) {
    _sessionToken = token;
  }

  // Getter for user ID
  String? get userId => _userId;

  // Setter for user ID
  void setUserId(String? id) {
    _userId = id;
  }

  // Getter for first-time flag
  bool get isFirstTime => _isFirstTime;

  // Setter for first-time flag
  void setFirstTime(bool isFirstTime) {
    _isFirstTime = isFirstTime;
  }

  // Method to update theme mode
  void setThemeMode(ThemeMode themeMode) {
    themeModeNotifier.value = themeMode;
  }

  // Getter for the current theme mode
  ThemeMode get themeMode => themeModeNotifier.value;

  // Method to reset the session
  void resetSession() {
    _sessionToken = null;
    _userId = null;
    _isFirstTime = true; // Reset first-time flag
  }
}

