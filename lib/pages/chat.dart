// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chat_app/pages/view_page/channels.dart';
import 'package:chat_app/pages/view_page/home.dart';
import 'package:chat_app/resources/components/chat_profile_avatar.dart';
import 'package:chat_app/resources/components/view_container.dart';
import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isHome = true;
  bool isChannel = false;
  viewPage() {
    if (isHome) {
      return Home();
    } else {
      return Channels();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: TextField(
                cursorColor: pColor,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: iconColor,
                    fontSize: 14,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.search,
                      color: iconColor,
                    ),
                  ),
                  filled: true,
                  fillColor: sColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChatProfileAvatar(
                    name: "Your note",
                    randIndex: "1",
                  ),
                  ChatProfileAvatar(
                    name: "Sumit",
                    randIndex: "2",
                  ),
                  ChatProfileAvatar(
                    name: "Darshan",
                    randIndex: "3",
                  ),
                  ChatProfileAvatar(
                    name: "Yogendra",
                    randIndex: "4",
                  ),
                  ChatProfileAvatar(
                    name: "Meenu",
                    randIndex: "5",
                  ),
                  ChatProfileAvatar(
                    name: "Priyanka",
                    randIndex: "6",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: sColor,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHome = true;
                          isChannel = false;
                        });
                      },
                      child: ViewContainer(
                        txtColor: isHome ? sColor : Colors.black,
                        bgColor: isHome ? pColor : sColor,
                        name: 'Home',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHome = false;
                          isChannel = true;
                        });
                      },
                      child: ViewContainer(
                        txtColor: isChannel ? sColor : Colors.black,
                        bgColor: isChannel ? pColor : sColor,
                        name: "Channels",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            viewPage(),
          ],
        ),
      ),
    );
  }
}
