import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:webclient/h.dart';

//https://pub.dev/packages/calendar_date_picker2/example

final today = DateUtils.dateOnly(DateTime.now());

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
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime(today.year, today.month, today.day),
    DateTime(today.year, today.month, today.day)
  ];
//4
  Color? bgColor = Tools.themeDark
      ? Tools.colorShuttle['bgcolorDark']
      : Tools.colorShuttle['bgcolorLight'];
  Color? tabColor = Tools.themeDark
      ? Tools.colorShuttle['tabcolorDark']
      : Tools.colorShuttle['tabcolorLight'];
  Color? textColor = Tools.themeDark
      ? Tools.colorShuttle['textcolorDark']
      : Tools.colorShuttle['textcolorDark Light'];
//

  void getWeeklyANDOverrideDates() async {
    var weeklyDatesResponse =
        await Tools.httpPost({'v': '1', 'getweeklyStatic': '2', 'had': "a"});
    var weeklyDatesJson = jsonDecode(weeklyDatesResponse.body);

    var overRideResponse =
        await Tools.httpPost({'v': '1', 'getOverrideDates': '2', 'va': "a"});
    var overRideJson = jsonDecode(overRideResponse.body);

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
        overridedDates = overRideJson as List<dynamic>;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWeeklyANDOverrideDates();
  }
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(title: Text(Site.domain)),
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

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

//
//

//
//
  Widget buildDayRow(
      String day, TextEditingController textcontrolller, double xx) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(day,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
      SizedBox(width: xx),
      Expanded(
          child: TextField(
              style: const TextStyle(color: Colors.deepOrangeAccent),
              controller: textcontrolller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: '1200-1500 1400-1600',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(12)))),
    ]);
  }

//weekly
  Widget weeklyScheduleWithTime() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text('Weekly Schedules!',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w900, color: textColor)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Days",
                textAlign: TextAlign.start,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: textColor)),
            const SizedBox(width: 60),
            Expanded(
                child: Text("leave empty for unavailability!",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: textColor)))
          ],
        ),

        //sunday
        buildDayRow("Sunday", sundayController, 27),
        //Monday
        buildDayRow("Monday", mondayController, 23),
        //Tuesday
        buildDayRow("Tuesday", tuesdayController, 20),
        //Wednesday
        buildDayRow("Wednesday", wednesdayController, 0),
        //Thursday
        buildDayRow("Thursday", thursdayController, 13),
        //friday
        buildDayRow("Friday", fridayController, 35),
        //saturday
        buildDayRow("Saturday", saturdayController, 16),

        const SizedBox(height: 15),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(19),
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
              setState(() {});
              //
            },
            child: const Text(
              "Save weekly Dates...",
              style: TextStyle(color: Colors.white),
            )),
        const SizedBox(height: 29)
      ],
    );
  }

//specific
  Widget buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: Colors.teal[800],
        weekdayLabelTextStyle:
            TextStyle(color: textColor, fontWeight: FontWeight.bold),
        controlsTextStyle: TextStyle(
            color: textColor, fontSize: 15, fontWeight: FontWeight.bold),
        dayTextStyle: TextStyle(color: textColor));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text('Override A Specific Date?',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w900, color: textColor)),
        CalendarDatePicker2(
            config: config,
            value: _rangeDatePickerValueWithDefaultValue,
            onValueChanged: (dates) =>
                setState(() => _rangeDatePickerValueWithDefaultValue = dates)),
        Text('Enter override time(s), leave empty for unavailability!',
            style: TextStyle(color: textColor)),
        TextField(
            controller: overrideController,
            decoration: const InputDecoration(
                hintText: "1200, 1400, 1430-1500",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(12))),
        const SizedBox(height: 12),
        SizedBox(
            height: (overridedDates.length *
                (MediaQuery.of(context).size.height * 0.1)),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: overridedDates.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading:
                      const Icon(Icons.lock_clock_outlined), // Icon on the left
                  title: Text("Date: ${overridedDates[index]['date']!}",
                      style: TextStyle(color: textColor)),
                  subtitle: Text("Time: ${overridedDates[index]['time']!}",
                      style: TextStyle(color: textColor)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: textColor),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          overridedDates.removeWhere((map) =>
                              map['date'] == overridedDates[index]['date']! &&
                              map['time'] == overridedDates[index]['time']!);
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
            onPressed: () {},
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
