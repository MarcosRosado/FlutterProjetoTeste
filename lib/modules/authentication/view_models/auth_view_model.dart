import 'package:flutter/foundation.dart';
import 'package:flutter_projects/common/models/services/authentication/auth_service.dart';

import '../../../common/models/user/user_session.dart';

class AuthViewModel extends ChangeNotifier {

  /// Viewmodel initialization and dependency injection
  AuthService authService;
  UserSession userSession;
  AuthViewModel({required this.authService, required this.userSession});

  void update({required AuthService authService, required UserSession userService}) {
    this.authService = authService;
    this.userSession = userService;
  }


  String? get currentUser => userSession.currentUser;

  set currentUser(String? currentUser) {
    userSession.currentUser = currentUser;
  }


  Future<bool> login(String user, String pass) async {
    // Await some service call
    bool loginSuccess = await authService.login(user, pass);
    print("Login status: $loginSuccess");
    // Update appModel with current user. Any views bound to this will rebuild
    userSession.currentUser = (loginSuccess? user : null)!;

    notifyListeners();

    // Return the result to whoever called us, in case they care
    return loginSuccess;
  }

// Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
}