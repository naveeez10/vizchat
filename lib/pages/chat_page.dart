import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String groupId;
  final String userId;

  const ChatPage({Key? key, required this.groupName, required this.groupId, required this.userId}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Chatpage")),
    );
  }
}
