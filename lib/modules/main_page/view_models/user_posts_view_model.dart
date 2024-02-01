

import 'package:flutter/foundation.dart';
import 'package:flutter_projects/common/models/user/user_session.dart';
import 'package:flutter_projects/common/models/services/main_page/posts_service.dart';

class UserPostsViewModel extends ChangeNotifier {

  /// Viewmodel initialization and dependency injection
  PostService postService;
  UserSession userSession;
  UserPostsViewModel({required this.postService, required this.userSession});

  void update({required PostService postService, required UserSession userSession}) {
   this.postService = postService;
   this.userSession = userSession;
  }

  get currentUser => userSession.currentUser;


  /// Viewmodel properties
  List<String> _userPosts = [];

  List<String> get userPosts => _userPosts;

  set userPosts(List<String> userPosts) {
    _userPosts = userPosts;
    notifyListeners();
  }

  void signOut() {
    userSession.currentUser = null;
  }

  Future<void> getPosts() async {
    // Make service call and inject results into the model
    List<String> posts = await postService.getPosts(userSession.currentUser!);
    _userPosts = posts;
    notifyListeners();
    // Return our posts to the caller in case they care
  }

// Eventually other stuff would go here, notifications, friends, draft posts, etc
}