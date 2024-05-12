// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';

import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MsgContainer extends StatefulWidget {
  final int myId;
  Map<String, dynamic> msg;
  Function onMessageDeletedOrEdited;
  MsgContainer(
      {super.key,
      required this.msg,
      required this.myId,
      required this.onMessageDeletedOrEdited});

  @override
  State<MsgContainer> createState() => _MsgContainerState();
}

class _MsgContainerState extends State<MsgContainer> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.msg['message'];
  }

  bool wasSentByMe() {
    return (widget.myId.toString() == widget.msg['sentBy']['id'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        InkWell(
          onDoubleTap: () {
            editDialog(context);
          },
          onLongPress: () {
            deleteDialog(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment:
                (wasSentByMe()) ? Alignment.centerRight : Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!wasSentByMe()) Text(widget.msg['sentBy']['name']),
                Container(
                  decoration: BoxDecoration(
                    color: wasSentByMe() ? Colors.blue : pColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.msg['message'],
                      softWrap: true,
                      maxLines: 5,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> deleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Container(
              height: 100,
              width: 300,
              child: AlertDialog(
                title: Text(
                  "Do you want to delete this message?",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(sColor),
                            backgroundColor: MaterialStatePropertyAll(pColor)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No"),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(sColor),
                            backgroundColor: MaterialStatePropertyAll(pColor)),
                        onPressed: () async {
                          var response = await http.delete(Uri.parse(
                              "$apiURL/messages/${widget.msg['id']}"));
                          if (response.statusCode == 200) {
                            var decoded = jsonDecode(response.body);
                            if (decoded['status'] == 'fail') {
                              print(decoded['data']);
                              return;
                            } else {
                              widget.onMessageDeletedOrEdited();
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  Future<dynamic> editDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            width: 300,
            child: AlertDialog(
              title: Text(
                "Edit message",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: TextField(
                controller: textEditingController,
                cursorColor: pColor,
                decoration: InputDecoration(
                  hintText: textEditingController.text,
                  filled: true,
                  fillColor: textFieldBg,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(sColor),
                          backgroundColor: MaterialStatePropertyAll(pColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(sColor),
                          backgroundColor: MaterialStatePropertyAll(pColor)),
                      onPressed: () async {
                        var response = await http.put(
                            Uri.parse("$apiURL/messages/${widget.msg['id']}"),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              "message": textEditingController.text,
                            }));
                        // print(response.body);
                        widget.onMessageDeletedOrEdited();
                        Navigator.of(context).pop();
                      },
                      child: Text("Edit"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
