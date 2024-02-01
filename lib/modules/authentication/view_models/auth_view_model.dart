import 'package:flutter/foundation.dart';
import 'package:flutter_projects/common/models/services/authentication/auth_service.dart';

import '../../../common/models/providers/user_provider.dart';

class AuthViewModel extends ChangeNotifier {

  /// Viewmodel initialization and dependency injection
  AuthService authService;
  UserProvider userService;
  AuthViewModel({required this.authService, required this.userService});

  void update({required AuthService authService, required UserProvider userService}) {
    this.authService = authService;
    this.userService = userService;
  }


  String? get currentUser => userService.currentUser;

  set currentUser(String? currentUser) {
    userService.currentUser = currentUser;
  }


  Future<bool> login(String user, String pass) async {
    // Await some service call
    bool loginSuccess = await authService.login(user, pass);
    print("Login status: $loginSuccess");
    // Update appModel with current user. Any views bound to this will rebuild
    userService.currentUser = (loginSuccess? user : null)!;
    notifyListeners();

    // Return the result to whoever called us, in case they care
    return loginSuccess;
  }
// Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
}