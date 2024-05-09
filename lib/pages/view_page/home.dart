// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chat_app/resources/components/chat_list_tile.dart';
import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> names = [
      "Bikash",
      "Nikhil",
      "Samip",
      "Roshan",
      "Smriti",
      "Nikesh",
      "Meenu",
      "Preeti",
      "Priyanka",
      "Nirmal",
    ];
    return Column(
      children: [
        for (int i = 0; i < 10; i++)
          ChatListTile(
            name: names[i],
            randImg: (i + 8).toString(),
          ),
      ],
    );
  }
}
