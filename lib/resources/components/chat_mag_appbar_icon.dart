// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class ChatMsgAppBarIcon extends StatelessWidget {
  Icon name;
  ChatMsgAppBarIcon({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: Center(child: name),
    );
  }
}
