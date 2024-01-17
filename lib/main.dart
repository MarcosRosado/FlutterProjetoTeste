import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/common/styles/theme.dart';
import 'package:flutter_projects/controllers/router/router.dart';
import 'package:flutter_projects/modules/authentication/models/services/auth_service.dart';
import 'package:flutter_projects/modules/main_page/models/services/posts_service.dart';
import 'package:provider/provider.dart';

import 'modules/authentication/view_models/auth_view_model.dart';
import 'modules/main_page/view_models/user_posts_view_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        //Auth
        ChangeNotifierProvider(create: (c) => AuthViewModel()),
        Provider(create: (c) => AuthService()),

        //Main Page - Posts
        ChangeNotifierProvider(create: (c) => UserPostsViewModel()),
        Provider(create: (c) => PostService()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          routerConfig: router,
        );
      }),
    );
  }
}