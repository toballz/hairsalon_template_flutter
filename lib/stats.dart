import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webclient/h.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  StatisticsPageState createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  ///beginingOfThisMonth, lastMonth, allToDate
  Map<String, dynamic>? countStaeeiwts = {
    "beginingOfThisMonth": 0,
    "lastMonth": 0,
    "allToDate": 0
  };
  int thisMonthGross = 0;
  double thisMonthEstimatedTax = 0;
  double thisMonthNet = 0;
  //
  int lastMonthGross = 0;
  double lastMonthEstimatedTax = 0;
  double lastMonthNet = 0;
  //
  int allMonthGross = 0;
  double allMonthEstimatedTax = 0;
  double allMonthNet = 0;

  void getHttpPosters() async {
    var d = await Tools.httpPost({'v': '1', 'stats': "", 'sg': "0"});
    setState(() {
      countStaeeiwts = jsonDecode(d.body);
      print(countStaeeiwts);

      thisMonthGross = int.parse(countStaeeiwts!['beginingOfThisMonth']) * 50;
      thisMonthEstimatedTax = thisMonthGross - (thisMonthGross * 0.7);
      thisMonthNet = thisMonthGross - thisMonthEstimatedTax;
      //
      lastMonthGross = int.parse(countStaeeiwts!['lastMonth']) * 50;
      lastMonthEstimatedTax = lastMonthGross - (lastMonthGross * 0.7);
      lastMonthNet = lastMonthGross - lastMonthEstimatedTax;
      //
      allMonthGross = int.parse(countStaeeiwts!['allToDate']) * 50;
      allMonthEstimatedTax = allMonthGross - (allMonthGross * 0.7);
      allMonthNet = allMonthGross - allMonthEstimatedTax;
    });
  }

  @override
  void initState() {
    super.initState();
    getHttpPosters();
  }
//

  @override
  Widget build(BuildContext context) {
    Color? bgColor = Tools.themeDark
        ? Tools.colorShuttle['bgcolorDark']
        : Tools.colorShuttle['bgcolorLight'];
    Color? tabColor = Tools.themeDark
        ? Tools.colorShuttle['tabcolorDark']
        : Tools.colorShuttle['tabcolorLight'];
    Color? textColor = Tools.themeDark
        ? Tools.colorShuttle['textcolorDark']
        : Tools.colorShuttle['textcolorLight'];

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(title: Text(Site.domain)),
        body: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    TabletAiiStats(
                        titleo: "This Month",
                        tabcoloro: tabColor!,
                        grosso: thisMonthGross,
                        etaxo: thisMonthEstimatedTax,
                        neto: thisMonthNet),

                    TabletAiiStats(
                      titleo: "Last Month",
                      tabcoloro: tabColor,
                      grosso: lastMonthGross,
                      etaxo: lastMonthEstimatedTax,
                      neto: lastMonthNet,
                    ),
                    TabletAiiStats(
                      titleo: "All till date",
                      tabcoloro: tabColor,
                      grosso: allMonthGross,
                      etaxo: allMonthEstimatedTax,
                      neto: allMonthNet,
                    )
                    // Add more containers as needed
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 12),
              Text("Top 5 hairstyle Booked",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: textColor)),
              const SizedBox(height: 12),
              Column(children: [
                Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 21),
                    color: tabColor,
                    child: const Row(
                        children: [Text("Net"), Spacer(), Text("\$11322.23")]))
              ])
            ]),
          ),
        ));
  }
}

//
class TabletAiiStats extends StatelessWidget {
  final String titleo;
  final Color tabcoloro;
  final int grosso;
  final double etaxo;
  final double neto;

  const TabletAiiStats(
      {super.key,
      required this.titleo,
      required this.tabcoloro,
      required this.grosso,
      required this.etaxo,
      required this.neto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 250, // Adjust width as needed
      height: 150, // Adjust height as needed
      color: tabcoloro,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          Text(titleo,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: Colors.white)),
          const SizedBox(height: 12),
          Row(children: [
            const Text("Gross", style: TextStyle(color: Colors.white)),
            const Spacer(),
            Text("\$${NumberFormat("#,##0.00", "en_US").format(grosso)}",
                style: const TextStyle(color: Colors.white))
          ]),
          Row(children: [
            const Text("Estimated Tax", style: TextStyle(color: Colors.white)),
            const Spacer(),
            Text("- \$${NumberFormat("#,##0.00", "en_US").format(etaxo)}",
                style: const TextStyle(color: Colors.white))
          ]),
          const Row(children: [
            Text("Payments %", style: TextStyle(color: Colors.white)),
            Spacer(),
            Text("\$50.00 each", style: TextStyle(color: Colors.white))
          ]),
          Row(children: [
            const Text("Net", style: TextStyle(color: Colors.white)),
            const Spacer(),
            Text("\$${NumberFormat("#,##0.00", "en_US").format(neto)}",
                style: const TextStyle(color: Colors.white))
          ])
        ],
      ),
    );
  }
}
