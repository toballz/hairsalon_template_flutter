import 'package:flutter/material.dart';
import 'package:webclient/h.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  StatisticsPageState createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: 250, // Adjust width as needed
                      height: 150, // Adjust height as needed
                      color: tabColor,
                      margin: const EdgeInsets.only(right: 8),
                      child: const Column(
                        children: [
                          Text("This month",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 19)),
                          SizedBox(height: 12),
                          Row(children: [
                            Text("Gross"),
                            Spacer(),
                            Text("\$12322.23")
                          ]),
                          Row(children: [
                            Text("Estimated Tax"),
                            Spacer(),
                            Text("- \$12322.23")
                          ]),
                          Row(children: [
                            Text("Payment %"),
                            Spacer(),
                            Text("- \$12322.23")
                          ]),
                          Row(children: [
                            Text("Net"),
                            Spacer(),
                            Text("\$11322.23")
                          ])
                        ],
                      ),
                    ),
                    Container(
                      width: 150, // Adjust width as needed
                      height: 150, // Adjust height as needed
                      color: Colors.green,
                      margin: const EdgeInsets.all(8),
                      child: const Text("Lastmonth income"),
                    ),
                    Container(
                      width: 150, // Adjust width as needed
                      height: 150, // Adjust height as needed
                      color: Colors.blue,
                      margin: const EdgeInsets.all(8),
                    ),
                    // Add more containers as needed
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 12),
              const Text("Top 5 hairstyle",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
              const SizedBox(height: 12),
              Column(children: [
                Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 21),
                    color: Tools.colorShuttle['tabcolor1'],
                    child: const Row(
                        children: [Text("Net"), Spacer(), Text("\$11322.23")]))
              ])
            ]),
          ),
        ));
  }
}

//
//
//
//
//
//
// 