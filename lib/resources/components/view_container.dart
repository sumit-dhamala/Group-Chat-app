// ignore_for_file: must_be_immutable

import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';

class ViewContainer extends StatelessWidget {
  String name;
  Color txtColor, bgColor;
  ViewContainer(
      {super.key,
      required this.name,
      required this.txtColor,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: MediaQuery.of(context).size.width * .4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: bgColor,
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: txtColor,
          ),
        ),
      ),
    );
  }
}
