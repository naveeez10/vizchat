import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vizchat/pages/group_info.dart';
import 'package:vizchat/service/database_service.dart';
import 'package:vizchat/widgets/message_style.dart';
import 'package:vizchat/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String groupId;
  final String userName;

  const ChatPage({Key? key,
    required this.groupName,
    required this.groupId,
    required this.userName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String adminName = "";
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        adminName = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text(
          widget.groupName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(
                    context,
                    GroupInfo(
                        groupName: widget.groupName,
                        groupId: widget.groupId,
                        adminName: adminName));
              },
              icon: Icon(Icons.info))
        ],
      ),
      body: Stack(
        children: <Widget>[
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery
                .of(context)
                .size
                .width,

            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              color: Colors.grey[400],
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Send a message",
                          hintStyle: TextStyle(
                              color: Colors.white, fontSize: 17),
                        ),
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return MessageTile(
                    message: snapshot.data.docs[index]['message'],
                    sender: snapshot.data.docs[index]['sender'],
                    sentbyme:
                    widget.userName == snapshot.data.docs[index]['sender']);
              },
              itemCount: snapshot.data.docs.length,
            );
          }
          else {
            return Container();
          }
        },
        stream: chats);
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessagemap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime
            .now()
            .millisecondsSinceEpoch,
      };
      DatabaseService()
         .sendMessage(widget.groupId, chatMessagemap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
