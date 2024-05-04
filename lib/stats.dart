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
    return Scaffold(
        appBar: AppBar(title: Text(Site.domain)),
        body:  Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child:   SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(children: [
              SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Container(
                width: 150, // Adjust width as needed
                height: 150, // Adjust height as needed
                color: Colors.red,
                margin: EdgeInsets.all(8),child: Text("Todays income"),
              ),
              Container(
                width: 150, // Adjust width as needed
                height: 150, // Adjust height as needed
                color: Colors.green,
                margin: EdgeInsets.all(8),child: Text("Lastmonth income"),
              ),
              Container(
                width: 150, // Adjust width as needed
                height: 150, // Adjust height as needed
                color: Colors.blue,
                margin: EdgeInsets.all(8),
              ),
              // Add more containers as needed
            ],
          ),
        ),
const Divider(),





            ]),
          ),
        )) ;
  }
}

//
//
//
//
//
//
// 