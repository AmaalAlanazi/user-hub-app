import 'package:flutter/material.dart';
import 'package:user_hub_app/model/to_do_model.dart';
import 'package:user_hub_app/server/network/network_method.dart';

class UserTodosScreen extends StatefulWidget {
  const UserTodosScreen({super.key, required this.userId});
  final int userId;

  @override
  State<UserTodosScreen> createState() => _UserTodosScreenState();
}

class _UserTodosScreenState extends State<UserTodosScreen> {
  final api = NetworkMethod();
  List<ToDoModel> todos = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    todos = await api.getTodosByUserId(widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) return const Center(child: CircularProgressIndicator());

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: todos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final t = todos[i];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            title: Text(t.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: Icon(
              t.completed ? Icons.check_circle : Icons.cancel,
              color: t.completed
                  ? const Color(0xFF2ECC71)
                  : const Color(0xFFFF5C5C),
            ),
          ),
        );
      },
    );
  }
}
