import 'package:flutter/foundation.dart';
import 'package:shop/common/models/user.dart';

class UserProvider extends ChangeNotifier {
  // Private constructor for singleton pattern
  UserProvider._internal();

  static final UserProvider _instance = UserProvider._internal();

  factory UserProvider() => _instance;

  User? _currentUser;

  User? get currentUser => _currentUser;

  // Method to set the user
  void setUser(User? user) {
    if (_currentUser != user) {
      _currentUser = user;
      notifyListeners(); // Notify listeners about the change
    }
  }

  void updateUser(User? user) {
    if (_currentUser != user) {
      _currentUser = user;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Method to clear the user
  void clearUser() {
    _currentUser = null;
    notifyListeners(); // Notify listeners about the change
  }
}
