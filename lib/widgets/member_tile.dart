import 'package:flutter/material.dart';

class MemberTile extends StatefulWidget {
  final String userName;
  final String userId;

  const MemberTile({Key? key, required this.userName, required this.userId})
      : super(key: key);

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).primaryColor.withOpacity(0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 33,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                widget.userName.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              )),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.userName}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                widget.userId,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ],
      ),
    );
  }
}
