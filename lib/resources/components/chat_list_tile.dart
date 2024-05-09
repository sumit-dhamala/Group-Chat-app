import 'package:chat_app/pages/view_page/chat_msg.dart';
import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  String name, randImg;
  ChatListTile({super.key, required this.name, required this.randImg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatMsg(),
            ),
          );
        },
        tileColor: sColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage("$randomImgUrl$randImg"),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0, bottom: 2),
              child: Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: int.parse(randImg) % 2 == 0
                          ? sColor
                          : Colors.transparent),
                  color: int.parse(randImg) % 2 == 0
                      ? Colors.green
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        title: Text(name),
        subtitle: Text(
          int.parse(randImg) % 2 == 0 ? "Hello" : "Where are you?",
          style: TextStyle(
            fontSize: 13,
            color: iconColor,
          ),
        ),
        trailing: Icon(
          int.parse(randImg) % 2 == 0
              ? Icons.check_circle
              : Icons.check_circle_outline,
          size: 18,
          color: iconColor,
        ),
      ),
    );
  }
}
