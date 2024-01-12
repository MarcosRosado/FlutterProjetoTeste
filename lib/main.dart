import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/common/styles/theme.dart';
import 'package:flutter_projects/controllers/router/router.dart';
import 'package:flutter_projects/modules/authentication/services/auth_service.dart';
import 'package:flutter_projects/modules/main_page/services/posts_service.dart';
import 'package:provider/provider.dart';

import 'modules/authentication/controllers/base_login_controller.dart' as login_controllers;
import 'modules/authentication/models/auth_model.dart';
import 'modules/main_page/controllers/base_home_controller.dart' as home_controllers;
import 'modules/main_page/models/user_posts_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        //Auth
        ChangeNotifierProvider(create: (c) => AuthModel()),
        Provider(create: (c) => AuthService()),

        //Main Page - Posts
        ChangeNotifierProvider(create: (c) => UserPostsModel()),
        Provider(create: (c) => PostService()),
      ],
      child: Builder(builder: (context) {
        // Save a context our Commands can use to access provided Models and Services
        login_controllers.init(context);
        home_controllers.init(context);
        return MaterialApp.router(
          routerConfig: router,
        );
      }),
    );
  }
}