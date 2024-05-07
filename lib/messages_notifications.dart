import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webclient/h.dart';

class MessagesNotification extends StatefulWidget {
  const MessagesNotification({super.key});

  @override
  MessagesNotificationState createState() => MessagesNotificationState();
}

class MessagesNotificationState extends State<MessagesNotification> {
  String subjectItem = "xxxxx";
  String messageItem = "xxxxx";

  void getMessagesNotify() async {
    var ts =
        await Tools.httpPost({"v": "1", "get_messageNotifiy": "1", "a": "1"});
    if (mounted) {
      var messagess = jsonDecode(ts.body);
      setState(() {
        subjectItem = messagess['subject'];
        messageItem = messagess['message'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMessagesNotify();
  }
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallette.backgroundColor(),
        appBar: AppBar(
          backgroundColor: ColorPallette.backgroundColor(),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp,
                  color: ColorPallette.fontColor()),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text(subjectItem,
              style: TextStyle(
                  overflow: TextOverflow.fade,
                  color: ColorPallette.fontColor())),
        ),
        body: SingleChildScrollView(
            child: Align(
          alignment: Alignment.topLeft,
          child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child:
                        Text(subjectItem, style: const TextStyle(fontSize: 17)),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child:
                        Text(messageItem, style: const TextStyle(fontSize: 17)),
                  ),
                  const SizedBox(height: 34),
                ],
              )),
        )));
  }
}
