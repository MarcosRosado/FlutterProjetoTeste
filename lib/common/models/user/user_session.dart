import 'package:shared_preferences/shared_preferences.dart';

/// The user session class;
/// This class is responsible for managing the current user session;
/// It also saves the current user to shared preferences.
///
/// This class behave as a singleton, so it can be accessed from anywhere in the app,
/// also the user session is initialized when the app starts on the splash screen.
class UserSession {

  /// The current user
  String? _currentUser;

  /// The current user getter
  String? get currentUser => _currentUser;

  /// The current user setter, also saves the user to shared preferences when updated
  set currentUser(String? user) {
    _currentUser = user;
    if (user != null) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('currentUser', user);
      });
    } else {
      SharedPreferences.getInstance().then((prefs) {
        prefs.remove('currentUser');
      });
    }
  }

  /// Initializes the user session, gets the current user from shared preferences
  Future<String?> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.getString('currentUser');
    return _currentUser;
  }
}