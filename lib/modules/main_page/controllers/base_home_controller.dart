
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_posts_model.dart';
import '../services/posts_service.dart';

late BuildContext _mainContext;
// The controllers will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
class BaseCommand {
  // Models
  UserPostsModel userModel = _mainContext.read();
  // Services
  PostService userService = _mainContext.read();
}