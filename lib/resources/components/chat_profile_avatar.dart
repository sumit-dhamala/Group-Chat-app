// ignore_for_file: must_be_immutable

import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';

class ChatProfileAvatar extends StatelessWidget {
  String name, randIndex;
  ChatProfileAvatar({
    super.key,
    required this.name,
    required this.randIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage("$randomImgUrl$randIndex"),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 40),
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: int.parse(randIndex) % 2 == 0
                          ? sColor
                          : Colors.transparent),
                  color: int.parse(randIndex) % 2 == 0
                      ? Colors.green
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
