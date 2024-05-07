// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../screens/chat/chat_screen.dart';

class GroupTile extends StatefulWidget {
  final String username;
  final String groupId;
  final String groupName;
  const GroupTile({
    Key? key,
    required this.username,
    required this.groupId,
    required this.groupName,
  }) : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatScreen(
              groupName: widget.groupName,
              groupId: widget.groupId,
              userName: widget.username,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xff292731),
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.groupName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(167, 79, 75, 75)),
          ),
          subtitle: Text(
            "Join the conversation as ${widget.username}",
            style: const TextStyle(color: Color.fromARGB(78, 4, 72, 88)),
          ),
        ),
      ),
    );
  }
}
