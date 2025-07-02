import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/services/auth/auth_services.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  final ChatServices chatServices = ChatServices();
  final AuthServices authServices = AuthServices();

  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Unblock User'),
            content: const Text('Are you sure you want to unblock this user?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  chatServices.unblockUser(userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("User Unblocked!")));
                },
                child: Text("UNBLOCK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get current userID
    String userId = authServices.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(title: Text("Blocked User")),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatServices.getBlockedUsersStream(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("ERROR!"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final blockedUsers =
              snapshot.data ?? []; //if no blocked users return empty list

          return ListView.builder(
            itemCount: blockedUsers.length,
            itemBuilder: (context, index) {
              final user = blockedUsers[index];
              return UserTile(
                text: user['email'],
                onTap: () => _showUnblockBox(context, user['uid']),
              );
            },
          );
        },
      ),
    );
  }
}
