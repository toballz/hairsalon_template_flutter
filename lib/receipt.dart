import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webclient/h.dart';

class ReceiptPage extends StatefulWidget {
  final String receiptId;
  final String dateScheduled;

  const ReceiptPage(
      {super.key, required this.receiptId, required this.dateScheduled});
  @override
  ReceiptPageState createState() => ReceiptPageState();
}

class ReceiptPageState extends State<ReceiptPage> {
  Map<String, dynamic>? receiptInfo;
  @override
  void initState() {
    super.initState();

    Tools.httpPost({'v': '1', 'receiptIIinfo': widget.receiptId, 'j': ""})
        .then((value) {
      setState(() {
        receiptInfo = jsonDecode(value.body);
        //print(receiptInfo);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Receipt"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Image(
                  image: NetworkImage(
                      "https://${Site.getCurrentUserDomain}/img/${(receiptInfo != null) ? receiptInfo!['image'] : "nuul"}.jpg?11x2"),
                  height: 320),
              const SizedBox(height: 20),
              Row(children: [
                const Text("Name:        ",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text((receiptInfo != null)
                    ? receiptInfo!['customername'].toString().trim()
                    : "xxxxx xxxxxx")
              ]),
              const SizedBox(height: 10),
              Row(children: [
                const Text("Phone:    ",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                TextButton(
                    onPressed: () async {
                      if (receiptInfo != null) {
                        Clipboard.setData(ClipboardData(
                                text: receiptInfo!['phonne'].toString().trim()))
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Phone number copied!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      }
                    },
                    child: Text((receiptInfo != null)
                        ? receiptInfo!['phonne'].toString().trim()
                        : "(xxx) xxx-xxxx"))
              ]),
              Row(children: [
                const Text("Email:      ",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                TextButton(
                    onPressed: () async {
                      if (receiptInfo != null) {
                        Clipboard.setData(ClipboardData(
                                text: receiptInfo!['email'].toString().trim()))
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Email Copied",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      }
                    },
                    child: Text((receiptInfo != null)
                        ? receiptInfo!['email'].toString().trim()
                        : "xxxx@xxx.xx"))
              ]),
              const SizedBox(height: 20),
              Row(children: [
                const Text("Hairstyle:  ",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Flexible(
                    child: Text((receiptInfo != null)
                        ? receiptInfo!['hairstyle']
                        : "xxxxxx xxxxxxxx xx"))
              ]),
              const SizedBox(height: 10),
              Row(children: [
                const Text("Price:         ",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text((receiptInfo != null) ? receiptInfo!['price'] : "\$xxxx")
              ]),
              const SizedBox(height: 10),
              Row(children: [
                const Text("Date:          ",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text(
                  widget.dateScheduled,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 116, 225, 120)),
                )
              ]),
              const SizedBox(height: 10),
              Row(children: [
                const Text("Time:          ",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text(
                    ((receiptInfo != null)
                        ? Tools.timeMilitaryToRegular(receiptInfo!['time'])
                        : "xx:xx xx"),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 116, 225, 120)))
              ]),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    if (receiptInfo != null) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Text('Confirmation!'),
                                content: const Text(
                                    'Do you really want to delete this appointment?\nThis date will be available for other people!'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('No')),
                                  TextButton(
                                      onPressed: () async {
                                        await Tools.httpPost({
                                          'v': '1',
                                          'deleteAppointment': '2',
                                          'ksy': widget.receiptId
                                        });
                                        setState(() {
                                          receiptInfo = null;
                                        });
                                        Fluttertoast.showToast(
                                            msg: "Date Deleted !.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        if (context.mounted) {
                                          Navigator.of(context).pop(true);
                                        }
                                      },
                                      child: const Text('Yes'))
                                ]);
                          });
                    }
                  },
                  child: const Text("Delete this appointment!",
                      style: TextStyle(color: Colors.red)))
            ],
          )),
        )),
      ),
    );
  }
}
