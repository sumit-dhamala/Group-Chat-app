// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:chat_app/resources/components/chat_mag_appbar_icon.dart';
import 'package:chat_app/resources/components/msg_container.dart';
import 'package:chat_app/resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatMsg extends StatefulWidget {
  const ChatMsg({super.key});

  @override
  State<ChatMsg> createState() => _ChatMsgState();
}

String ip = '10.32.16.247';

class _ChatMsgState extends State<ChatMsg> {
  TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 212, 212),
      appBar: AppBar(
        backgroundColor: pColor,
        foregroundColor: sColor,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("${randomImgUrl}1"),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0, bottom: 2),
                child: Container(
                  height: 13,
                  width: 13,
                  decoration: BoxDecoration(
                    border: Border.all(color: sColor),
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            "Bikash",
            style: TextStyle(
              fontSize: 14,
              color: sColor,
            ),
          ),
          subtitle: Text(
            "Active Now",
            style: TextStyle(color: iconColor, fontSize: 11),
          ),
          trailing: Container(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: ChatMsgAppBarIcon(
                      name: Icon(
                    Icons.call,
                    color: Colors.white,
                  )),
                ),
                InkWell(
                  child: ChatMsgAppBarIcon(
                    name: Icon(
                      Icons.video_call,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  child: ChatMsgAppBarIcon(
                    name: Icon(
                      Icons.circle_notifications_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: FutureBuilder(
                    future: http.get(Uri.parse("http://$ip:3000/messages")),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        var decodedResponse = jsonDecode(snapshot.data!.body);
                        if (decodedResponse['status'] == 'success') {
                          List messages = decodedResponse['data']['messages'];
                          return Column(
                            children: messages.reversed
                                .map(
                                  (e) => MsgContainer(
                                    msg: e.toString(),
                                  ),
                                )
                                .toList(),
                          );
                        } else {
                          return Text("Something went wrong");
                        }
                      } else {
                        // loading condition
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                cursorColor: pColor,
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "Enter message here...",
                    hintStyle: TextStyle(
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 231, 230, 230),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IconButton(
                        icon: isLoading
                            ? CupertinoActivityIndicator()
                            : Icon(
                                Icons.send,
                                color: pColor,
                              ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          var response = await http.post(
                            Uri.parse('http://$ip:3000/messages'),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode(
                                {"message": textEditingController.text}),
                          );
                          textEditingController.clear();
                          var decodedResponse = jsonDecode(response.body);
                          if (decodedResponse['status'] != 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: pColor,
                                content:
                                    Text(decodedResponse['data']['message'])));
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
