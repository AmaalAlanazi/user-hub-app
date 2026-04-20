import 'package:flutter/material.dart';
import 'package:user_hub_app/model/post_model.dart';
import 'package:user_hub_app/server/network/network_method.dart';

class UserPostsScreen extends StatefulWidget {
  const UserPostsScreen({super.key, required this.userId});
  final int userId;

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  final api = NetworkMethod();
  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    posts = await api.getPostsByUserId(widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) return const Center(child: CircularProgressIndicator());

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final p = posts[i];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(p.body),
              ],
            ),
          ),
        );
      },
    );
  }
}
