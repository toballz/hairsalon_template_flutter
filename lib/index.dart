import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:webclient/h.dart';
import 'package:webclient/receipt.dart';

final today = DateUtils.dateOnly(DateTime.now());

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [
    DateTime(today.year, today.month, 1)
  ];

  List<dynamic> items = [
    //{
    //'hairname': 'Item 2','orderId':'12',
    //'datetime': 'Subtitle for Item 2',
    //'imageUrl': 'https://imgs.search.brave.com/IRG7NtIebt6J0rglmrlogeonGsjv7twjhznwx3vpUT0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9wbHVz/LnVuc3BsYXNoLmNv/bS9wcmVtaXVtX3Bo/b3RvLTE2OTA4MjAz/MTc1ODYtZDkwNjRi/NjI0YmUwP3E9ODAm/dz0xMDAwJmF1dG89/Zm9ybWF0JmZpdD1j/cm9wJml4bGliPXJi/LTQuMC4zJml4aWQ9/TTN3eE1qQTNmREI4/TUh4elpXRnlZMmg4/TVRkOGZIUmhhMlVs/TWpCaEpUSXdjR2xq/ZEhWeVpYeGxibnd3/Zkh3d2ZIeDhNQT09', // Placeholder image URL
    //}
  ];

  @override
  void initState() {
    super.initState();

    Tools.httpPost({
      'v': '1',
      'getDatesAppointmentsMoreThanDate': '2',
      'dateTo':
          "${today.year}${today.month.toString().padLeft(2, '0')}${today.day.toString().padLeft(2, '0')}"
    }).then((value) {
      setState(() {
        List<dynamic> json = jsonDecode(value.body);
        //print(json);
        for (var value in json) {
          _multiDatePickerValueWithDefaultValue.remove(DateTime(
              int.parse(value['year']),
              int.parse(value['month']),
              int.parse(value['day'])));
          _multiDatePickerValueWithDefaultValue.add(DateTime(
              int.parse(value['year']),
              int.parse(value['month']),
              int.parse(value['day'])));
          //print("${value['year']} ${value['month']} ${value['day']}");
        }
      });
    });
  }

  Widget _buildDefaultMultiDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Colors.indigo,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
            config: config,
            value: _multiDatePickerValueWithDefaultValue,
            onValueChanged: (dates) async {
              var uni1 = dates;
              var uni2 = _multiDatePickerValueWithDefaultValue;
              if (uni1.length > uni2.length) {
                setState(() {
                  _multiDatePickerValueWithDefaultValue = uni2;
                });
              }

              List<DateTime?> uniDifference =
                  uni2.where((element) => !uni1.contains(element)).toList();

              //print("uni1 $uni1");
              //print("uni2 $uni2");
              if (uniDifference.isNotEmpty) {
                await Tools.httpPost({
                  'v': '1',
                  'getDatesAppointmentsSpecDate': '2',
                  'dateFrom':
                      "${uniDifference[0]!.year}${uniDifference[0]!.month.toString().padLeft(2, '0')}${uniDifference[0]!.day.toString().padLeft(2, '0')}"
                }).then((value) {
                  setState(() {
                    items = jsonDecode(value.body);
                  });
                });
              }
              //print(uniDifference);
            }),
        const SizedBox(height: 5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("View Appointments"),
        ),
        body: Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
              child: Column(
            children: [
              _buildDefaultMultiDatePickerWithValue(),
              const SizedBox(height: 10),
              SizedBox(
                  height: 500,
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image(
                              image: NetworkImage(items[index]['imageUrl']!),
                              width: 56, // Set the width of the image
                              height: 650, // Set the height of the image
                            ),
                            title: Text(items[index]['hairname']!),
                            subtitle: Text(items[index]['datetime']!),
                            trailing: const Icon(Icons.access_alarms_outlined),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReceiptPage(
                                        receiptId: items[index]['orderId']!,
                                        dateScheduled: items[index]
                                            ['datetime']!)),
                              );
                            });
                      })),
              const SizedBox(height: 10),
            ],
          )),
        )),
      ),
    );
  }
}
