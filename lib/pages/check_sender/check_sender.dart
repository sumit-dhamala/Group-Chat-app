// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:chat_app/pages/view_page/chat_msg.dart';
import 'package:chat_app/resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckSender extends StatefulWidget {
  const CheckSender({super.key});

  @override
  State<CheckSender> createState() => _CheckSenderState();
}

class _CheckSenderState extends State<CheckSender> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> savePersonInfo(String name, int id) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("sender_name", name);
    await prefs.setInt("sender_id", id);
    print("$name and $id saved to local storage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pColor,
        foregroundColor: sColor,
        title: Text("Group Messaging"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your name to join:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  child: TextFormField(
                    validator: (inputText) {
                      if (inputText == null) return "Enter something";
                      if (inputText.isEmpty) return "Enter something";
                      if (!inputText.contains(" ")) {
                        return "Enter your full name with a space in between.";
                      }
                      return null;
                    },
                    controller: nameController,
                    cursorColor: pColor,
                    decoration: InputDecoration(
                      focusColor: pColor,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(pColor),
                      foregroundColor: MaterialStatePropertyAll(sColor)),
                  onPressed: !isLoading
                      ? () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              var response = await http.post(
                                Uri.parse("$apiURL/peoples/new"),
                                headers: {"Content-Type": "application/json"},
                                body: jsonEncode(
                                  {"name": nameController.text},
                                ),
                              );
                              if (response.statusCode == 200) {
                                print(response.body);
                                var decoded = jsonDecode(response.body);
                                await savePersonInfo(
                                    decoded['data']['person']['name'],
                                    decoded['data']['person']['id']);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ChatMsg(
                                      senderId: decoded['data']['person']['id'],
                                    ),
                                  ),
                                );
                              } else {
                                throw Exception(
                                    "Invalid response: ${response.body}");
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")));
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            print("Invalid data");
                          }
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: !isLoading
                        ? Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : CupertinoActivityIndicator(
                            color: Colors.white,
                            radius: 12,
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
