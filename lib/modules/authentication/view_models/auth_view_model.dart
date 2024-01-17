import 'package:flutter/foundation.dart';
import 'package:flutter_projects/modules/authentication/models/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {

  AuthService authService = AuthService();

  String? _currentUser;

  String? get currentUser => _currentUser;

  set currentUser(String? currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

  Future<bool> login(String user, String pass) async {
    // Await some service call
    bool loginSuccess = await authService.login(user, pass);
    print("Login status: $loginSuccess");
    // Update appModel with current user. Any views bound to this will rebuild
    currentUser = (loginSuccess? user : null)!;
    notifyListeners();

    // Return the result to whoever called us, in case they care
    return loginSuccess;
  }
// Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
}