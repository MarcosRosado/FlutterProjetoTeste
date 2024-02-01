
class AuthService {
  Future<bool> login(String user, String pass) async {
    // Fake a network service call, and return true
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}