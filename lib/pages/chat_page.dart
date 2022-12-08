import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vizchat/pages/group_info.dart';
import 'package:vizchat/service/database_service.dart';
import 'package:vizchat/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String groupId;
  final String userName;

  const ChatPage({Key? key, required this.groupName, required this.groupId, required this.userName}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String adminName = "";
  Stream<QuerySnapshot>? chats;
  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }
  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val){
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val){
      setState(() {
        adminName = val;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.groupName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            nextScreen(context, GroupInfo(groupName: widget.groupName,groupId: widget.groupId,adminName: adminName));
          }, icon: Icon(Icons.info))
        ],
      ),
    );
  }
}
