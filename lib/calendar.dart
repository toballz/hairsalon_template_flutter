import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webclient/h.dart';

//https://pub.dev/packages/calendar_date_picker2/example

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  TextEditingController sundayController = TextEditingController();
  TextEditingController mondayController = TextEditingController();
  TextEditingController tuesdayController = TextEditingController();
  TextEditingController wednesdayController = TextEditingController();
  TextEditingController thursdayController = TextEditingController();
  TextEditingController fridayController = TextEditingController();
  TextEditingController saturdayController = TextEditingController();
  TextEditingController overrideController = TextEditingController();

  //
  List<dynamic> overridedDates = [];
  //
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [];
//4
//

  void getWeeklyANDOverrideDates() async {
    var weeklyDatesResponse =
        await Tools.httpPost({'v': '1', 'getweeklyStatic': '2', 'had': "a"});
    var weeklyDatesJson = jsonDecode(weeklyDatesResponse.body);

    var overRideResponse =
        await Tools.httpPost({'v': '1', 'getOverrideDates': '2', 'va': "a"});
    var overRideJson = jsonDecode(overRideResponse.body);
    List<dynamic> filteredListOverridedDates = overRideJson.where((entry) {
      DateTime entryDate = DateTime.parse(entry['date']!);
      return entryDate.isAfter(Tools.todayDate) ||
          entryDate.isAtSameMomentAs(Tools.todayDate);
    }).toList();

    if (mounted) {
      setState(() {
        sundayController.text = weeklyDatesJson['sunday'];
        mondayController.text = weeklyDatesJson['monday'];
        tuesdayController.text = weeklyDatesJson['tuesday'];
        wednesdayController.text = weeklyDatesJson['wednesday'];
        thursdayController.text = weeklyDatesJson['thursday'];
        fridayController.text = weeklyDatesJson['friday'];
        saturdayController.text = weeklyDatesJson['saturday'];
        //
        //
        //filter out dates in json lower than today date

        overridedDates = filteredListOverridedDates;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWeeklyANDOverrideDates();
  }

//
  void numberformatterOverrides(v, contrroller) {
    String formattedText =
        v.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    if (formattedText.isNotEmpty) {
      // Insert comma and space every 4 characters
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < formattedText.length; i++) {
        buffer.write(formattedText[i]);
        if ((i + 1) % 4 == 0 && i != formattedText.length - 1) {
          buffer.write(', ');
        }
      }
      contrroller.value = TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.length),
      );
    } else {
      contrroller.value = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallette.backgroundColor(),
        appBar: AppBar(
          backgroundColor: ColorPallette.backgroundColor(),
          title: Text(Site.getCurrentUserDomain,
              style: TextStyle(fontSize: 17, color: ColorPallette.fontColor())),
        ),
        body: Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              weeklyScheduleWithTime(),
              buildDefaultRangeDatePickerWithValue(),
            ]),
          ),
        )));
  }
//

//
//
  Widget buildDayRow(
      String day, TextEditingController textcontrolller, double paddingLeft) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(day,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ColorPallette.fontColor())),
      const SizedBox(width: 21),
      Expanded(
          child: TextField(
              style: const TextStyle(color: Colors.deepOrangeAccent),
              controller: textcontrolller,
              keyboardType: TextInputType.number,
              onChanged: (va) {
                numberformatterOverrides(va, textcontrolller);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                hintText: '1200, 1500, 1400, 1600',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(
                    left: paddingLeft, top: 2, bottom: 2, right: 2),
              ))),
    ]);
  }

//weekly
  Widget weeklyScheduleWithTime() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(height: 10),
      Text('Weekly Schedules!',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: ColorPallette.fontColor())),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Days",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: ColorPallette.fontColor())),
        const SizedBox(width: 60),
        Expanded(
            child: Text("leave empty for unavailability! (24hrs time)",
                textAlign: TextAlign.start,
                style: TextStyle(color: ColorPallette.fontColor())))
      ]),
      //sunday
      buildDayRow("Sun ", sundayController, 12),
      //Monday
      buildDayRow("Mon", mondayController, 12),
      //Tuesday
      buildDayRow("Tue ", tuesdayController, 13),
      //Wednesday
      buildDayRow("Wed", wednesdayController, 12),
      //Thursday
      buildDayRow("Thu ", thursdayController, 12),
      //friday
      buildDayRow("Fri   ", fridayController, 12),
      //saturday
      buildDayRow("Sat ", saturdayController, 14),

      const SizedBox(height: 15),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(14),
              minimumSize: const Size.fromHeight(19),
              backgroundColor: Colors.deepOrangeAccent),
          onPressed: () async {
            Map<String, dynamic> aasaa = {};
            aasaa['sunday'] = sundayController.text;
            aasaa['monday'] = mondayController.text;
            aasaa['tuesday'] = tuesdayController.text;
            aasaa['wednesday'] = wednesdayController.text;
            aasaa['thursday'] = thursdayController.text;
            aasaa['friday'] = fridayController.text;
            aasaa['saturday'] = saturdayController.text;
            //
            await Tools.httpPost(
                {'v': '1', 'updatesWeekly': jsonEncode(aasaa), 'ajr': "a"});

            if (context.mounted) {
              Fluttertoast.showToast(
                  msg: "Weekly Shedule Saved!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              setState(() {});
            }
            //
          },
          child: const Text("Save weekly Dates...",
              style: TextStyle(color: Colors.white, fontSize: 18))),
      const SizedBox(height: 24)
    ]);
  }

//specific
  Widget buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
        firstDate: Tools.todayDate,
        calendarType: CalendarDatePicker2Type.multi,
        selectedDayHighlightColor: Colors.teal[800],
        weekdayLabelTextStyle: TextStyle(
            color: ColorPallette.fontColor(), fontWeight: FontWeight.bold),
        controlsTextStyle: TextStyle(
            color: ColorPallette.fontColor(),
            fontSize: 15,
            fontWeight: FontWeight.bold),
        dayTextStyle: TextStyle(color: ColorPallette.fontColor()),
        yearTextStyle: TextStyle(color: ColorPallette.fontColor()));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        Text('Override Specific Date(s)?',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: ColorPallette.fontColor())),
        CalendarDatePicker2(
            config: config,
            value: _rangeDatePickerValueWithDefaultValue,
            onValueChanged: (dates) =>
                setState(() => _rangeDatePickerValueWithDefaultValue = dates)),
        const SizedBox(height: 20),
        Text('Enter override time(s), leave empty for unavailability!',
            style: TextStyle(
              color: ColorPallette.fontColor(),
            )),
        TextField(
            keyboardType: TextInputType.number,
            controller: overrideController,
            style: TextStyle(color: ColorPallette.fontColor()),
            onChanged: (va) {
              numberformatterOverrides(va, overrideController);
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
                hintText: "1100, 1300, 1530 (24hrs time)",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(12))),
        const SizedBox(height: 12),
        SizedBox(
            height: null,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: overridedDates.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading:
                      const Icon(Icons.lock_clock_outlined), // Icon on the left
                  title: Text(
                      "Date: ${Tools.dateIntToDaysMonth(overridedDates[index]['date']!.toString())}",
                      style: TextStyle(
                          color: ColorPallette.fontColor(), fontSize: 14)),
                  subtitle: Text("Time: ${overridedDates[index]['time']!}",
                      style: TextStyle(
                          color: ColorPallette.fontColor(), fontSize: 11)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: ColorPallette.fontColor()),
                    onPressed: () async {
                      if (mounted) {
                        setState(() {
                          overridedDates.removeWhere((map) =>
                              map['date'] == overridedDates[index]['date']! &&
                              map['time'] == overridedDates[index]['time']!);
                        });
                        await Tools.httpPost({
                          "v": '1',
                          "cat": jsonEncode(overridedDates),
                          "updateOverrided": "v1"
                        });
                      }
                    },
                  ),
                  onTap: () {},
                );
              },
            )),
        const SizedBox(height: 35),
        ElevatedButton(
            onPressed: () async {
              if (_rangeDatePickerValueWithDefaultValue != []) {
                for (var i = 0;
                    i < _rangeDatePickerValueWithDefaultValue.length;
                    i++) {
                  String year =
                      _rangeDatePickerValueWithDefaultValue[i]!.year.toString();
                  String month = _rangeDatePickerValueWithDefaultValue[i]!
                      .month
                      .toString()
                      .padLeft(2, '0');
                  String day = _rangeDatePickerValueWithDefaultValue[i]!
                      .day
                      .toString()
                      .padLeft(2, '0');
                  //remove if already exists
                  overridedDates
                      .removeWhere((map) => map['date'] == "$year$month$day");
                  // 00
                  overridedDates.add({
                    "date": "$year$month$day",
                    "time": overrideController.text
                  });
                }
                setState(() {
                  overridedDates = overridedDates;
                });
                await Tools.httpPost({
                  "v": '1',
                  "cat": jsonEncode(overridedDates),
                  "updateOverrided": "v1"
                });
                overrideController.text = "";
                Fluttertoast.showToast(
                    msg: "Date override saved.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                Fluttertoast.showToast(
                    msg: "Please Type In a override date & time.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(19),
                padding: const EdgeInsets.all(19),
                backgroundColor: Colors.teal[800]),
            child: const Text(
              "Add Override",
              style: TextStyle(color: Colors.white),
            )),
        const SizedBox(height: 25)
      ],
    );
  }
}
