import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:webclient/h.dart';
import 'package:webclient/receipt.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [];

  ///{ 'hairname': 'Item 2','orderId':'12', 'datetime': 'Subtitle for Item 2', 'imageUrl': 'https://cocohairsignature.com/img/29.jpg?93jv'}
  List<dynamic> items = [ ];

  //
  //
  //
  @override
  void initState() {
    super.initState();

    Tools.httpPost({
      'v': '1',
      'getDatesAppointmentsMoreThanDate': '2',
      'dateTo':
          "${Tools.todayDate.year.toString()}${Tools.todayDate.month.toString().padLeft(2, '0')}${Tools.todayDate.day.toString().padLeft(2, '0')}"
    }).then((value) {
      if (mounted) {
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
          }
        });
      }
    });
  }

  Widget _buildDefaultMultiDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
        firstDate: Tools.todayDate,
        calendarType: CalendarDatePicker2Type.multi,
        selectedDayHighlightColor: Colors.indigo,
        dayTextStyle: TextStyle(color: ColorPallette.fontColor()),
        controlsTextStyle: TextStyle(
            color: ColorPallette.fontColor(),
            fontSize: 15,
            fontWeight: FontWeight.bold),
        selectedDayTextStyle: const TextStyle(color:Colors.orangeAccent), 
        weekdayLabelTextStyle: TextStyle(color: ColorPallette.fontColor()),
        yearTextStyle: TextStyle(color: ColorPallette.fontColor()));
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
                if (mounted) {
                  setState(() {
                    _multiDatePickerValueWithDefaultValue = uni2;
                  });
                }
              }

              List<DateTime?> uniDifference =
                  uni2.where((element) => !uni1.contains(element)).toList();
 
              if (uniDifference.isNotEmpty) {
                await Tools.httpPost({
                  'v': '1',
                  'getDatesAppointmentsSpecDate': '2',
                  'dateFrom':
                      "${uniDifference[0]!.year}${uniDifference[0]!.month.toString().padLeft(2, '0')}${uniDifference[0]!.day.toString().padLeft(2, '0')}"
                }).then((value) {
                  if (mounted) {
                    setState(() {
                      items = jsonDecode(value.body);
                    });
                  }
                });
              }
              //print(uniDifference);
            }),
        const SizedBox(height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorPallette.backgroundColor(),
        body: Center(
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    children: [
                      Text("Upcoming Appointments",
                          style: TextStyle(
                              color: ColorPallette.fontColor(),
                              fontWeight: FontWeight.w700,
                              fontSize: 22)),
                          const  SizedBox(height: 12),
                      _buildDefaultMultiDatePickerWithValue(),
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: Image(
                                    image: NetworkImage(
                                        items[index]['imageUrl']!),
                                    width: 56,
                                    height: 650),
                                title: Text(items[index]['hairname']!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorPallette.fontColor())),
                                subtitle: Text(items[index]['datetime']!,
                                    style: TextStyle(
                                        color: ColorPallette.fontColor())),
                                trailing: Icon(Icons.access_alarms_outlined,
                                    color: ColorPallette.fontColor()),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReceiptPage(
                                            receiptId: items[index]
                                                ['orderId']!,
                                            dateScheduled: items[index]
                                                ['datetime']!)),
                                  );
                                });
                          }),
                      const SizedBox(height: 10),
                    ],
                  ),
                ))),
      ),
    );
  }
}
