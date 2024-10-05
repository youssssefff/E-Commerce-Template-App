import 'package:flutter/foundation.dart';

class EmailProvider extends ChangeNotifier {
  String? _email;

  String? get email => _email;

  // Method to set the email
  void setEmail(String email) {
    if (_email != email) {
      _email = email;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Method to clear the email
  void clearEmail() {
    _email = null;
    notifyListeners(); // Notify listeners about the change
  }
}
