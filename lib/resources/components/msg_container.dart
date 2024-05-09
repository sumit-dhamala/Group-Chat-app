import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';

class MsgContainer extends StatelessWidget {
  String msg;
  MsgContainer({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        InkWell(
          onDoubleTap: () {
            showDialog(
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
                      content: TextField(),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(sColor),
                                  backgroundColor:
                                      MaterialStatePropertyAll(pColor)),
                              onPressed: () {},
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(sColor),
                                  backgroundColor:
                                      MaterialStatePropertyAll(pColor)),
                              onPressed: () {},
                              child: Text("Edit"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          },
          onLongPress: () {},
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(vertical: 10),
            // height: 50,
            // width: MediaQuery.of(context).size.width * .6,
            decoration: BoxDecoration(
              color: pColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  textAlign: TextAlign.end,
                  msg,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
