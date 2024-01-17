import 'dart:math';

class PostService {
  Future<List<String>> getPosts(String user) async {
    // Fake a service call, and return some posts
    await Future.delayed(Duration(milliseconds: 500));
    return List.generate(50, (index) => "$user Item ${Random().nextInt(999)}}");
  }

}