import 'base_command.dart';

class RefreshPostsCommand extends BaseCommand {

  Future<List<String>> exec(String user) async {
    // Make service call and inject results into the model
    List<String> posts = await userService.getPosts(user);
    userModel.userPosts = posts;

    // Return our posts to the caller in case they care
    return posts;
  }

}