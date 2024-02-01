import 'package:shared_preferences/shared_preferences.dart';

class UserSession {

  String? _currentUser;

  String? get currentUser => _currentUser;

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

  Future<String?> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.getString('currentUser');
    return _currentUser;
  }
}