import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

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

  //
  //
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime(2024, 5, 6),
    DateTime(2024, 5, 21),
  ];
//
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Set Availability"),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              weeklyScheduleWithTime(),
              buildDefaultRangeDatePickerWithValue(),
            ]),
          ),
        ));
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
              controller: textcontrolller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: '1200-1500 1400-1600',
                  contentPadding: EdgeInsets.all(12)))),
    ]);
  }

//weekly
  Widget weeklyScheduleWithTime() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Weekly Schedules!'),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Days",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 60),
            Expanded(
                child: Text("0900-0930, 1130-1230, 1300-1330",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold)))
          ],
        ),

        //sunday
        buildDayRow("Sunday", sundayController, 30),
        //Monday
        buildDayRow("Monday", mondayController, 25),
        //Tuesday
        buildDayRow("Tuesday", tuesdayController, 20),
        //Wednesday
        buildDayRow("Wednesday", wednesdayController, 0),
        //Thursday
        buildDayRow("Thursday", thursdayController, 15),
        //friday
        buildDayRow("Friday", fridayController, 35),
        //saturday
        buildDayRow("Saturday", saturdayController, 20),

        const SizedBox(height: 15),
        ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.only(
                      left: 32, right: 32, top: 16, bottom: 16),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            onPressed: () {},
            child: const Text("Save These Dates...")),
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
        const Text('Override A Specific Date?'),
        CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selection(s):  '),
            const SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _rangeDatePickerValueWithDefaultValue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
