import 'dart:math';

class UserService {
  Future<bool> login(String user, String pass) async {
    // Fake a network service call, and return true
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<List<String>> getPosts(String user) async {
    // Fake a service call, and return some posts
    await Future.delayed(Duration(milliseconds: 500));
    return List.generate(50, (index) => "$user Item ${Random().nextInt(999)}}");
  }
}