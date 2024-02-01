

import 'package:flutter/foundation.dart';
import 'package:flutter_projects/common/models/providers/user_provider.dart';
import 'package:flutter_projects/common/models/services/main_page/posts_service.dart';

class UserPostsViewModel extends ChangeNotifier {

  /// Viewmodel initialization and dependency injection
  PostService postService;
  UserProvider userService;
  UserPostsViewModel({required this.postService, required this.userService});

  void update({required PostService postService, required UserProvider userService}) {
   this.postService = postService;
   this.userService = userService;
  }


  /// Viewmodel properties
  List<String> _userPosts = [];

  List<String> get userPosts => _userPosts;

  set userPosts(List<String> userPosts) {
    _userPosts = userPosts;
    notifyListeners();
  }

  Future<void> getPosts() async {
    // Make service call and inject results into the model
    List<String> posts = await postService.getPosts(userService.currentUser!);
    _userPosts = posts;
    notifyListeners();
    // Return our posts to the caller in case they care
  }

// Eventually other stuff would go here, notifications, friends, draft posts, etc
}