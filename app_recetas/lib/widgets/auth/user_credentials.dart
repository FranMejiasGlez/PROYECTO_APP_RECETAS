import 'package:flutter/foundation.dart';

class UserCredentials extends ChangeNotifier {
  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  bool get hasCredentials => _email.isNotEmpty && _password.isNotEmpty;

  void setCredentials(String email, String password) {
    _email = email;
    _password = password;
    notifyListeners();
  }

  void clearCredentials() {
    _email = '';
    _password = '';
    notifyListeners();
  }
}