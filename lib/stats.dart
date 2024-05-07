import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webclient/h.dart';
import 'package:webclient/messages_notifications.dart';

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
  List<dynamic>? popularHairstyleBooked = [];

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
    String beginingOfMonth =
        "${Tools.todayDate.year}${Tools.todayDate.month.toString().padLeft(2, '0')}${Tools.todayDate.day.toString().padLeft(2, '0')}";

    DateTime bolms = DateTime(
        (Tools.todayDate.month == 1
            ? Tools.todayDate.year - 1
            : Tools.todayDate.year),
        (Tools.todayDate.month - 1 == 0 ? 12 : Tools.todayDate.month - 1),
        01);
    String beginingOfLastMonth =
        "${bolms.year}${bolms.month.toString().padLeft(2, '0')}${bolms.day.toString().padLeft(2, '0')}";
    //print(beginingOfLastMonth);

    var d = await Tools.httpPost({
      'v': '1',
      'stats': "",
      'beginingOfThisMonth': beginingOfMonth,
      'beginingOfLastMonth': beginingOfLastMonth,
      'sg': "0"
    });
    if (mounted) {
      setState(() {
        countStaeeiwts = jsonDecode(d.body);
        popularHairstyleBooked = countStaeeiwts!['popularHairstyleBooked'];
        //print(countStaeeiwts);

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
  }

  @override
  void initState() {
    super.initState();
    getHttpPosters();
  }
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallette.backgroundColor(),
        appBar: AppBar(
            backgroundColor: ColorPallette.backgroundColor(),
            title: Text(Site.getCurrentUserDomain,
                style:
                    TextStyle(fontSize: 17, color: ColorPallette.fontColor())),
            actions: [
              Stack(children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MessagesNotification(),
                          ));
                    },
                    icon: Icon(Icons.message_outlined,
                        size: 32,
                        color: ColorPallette.fontColor())), // Your icon
                Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: const Text('5', // Your number
                            style:
                                TextStyle(color: Colors.white, fontSize: 12))))
              ])
            ]),
        body: Align(
            alignment: Alignment.topCenter,
            child: Container(
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
                            grosso: thisMonthGross,
                            etaxo: thisMonthEstimatedTax,
                            neto: thisMonthNet),

                        TabletAiiStats(
                          titleo: "Last Month",
                          grosso: lastMonthGross,
                          etaxo: lastMonthEstimatedTax,
                          neto: lastMonthNet,
                        ),
                        TabletAiiStats(
                          titleo: "All till date",
                          grosso: allMonthGross,
                          etaxo: allMonthEstimatedTax,
                          neto: allMonthNet,
                        )
                        // Add more containers as needed
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text("Top 5 hairstyle Booked",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: ColorPallette.fontColor())),
                  const SizedBox(height: 12),
                  Column(children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: popularHairstyleBooked!.length,
                      itemBuilder: (BuildContext context, int o) {
                        return ListTile(
                          leading: Image(
                              width: 45,
                              image: NetworkImage(
                                  "https://${Site.getCurrentUserDomain}/img/${popularHairstyleBooked![o]['image']}.jpg?93jv")), // Icon on the left
                          title: Text(popularHairstyleBooked![o]['hairstyle'],
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: ColorPallette.fontColor())),
                          subtitle: Text(
                              "${popularHairstyleBooked![o]['appearance_count']}: people booked this",
                              style:
                                  TextStyle(color: ColorPallette.fontColor())),
                          onTap: () {},
                        );
                      },
                    ),
                  ])
                ]),
              ),
            )));
  }
}

//
class TabletAiiStats extends StatelessWidget {
  final String titleo;
  final int grosso;
  final double etaxo;
  final double neto;

  const TabletAiiStats(
      {super.key,
      required this.titleo,
      required this.grosso,
      required this.etaxo,
      required this.neto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15, bottom: 17, left: 2),
      padding: const EdgeInsets.all(12),
      width: 250,
      height: 180,
      decoration: BoxDecoration(
        color: ColorPallette.tabColor(),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(4, 6), // changes position of shadow
          ),
        ],
      ),
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
          const SizedBox(height: 12),
          Row(children: [
            const Text("Estimated Tax", style: TextStyle(color: Colors.white)),
            const Spacer(),
            Text("- \$${NumberFormat("#,##0.00", "en_US").format(etaxo)}",
                style: const TextStyle(color: Colors.redAccent))
          ]),
          const SizedBox(height: 12),
          const Row(children: [
            Text("Payments/Person", style: TextStyle(color: Colors.white)),
            Spacer(),
            Text("\$50.00", style: TextStyle(color: Colors.blueAccent))
          ]),
          const SizedBox(height: 12),
          Row(children: [
            const Text("Net", style: TextStyle(color: Colors.white)),
            const Spacer(),
            Text("\$${NumberFormat("#,##0.00", "en_US").format(neto)}",
                style: const TextStyle(color: Colors.greenAccent))
          ])
        ],
      ),
    );
  }
}
