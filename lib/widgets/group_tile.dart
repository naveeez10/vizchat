import 'package:flutter/material.dart';
import 'package:vizchat/pages/chat_page.dart';
import 'package:vizchat/widgets/widgets.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupName;
  final String groupId;

  const GroupTile(
      {Key? key,
      required this.userName,
      required this.groupName,
      required this.groupId})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, ChatPage(groupId:widget.groupId,userId: widget.userName,groupName: widget.groupName,));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(widget.groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
          ),
          title: Text(widget.groupName,style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Join the Conversation as ${widget.userName}",style: TextStyle(fontSize: 13),),
        ),
      ),
    );
  }
}
