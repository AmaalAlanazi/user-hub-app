import 'package:flutter/material.dart';
import 'package:user_hub_app/server/router/app_router.dart';

void main() {
  runApp(const UserHubApp());
}

class UserHubApp extends StatelessWidget {
  const UserHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RouteApp.routes,
    );
  }
}
