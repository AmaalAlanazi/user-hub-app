import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_hub_app/model/post_model.dart';
import 'package:user_hub_app/model/to_do_model.dart';
import 'package:user_hub_app/model/user_model.dart';
import 'package:user_hub_app/server/network/network_method.dart';

class UserOverviewScreen extends StatefulWidget {
  const UserOverviewScreen({super.key, required this.userId});
  final int userId;

  @override
  State<UserOverviewScreen> createState() => _UserOverviewScreenState();
}

class _UserOverviewScreenState extends State<UserOverviewScreen> {
  final api = NetworkMethod();

  UserModel? user;
  List<PostModel> posts = [];
  List<ToDoModel> todos = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    user = await api.getUserById(widget.userId);
    posts = await api.getPostsByUserId(widget.userId);
    todos = await api.getTodosByUserId(widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final users = user!;
    final postPreview = posts.take(2).toList();
    final todoPreview = todos.take(3).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  users.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '@${users.username}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(users.phone)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.language, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(users.website)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${users.address.street}, ${users.address.city}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Posts (preview)',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            TextButton(
              onPressed: () => context.push(
                '/user/${widget.userId}/posts',
                extra: {'userId': widget.userId},
              ),
              child: const Text('View all'),
            ),
          ],
        ),
        ...postPreview.map(
          (p) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              title: Text(
                p.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                p.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Todos (preview)',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            TextButton(
              onPressed: () => context.push(
                '/user/${widget.userId}/todos',
                extra: {'userId': widget.userId},
              ),
              child: const Text('View all'),
            ),
          ],
        ),
        ...todoPreview.map(
          (t) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              title: Text(
                t.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(
                t.completed ? Icons.check_circle : Icons.cancel,
                color: t.completed
                    ? const Color(0xFF2ECC71)
                    : const Color(0xFFFF5C5C),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
