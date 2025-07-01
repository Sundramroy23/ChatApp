import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/services/auth/auth_services.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;

  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  final TextEditingController _messageController = TextEditingController();
  final AuthServices _authServices = AuthServices();
  final ChatServices _chatServices = ChatServices();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(receiverId, _messageController.text);

      // clear the controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail)),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(receiverId, senderId),
      // initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("E R R O R ! ! !"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("L O A D I N G . . . "));
        }
        return ListView(
          children:
              snapshot.data!.docs
                  .map<Widget>((doc) => _buildMessageItem(doc))
                  .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //lets check if the user is current user
    bool isCurrentUser =
        data['senderId'] == _authServices.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(alignment: alignment, child: Text(data['message']));
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextfield(
            hintext: "Type a message",
            obscuretext: false,
            controller: _messageController,
          ),
        ),
        IconButton(onPressed: sendMessage, icon: Icon(Icons.send)),
      ],
    );
  }
}
