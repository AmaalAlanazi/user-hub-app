import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user_hub_app/model/user_model.dart';
import 'package:user_hub_app/server/network/network_method.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final api = NetworkMethod();
  List<UserModel> userLoaded = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _iniLoaded();
  }

  Future<void> _iniLoaded() async {
    loading = true;
    setState(() {});
    userLoaded = await api.getAllUser();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 212, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 228, 237),
        elevation: 0,
        centerTitle: true,
        title: const Text('Users'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userLoaded.length,
              itemBuilder: (context, index) {
                final u = userLoaded[index];

                return Card(
                  margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    onTap: () {
                      context.push(
                        '/user/${u.id}/overview',
                        extra: {'userId': u.id},
                      );
                    },
                    title: Text(
                      u.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            u.username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            u.company.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
    );
  }
}
