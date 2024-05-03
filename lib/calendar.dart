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
      Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
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
        const Text('Weekly Schedules!',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Days",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 60),
            Expanded(
                child: Text("leave empty for unavailability!",
                    textAlign: TextAlign.start))
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
                padding: const EdgeInsets.all(14),
                minimumSize: const Size.fromHeight(40)),
            onPressed: () {},
            child: const Text("Save weekly Dates...")),
        const SizedBox(height: 35)
      ],
    );
  }

//specific
  Widget buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.teal[800],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Override A Specific Date?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
        CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        ),
        const Text('Enter override time(s), leave empty for unavailability!'),
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
                  title: Text("Date: ${overridedDates[index]['date']!}"),
                  subtitle: Text("Time: ${overridedDates[index]['time']!}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
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
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                padding: const EdgeInsets.all(14)),
            child: const Text("Add Override")),
        const SizedBox(height: 25)
      ],
    );
  }
}
