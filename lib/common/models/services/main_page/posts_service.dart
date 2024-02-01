import 'dart:math';


///A fake service to simulate a service call to get posts
class PostService {
  Future<List<String>> getPosts(String user) async {
    // Fake a service call, and return some posts
    await Future.delayed(const Duration(milliseconds: 500));
    return List.generate(50, (index) => "$user Item ${Random().nextInt(999)}}");
  }

}