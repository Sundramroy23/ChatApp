import 'package:chatapp/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color:
            isCurrentUser
                ? Colors.green
                : isDarkMode
                ? Colors.grey.shade800
                : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(message, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
