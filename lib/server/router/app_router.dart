import 'package:go_router/go_router.dart';

import 'package:user_hub_app/screens/post_screens.dart';
import 'package:user_hub_app/screens/todo_screens.dart';
import 'package:user_hub_app/screens/user_overview_screen.dart';
import 'package:user_hub_app/screens/user_screen.dart';
import 'package:user_hub_app/screens/user_shell.dart';

import 'package:user_hub_app/server/router/route_key.dart';

class RouteApp {
  RouteApp._();

  static final routes = GoRouter(
    initialLocation: RouteKey.users,
    routes: [
      GoRoute(
        path: RouteKey.users,
        builder: (context, state) => const UserScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          final userId = int.parse(state.pathParameters['id']!);
          return UserShell(userId: userId, child: child);
        },
        routes: [
          GoRoute(
            path: RouteKey.overview,
            builder: (context, state) {
              final userId = int.parse(state.pathParameters['id']!);
              return UserOverviewScreen(userId: userId);
            },
          ),
          GoRoute(
            path: RouteKey.posts,
            builder: (context, state) {
              final userId = int.parse(state.pathParameters['id']!);
              return UserPostsScreen(userId: userId);
            },
          ),
          GoRoute(
            path: RouteKey.todos,
            builder: (context, state) {
              final userId = int.parse(state.pathParameters['id']!);
              return UserTodosScreen(userId: userId);
            },
          ),
        ],
      ),
    ],
  );
}
