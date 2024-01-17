

import 'package:flutter/foundation.dart';
import 'package:flutter_projects/modules/main_page/models/services/posts_service.dart';

class UserPostsViewModel extends ChangeNotifier {

  PostService postService = PostService();

  List<String> _userPosts = [];

  List<String> get userPosts => _userPosts;

  set userPosts(List<String> userPosts) {
    _userPosts = userPosts;
    notifyListeners();
  }

  Future<void> getPosts(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await postService.getPosts(user);
    _userPosts = posts;
    notifyListeners();
    // Return our posts to the caller in case they care
  }

// Eventually other stuff would go here, notifications, friends, draft posts, etc
}