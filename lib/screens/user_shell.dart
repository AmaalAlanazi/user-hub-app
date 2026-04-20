import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserShell extends StatelessWidget {
  const UserShell({super.key, required this.userId, required this.child});

  final int userId;
  final Widget child;

  int _indexFromLocation(String location) {
    if (location.endsWith('/posts')) return 1;
    if (location.endsWith('/todos')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexFromLocation(location);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6FA),
        elevation: 0,
        title: Text('User #$userId'),
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/users'),
              )
            : null,
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          if (i == 0) {
            context.go('/user/$userId/overview', extra: {'userId': userId});
          } else if (i == 1) {
            context.go('/user/$userId/posts', extra: {'userId': userId});
          } else {
            context.go('/user/$userId/todos', extra: {'userId': userId});
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Overview'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Posts'),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Todos',
          ),
        ],
      ),
    );
  }
}
